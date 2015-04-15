//
//  B5MEncrept.h
//  micker
//
//  Created by allen.wang on 9/15/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B5MEncrept : NSObject

+ (id) instance;

+ (NSString*) base64Encode:(const NSData *)data;

- (NSString *) encrypt:(NSString *) plainText;

@end
