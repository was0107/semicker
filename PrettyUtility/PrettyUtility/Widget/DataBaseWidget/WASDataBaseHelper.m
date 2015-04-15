//
//  WASDataBaseHelper.m
//  micker
//
//  Created by allen.wang on 8/27/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASDataBaseHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "FileManager.h"

#define kDBTuanTableName        @"TUAN_TABLE"
#define kDBGoodsTableName       @"GOODS_TABLE"
#define kDBGuangTableName       @"GUANG_TABLE"
#define kDBHistoryTableName     @"HISTORY_TABLE"

#define KDataBaseName           @"B5MDB.db"
#define kDeaultUserName         @"ALLEN"

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

@interface WASDataBaseHelper()

- (NSString *) getPropertyType:(NSString *)attributeString;

- (NSMutableDictionary *) typeDic:(id)content;

- (NSString *) sqliteType:(NSString *)stringType;

+ (NSString *) getTableWithType:(NSUInteger) type;

- (void) createMainTable:(NSUInteger) type user:(NSString *) user key:(NSString *)docID dataBase:(FMDatabase *)dataBase;

- (void) insertMainTable:(NSUInteger) type user:(NSString *) user key:(NSString *)docID dataBase:(FMDatabase *)dataBase;

- (BOOL) isExist:(NSUInteger) type user:(NSString *) user key:(NSString *)docID dataBase:(FMDatabase *)dataBase;

- (void) createDataTable:(NSUInteger)type dic:(NSMutableDictionary *)dic dataBase:(FMDatabase *)dataBase;

- (void) InsertDataTable:(NSUInteger)type dic:(NSMutableDictionary *)dic content:(id)content dataBase:(FMDatabase *)dataBase;

- (void) addItemsToTable:(id) content key:(NSString *)key type:(NSUInteger) type user:(NSString *)user;

@end


@implementation WASDataBaseHelper

#pragma mark -- public

+ (WASDataBaseHelper*)sharedDBHelpter {
    static dispatch_once_t once;
    static WASDataBaseHelper *sharedDB;
    dispatch_once(&once, ^ { sharedDB = [[WASDataBaseHelper alloc] init]; });
    return sharedDB;
}

+ (void) addItemsToTable:(id) content key:(NSString *)key type:(NSUInteger) type
{
    [[WASDataBaseHelper sharedDBHelpter] addItemsToTable:content key:key type:type user:kDeaultUserName];
}

+ (void) addItemsToTable:(id) content key:(NSString *)key type:(NSUInteger) type user:(NSString *)user
{
    [[WASDataBaseHelper sharedDBHelpter] addItemsToTable:content key:key type:type user:user];
}

#pragma mark -- private


+ (NSString *) getTableWithType:(NSUInteger) type
{
    switch (type) {
        case 0:
            return kDBGoodsTableName;
            break;
        case 1:
            return kDBTuanTableName;
            break;
        case 2:
            return kDBGuangTableName;
            break;
            
        default:
            break;
    }
    return kDBGuangTableName;
}

- (NSString *) getPropertyType:(NSString *)attributeString
{
	NSString *type = [NSString string];
	NSScanner *typeScanner = [NSScanner scannerWithString:attributeString];
	[typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"] intoString:NULL];
    
	// we are not dealing with an object
	if([typeScanner isAtEnd]) {
        [typeScanner setScanLocation:0];
        
        [typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","] intoString:&type];
        
        if ([@"Ti" isEqualToString:type]) {
            return @"int";
        }
		return type;
	}
	[typeScanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"@"] intoString:NULL];
	[typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&type];
	return type;
}

- (void) createMainTable:(NSUInteger) type user:(NSString *) user key:(NSString *)docID dataBase:(FMDatabase *)dataBase
{
    // check tabls is exist
    NSMutableString *stringCreateTable = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ",kDBHistoryTableName];
    
    [stringCreateTable appendString:@"(USER TEXT, DOCID TEXT,TYPE INTEGER,ADDEDDATE REAL)"];
        
//    NSLog(@"create Main SQL = %@", stringCreateTable);
    
    [dataBase executeUpdate:stringCreateTable];
}

- (void) insertMainTable:(NSUInteger)type user:(NSString *) user key:(NSString *)docID dataBase:(FMDatabase *)dataBase
{
    NSMutableString *stringInsertTable = [NSMutableString stringWithFormat:@"INSERT INTO %@ ",kDBHistoryTableName];
    
    [stringInsertTable appendString:@"(USER, DOCID,TYPE,ADDEDDATE) VALUES"];
    
    [stringInsertTable appendFormat:@"(\"%@\",\"%@\",%d,%f)",user,docID,type,[[NSDate date] timeIntervalSince1970]];
    
//    NSLog(@"insert Main SQL = %@", stringInsertTable);
    
//    BOOL result =
    [dataBase executeUpdate:stringInsertTable];

//    DEBUGLOG(@"insert Main SQL = %@ result = %d", stringInsertTable, result);

    
}

- (BOOL) isExist:(NSUInteger) type user:(NSString *) user key:(NSString *)docID dataBase:(FMDatabase *)dataBase
{
    NSString *stringQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER = \"%@\" AND DOCID = \"%@\" AND TYPE = %d",kDBHistoryTableName, user,docID,type];
    FMResultSet *rs = [dataBase executeQuery:stringQuery];
//    FMDBQuickCheck(rs);
    return ([rs next])?YES:NO;
}

- (void)createDataTable:(NSUInteger)type dic:(NSMutableDictionary *)dic dataBase:(FMDatabase *)dataBase
{
    // check tabls is exist
    NSMutableString *stringCreateTable = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (",[[self class] getTableWithType:type]];
    for (NSString *key in [dic allKeys]) {
        [stringCreateTable appendFormat:@"%@ %@,", key, [self sqliteType:[dic  objectForKey:key]]];
    }
    [stringCreateTable appendString:@"addedDate REAL)"];
    
//    DEBUGLOG(@"create SQL = %@", stringCreateTable);
    
    [dataBase executeUpdate:stringCreateTable];
}

- (void)InsertDataTable:(NSUInteger)type dic:(NSMutableDictionary *)dic content:(id)content dataBase:(FMDatabase *)dataBase
{
    // insert value
    
    NSMutableString *stringInsertTable = [NSMutableString stringWithFormat:@"INSERT INTO %@ (",[[self class] getTableWithType:type]];
    for (NSString *key in [dic allKeys]) {
        [stringInsertTable appendFormat:@"%@, ",key];
    }
    [stringInsertTable appendString:@"addedDate ) VALUES ("];
    
    for (NSString *key in [dic allKeys]) {
        
        //NSInvocation调用  
        SEL mySelector = NSSelectorFromString(key);  
        NSMethodSignature * sig = [[content class]   
                                   instanceMethodSignatureForSelector: mySelector];  
        
        NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature: sig];  
        [myInvocation setTarget: content];  
        [myInvocation setSelector: mySelector];  
        
        if ([@"int" isEqualToString:[dic  objectForKey:key]]) {
            int result = 0;
            [myInvocation invoke];  
            [myInvocation getReturnValue: &result];  
//            NSLog(@"The value %@ = %d",key, result);  
            
            [stringInsertTable appendFormat:@"%d, ",result];
        }
        else {
            NSString * result = nil;      
            [myInvocation invoke];  
            [myInvocation getReturnValue: &result];  
//            NSLog(@"The value:  %@ = %@",key, result);  
            
            [stringInsertTable appendFormat:@"\"%@\", ",result]; 
        }       
    }
    
    [stringInsertTable appendFormat:@"%f)" ,[[NSDate date] timeIntervalSince1970]];
//    NSLog(@"stringInsertTable = %@", stringInsertTable);
    BOOL result = [dataBase executeUpdate:stringInsertTable];
    if (!result) {
        DEBUGLOG(@"insert record error !");
    }
}

- (void) addItemsToTable:(id) content key:(NSString *)key type:(NSUInteger) type user:(NSString *)user
{
    NSMutableDictionary *dic  =  [self typeDic:content];
    
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@",[FileManager dbPath], KDataBaseName];
    
    DEBUGLOG(@"db path = %@", dbPath);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (![dataBase open]) 
    {
        DEBUGLOG(@"data base open error!");
        [dataBase close];
        return;
    }
    
    [dataBase beginTransaction];
    [self createMainTable:type user:user key:key dataBase:dataBase];
    
    if (![self isExist:type user:user key:key dataBase:dataBase]) {
        [self insertMainTable:type user:user key:key dataBase:dataBase];
        [self createDataTable:type dic:dic dataBase:dataBase];
        [self InsertDataTable:type dic:dic content:content dataBase:dataBase];
    }
    else {
        /*
        NSString *deleteHistorySQL  = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER = \"%@\" AND DOCID = \"%@\"", kDBHistoryTableName,user,key];
        NSString *deleteGoodsSQL    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE DOCID = \"%@\"", kDBGoodsTableName,key];
        [dataBase executeUpdate:deleteGoodsSQL];
        [dataBase executeUpdate:deleteHistorySQL];
         */
    }
    [dataBase commit];
    
    [dataBase close];
}

+ (void) deleteWithKey:(NSString *) key withType:(NSUInteger) type
{
    [self deleteWithKey:key withType:type user:kDeaultUserName];
}

+ (void) deleteWithKey:(NSString *) key  withType:(NSUInteger) type user:(NSString *) user
{
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@",[FileManager dbPath], KDataBaseName];
    DEBUGLOG(@"db path = %@", dbPath);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (![dataBase open]) 
    {
        DEBUGLOG(@"data base open error!");
        [dataBase close];
        return;
    }
    [dataBase beginTransaction];
    NSString *deleteHistorySQL  = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER = \"%@\" AND DOCID = \"%@\"", kDBHistoryTableName,user,key];
    NSString *deleteGoodsSQL    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE DOCID = \"%@\"",  [[self class] getTableWithType:type],key];
    [dataBase executeUpdate:deleteGoodsSQL];
    [dataBase executeUpdate:deleteHistorySQL];
    [dataBase commit];
    [dataBase close];

}


- (NSString *) sqliteType:(NSString *)stringType
{
    if ([stringType isEqualToString:@"NSString"])
        return @"TEXT";
    if ([stringType isEqualToString:@"int"])
        return @"INTEGER";
    return @"";
}


- (NSMutableDictionary *) typeDic:(id)content
{
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    Class class = [content class];
    do {
        NSString *stringClass = NSStringFromClass(class);
        id LenderClass      = objc_getClass([stringClass cStringUsingEncoding:NSUTF8StringEncoding]);
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *type = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            NSString *propName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *object = [self getPropertyType:type];
            if (![object isEqualToString:@"NSArray"]) {
                [dic setObject:[self getPropertyType:type] forKey:propName];
            }
        }

    } while ((class = class_getSuperclass(class)) != [NSObject class]);
    
    return dic;
}

+ (NSMutableArray *) getDataFrom:(NSUInteger) type
{
    return [self getDataFrom:type user:kDeaultUserName];
}

+ (NSMutableArray *) getDataFrom:(NSUInteger) type user:(NSString *)user
{
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@",[FileManager dbPath], KDataBaseName];
        
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (![dataBase open]) 
    {
        DEBUGLOG(@"data base open error!");
        [dataBase close];
        return nil;
    }
    NSMutableArray *resultArray = [NSMutableArray array];
    NSString *historySQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER = \"%@\" AND TYPE = %d ORDER BY ADDEDDATE DESC",kDBHistoryTableName,user,type];
    
    FMResultSet *rs = [dataBase executeQuery:historySQL];
    while ([rs next]){
        NSString *docid    = [rs stringForColumn:@"docid"];;
        NSString *goodsSQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE DOCID = \"%@\"", [[self class] getTableWithType:type],docid];
        FMResultSet *goods = [dataBase executeQuery:goodsSQL];
        while ([goods next]) {
            [resultArray addObject:[goods resultDictionary]];
//            NSLog(@"[goods resultDictionary] = %@",[goods resultDictionary]);
        }
    }
    [rs close];
    [dataBase close]; 
    
    return resultArray;
}



@end
