//
//  WASBaseServiceManager.h
// sejieios
//
//  Created by allen.wang on 1/14/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASBaseServiceManager : NSObject
{
    NSMutableDictionary *memCache;
}

+ (WASBaseServiceManager *)sharedRequestInstance;

- (void) store:(id) content forKey:(NSString *)key;

- (void) removeKey:(NSString *) key;

- (id) requestForKey:(NSString *) key;
@end
