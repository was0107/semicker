//
//  WASDataBase.m
//  micker
//
//  Created by allen.wang on 10/10/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASDataBase.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "FileManager.h"
#import "B5MUtility.h"

#define KDataBaseName           @"B5MDB.db"
#define kDeaultUserName         @"ALLEN"

#pragma mark - private
#pragma mark WASDataBase

@interface WASDataBase() {
    FMDatabase *_dataBase;
}
@property (nonatomic, retain ) NSMutableDictionary *propertyDic;

- (NSString *) sqliteType:(NSString *)stringType;

- (NSString *) getPropertyType:(NSString *)attributeString;

- (NSMutableDictionary *) typeDic:(id)content;

- (id) initWithDBPath:(NSString *) dbPath;

- (void) createTableWith:(id) content;

@end

#pragma mark - implementation
#pragma mark - WASDataBase

@implementation WASDataBase
@synthesize userName    = _userName;
@synthesize tableName   = _tableName;
@synthesize propertyDic = _propertyDic;

+ (WASDataBase*)sharedDBHelpter {
    static dispatch_once_t once;
    static WASDataBase *sharedDB;
    dispatch_once(&once, ^ {
        NSString *dbPath = [NSString stringWithFormat:@"%@/%@",[FileManager dbPath], KDataBaseName];
        sharedDB = [[WASDataBase alloc] initWithDBPath:dbPath]; 
        sharedDB.userName = kDeaultUserName;
    });
    return sharedDB;
}


- (id) initWithDBPath:(NSString *) dbPath
{
    self = [super init];
    if (self) {
        _dataBase = [[FMDatabase databaseWithPath:dbPath] retain];
    }
    return self;
}

- (void) dealloc
{
    if ([_dataBase open]) {
        [_dataBase close];
    }
    [_userName release], _userName = nil;
    [_tableName release],_tableName= nil;
    [_propertyDic release], _propertyDic = nil;
    [_dataBase release], _dataBase = nil;
    [super dealloc];
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


- (NSString *) sqliteType:(NSString *)stringType
{
    if ([stringType isEqualToString:@"NSString"])
        return @"TEXT";
    if ([stringType isEqualToString:@"int"])
        return @"INTEGER";
    return @"";
}

- (BOOL) validateDB
{
    if (![_dataBase open]) 
    {
        ERRLOG(@"data base open error!");
        [_dataBase close];
        return NO;
    }
    if (!self.tableName) {
        ERRLOG(@"tableName is nil!");
        return NO;
    }
    return YES;
}

- (BOOL) validateDataBase:(id) content
{
    if (![self validateDB]) 
    {
        return NO;
    }
    
    if (![content isKindOfClass:[NSObject class]]) {
        ERRLOG(@"content must be a NSObject object!");
        return NO;
    }
    return YES;
}

- (void) createTableWith:(id) content
{
    if (![self validateDataBase:content]) {
        return;
    }
    self.propertyDic =  [self typeDic:content];

    NSMutableString *stringCreateTable = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (",self.tableName];
    for (NSString *key in [self.propertyDic allKeys]) {
        [stringCreateTable appendFormat:@"%@ %@,", key, [self sqliteType:[self.propertyDic  objectForKey:key]]];
    }
    if (self.userName) {
        [stringCreateTable appendFormat:@"%@ %@,", @"USER", @"TEXT"];
    }
    [stringCreateTable appendString:@"addedDate REAL)"];
    
    
    [_dataBase beginTransaction];
    [_dataBase executeUpdate:stringCreateTable];
    [_dataBase commit];

}


- (void) insertItem:(id)content with:(NSString *) key value:(NSString *) value
{
    if (![self validateDataBase:content])
        return;
    
    if ([self isExistItemWithKey:key value:value]) {
        [self deleteWith:content key:key value:value];
        //return;
    }
    
    [self createTableWith:content];
    
    // insert value
    NSMutableString *stringInsertTable = [NSMutableString stringWithFormat:@"INSERT INTO %@ (",self.tableName];
    for (NSString *key in [self.propertyDic allKeys]) {
        [stringInsertTable appendFormat:@"%@, ",key];
    }
    if (self.userName) {
        [stringInsertTable appendFormat:@"%@ ,", @"USER"];
    }
    [stringInsertTable appendString:@"addedDate ) VALUES ("];
    
    for (NSString *key in [self.propertyDic allKeys]) {
        
        //NSInvocation调用  
        SEL mySelector = NSSelectorFromString(key);  
        NSMethodSignature * sig = [[content class]   
                                   instanceMethodSignatureForSelector: mySelector];  
        
        NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature: sig];  
        [myInvocation setTarget: content];  
        [myInvocation setSelector: mySelector];  
        
        if ([@"int" isEqualToString:[self.propertyDic  objectForKey:key]]) {
            int result = 0;
            [myInvocation invoke];  
            [myInvocation getReturnValue: &result]; 
            [stringInsertTable appendFormat:@"%d, ",result];
        }
        else {
            NSString * result = nil;      
            [myInvocation invoke];  
            [myInvocation getReturnValue: &result];              
            [stringInsertTable appendFormat:@"\"%@\", ",result]; 
        }       
    }
    
    if (self.userName) {
        [stringInsertTable appendFormat:@"\"%@\",", self.userName];
    }
    
    [stringInsertTable appendFormat:@"%f)" ,[[NSDate date] timeIntervalSince1970]];
    
    [_dataBase beginTransaction];
    BOOL result = [_dataBase executeUpdate:stringInsertTable];
    [_dataBase commit];
    
    if (!result) {
        WARNLOG(@"insert record error !");
    }
    
}

- (BOOL) isExistItemWithKey:(NSString *) key  value:(NSString *) value
{
    if (![self validateDB]) 
        return NO;
    NSString *stringQuery = nil;    
    if (self.userName) {
        stringQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER = \"%@\" AND  \"%@\" = \"%@\"",self.tableName, self.userName,key,value];
    }
    else {
        stringQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  \"%@\" = \"%@\"",self.tableName,key,value];
    }
    FMResultSet *rs = [_dataBase executeQuery:stringQuery];
    return ([rs next])?YES:NO;
}

- (void) deleteWith:(id)content key:(NSString *) key value:(NSString *) value
{
    if (![self validateDB]) 
        return;
    
    NSString *deleteSQL  = nil;
    
    if (self.userName) {
        deleteSQL  = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER = \"%@\" AND  \"%@\" = \"%@\"", self.tableName,self.userName,key,value];   
    }
    else {
        deleteSQL  = [NSString stringWithFormat:@"DELETE FROM %@ WHERE  \"%@\" = \"%@\"", self.tableName,key,value];  
    }
    
    [_dataBase beginTransaction];
    BOOL result = [_dataBase executeUpdate:deleteSQL];
    [_dataBase commit];
    
    if (!result) {
        WARNLOG(@"insert record error !");
    }
}

- (void) deleteAll:(id) content
{
    if (![self validateDB])
        return;
    
    NSString *deleteSQL  = nil;
    
    if (self.userName) {
        deleteSQL  = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER = \"%@\"", self.tableName,self.userName];
    }
    else {
        deleteSQL  = [NSString stringWithFormat:@"DELETE FROM %@", self.tableName];
    }
    
    [_dataBase beginTransaction];
    BOOL result = [_dataBase executeUpdate:deleteSQL];
    [_dataBase commit];
    
    if (!result) {
        WARNLOG(@"delete all record error !");
    }
}


- (NSMutableArray *) getAllData
{
    NSMutableArray *resultArray = [NSMutableArray array];

    if (![self validateDB]) 
        return resultArray;
    
    NSString *resultSQL = nil;

    if (self.userName) {
        resultSQL  = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER = \"%@\" ORDER BY ADDEDDATE DESC", self.tableName,self.userName];   
    }
    else {
        resultSQL  = [NSString stringWithFormat:@"DELETE FROM %@ WHERE  1 = 1  ORDER BY ADDEDDATE DESC", self.tableName];  
    }
    
    FMResultSet *rs = [_dataBase executeQuery:resultSQL];
    while ([rs next]){
       [resultArray addObject:[rs resultDictionary]];
    }
    [rs close];
    
    return resultArray;
}

- (BOOL) isExistKey:(NSString *) key value:(NSString *) value
{
    if (![self validateDB] || !key || !value)
        return NO;
    
    NSString *resultSQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER = \"%@\" AND %@ = \"%@\" ", self.tableName,self.userName,key, value];
    FMResultSet *rs = [_dataBase executeQuery:resultSQL];
    if ([rs next]) {
        [rs close];
        return YES;
    } 
    [rs close];
    return NO;
}

@end
