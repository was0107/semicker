//
//  B5MCacheManager.m
//  micker
//
//  Created by allen.wang on 6/11/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "B5MCacheManager.h"
//#import "ModuleURLDef.h"
#import "FileManager.h"
#import "B5MUtility.h"
#import "globalDefine.h"

static B5MCacheManager *sharedB5MCacheManager = nil;

@interface B5MCacheManager() 

/**
 * @brief init the storeArray and cacheDictionay
 *
 * 
 * @param [in]  N/A          
 * @param [out] N/A    
 * @return     void
 * @note
 */
- (void) setUpData;

- (NSString *) keyValue:(NSString *) key;


@end


@implementation B5MCacheManager
@synthesize cacheDictionary;
@synthesize storedArray;
@synthesize enableExtendInfo;

+ (B5MCacheManager *) sharedCacheManager { 
    
    @synchronized(self)
    {     
        if (!sharedB5MCacheManager)
        {          
            sharedB5MCacheManager = [[self alloc] init];  
            [sharedB5MCacheManager setUpData];
        }   
    }
    return sharedB5MCacheManager; 
}

- (void) setUpData
{
    NSString     *filePath = [self dataFilePath];
                             
    if([FileManager isExistFile:filePath])
        cacheDictionary   = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    else {
        cacheDictionary   = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    storedArray           = [[NSMutableArray alloc] initWithObjects:
//                             kSyncategory,
//                             kSearch,
//                             kBarcode,
//                             kAutofill,
//                             kDetail,
//                             kRegister,
//                             kBehavior,
//                             kLog,
//                             kISearch,
//                             kISubSearch,
//                             kPaging,
                             nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(didReceiveMemoryWarning) 
                                                 name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    // When in background, clean memory in order to have less chance to be killed
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackGround)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

}

- (void) releaseCacheManager
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self writeToFileForBackUp];
    TT_RELEASE_SAFELY(cacheDictionary);
    TT_RELEASE_SAFELY(storedArray);
    TT_RELEASE_SAFELY(sharedB5MCacheManager);
}

- (void) dealloc
{
    [self releaseCacheManager];
    [super dealloc];
}

- (NSString *) dataFilePath
{
    return [NSString stringWithFormat:@"%@/%@.plist",
            [FileManager downloadDataDirectory],
            [B5MUtility shortDateStringEx:[NSDate date]]];;
}


- (void) writeToFileForBackUp
{
    [FileManager deleteOldFiles];
    
    NSString     *filePath =[self dataFilePath];
    
    if (cacheDictionary && filePath) {
        if ([cacheDictionary writeToFile:filePath atomically:YES]) {
            INFOLOG(@"Cache data write to the file :%@ successfully.", filePath);
        }else {
            WARNLOG(@"Cache data write to the file :%@ failed.", filePath);
        }; 
    }
}

- (void) enterBackGround
{
    [self writeToFileForBackUp];
    [self didReceiveMemoryWarning];
}

- (NSString *) keyValue:(NSString *) key
{
    if (enableExtendInfo) {
//        return [NSString stringWithFormat:@"%@-%@-%@",
//                kIntToString([B5MUtility userGender]),
//                kIntToString([B5MUtility userAge]),
//                key];
        return key;
        //[NSString stringWithFormat:@"%@-%@-%@",
//                kIntToString([B5MUtility userGender]),
//                kIntToString([B5MUtility userAge]),
//                key];
    }
    return key;
}


- (BOOL) isNeedToStoreToCache:(NSString *) name
{
    if ([storedArray containsObject:name]) {
        return YES;
    }
    return NO;
}

- (BOOL) isContainKey:(NSString *) key
{
    if ([[cacheDictionary allKeys] containsObject: key]) {
        return YES;
    }
    return NO;
}

- (void) addItemToCache:(NSString *) key withContent:(id ) content
{
    NSString *keyEx = [self keyValue:key];
    if ([self isContainKey:keyEx]) {
        return ;
    }
//    [cache setObject:content forKey:keyEx];
    [cacheDictionary setObject:content forKey:keyEx];
}

- (void) removeItemWithKey:(NSString *) key
{
    NSString *keyEx = [self keyValue:key];

    if ([self isContainKey:keyEx]) {
        [cacheDictionary removeObjectForKey:keyEx];
        return ;
    }
}

- (id) getContentWithKey:(NSString *) key
{
    NSString *keyEx = [self keyValue:key];
    if ([self isContainKey:keyEx]) {
        return [cacheDictionary objectForKey:keyEx];
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [cacheDictionary removeAllObjects];
    
    DEBUGLOG(@"memory warning !");
}


@end
