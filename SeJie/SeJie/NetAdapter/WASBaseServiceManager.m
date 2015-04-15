//
//  WASBaseServiceManager.m
// sejieios
//
//  Created by allen.wang on 1/14/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "WASBaseServiceManager.h"

@implementation WASBaseServiceManager

- (id)init
{
    self = [super init];
    if (self)
    {
        memCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (WASBaseServiceManager *)sharedRequestInstance
{
    static dispatch_once_t  onceToken;
    static WASBaseServiceManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WASBaseServiceManager alloc] init];
    });
    return sharedInstance;
}

- (void) dealloc
{
    [memCache removeAllObjects];
    TT_RELEASE_SAFELY(memCache);
    [super dealloc];
}

- (void) store:(id) content forKey:(NSString *)key
{
    if (!content || !key) {
        return;
    }
    [memCache setObject:content forKey:key];
}

- (void) removeKey:(NSString *) key
{
    [memCache removeObjectForKey:key];
}

- (id) requestForKey:(NSString *) key
{
    return [memCache objectForKey:key];
}
@end
