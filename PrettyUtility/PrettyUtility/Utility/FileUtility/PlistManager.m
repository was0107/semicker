//
//  PlistManager.m
//  micker
//
//  Created by Allen on 5/21/11.
//  Copyright (c) 2012 b5m. All rights reserved.
//
#import "PlistManager.h"

@implementation PlistManager

@synthesize sourceData = sourceData_;

static PlistManager *plistInstance = nil;

+ (PlistManager *)plistManagerInstance 
{
    @synchronized(self) 
    {
		if (plistInstance == nil) 
        {
			plistInstance = [[PlistManager alloc] init];            
		}
		return plistInstance;
	}
}

- (NSDictionary *)getAllData 
{
    return sourceData_;
}

- (NSUInteger)getKeysCount 
{
    return [sourceData_  count];
}

- (NSUInteger)getKeyCount:(NSString *)key 
{
    return [[self getDataWithKey:key] count];
}

- (void)readDataFromPlist:(NSString *)fileName 
{
    NSString *documentsDirectory = [[NSBundle mainBundle] resourcePath];
    self.sourceData = [NSMutableDictionary dictionaryWithContentsOfFile:
                       [documentsDirectory stringByAppendingPathComponent:fileName]];
}

- (id)getDataWithKey:(NSString *)key1 
{
    return [sourceData_ objectForKey:key1];
}

- (id)getDataWithKey:(NSString *)key1  withKey:(NSString *)key2 
{
    return [[sourceData_ objectForKey:key1] objectForKey:key2];
}

- (id)getDataWithKey:(NSString *)key1  withKey:(NSString *)key2  withKey:(NSString *)key3 
{    
    return [[[sourceData_ objectForKey:key1] objectForKey:key2] objectForKey:key3];
}

- (id)getKey1:(NSUInteger) index1 
{
    return [[sourceData_ allKeys] objectAtIndex:index1];
}

- (void)dealloc 
{
    TT_RELEASE_SAFELY(sourceData_);
    [super dealloc];
}

@end
