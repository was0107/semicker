//
//  NSURL+Extend.m
//  micker
//
//  Created by allen.wang on 8/6/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "NSURL+Extend.h"

#define parameterString             @"&"
#define parameterComparString       @"="

B5M_FIX_CATEGORY_BUG(NSURLExtend)


@implementation NSURL(Extend)

- (NSArray *) paramContents
{
    NSAssert(self,@"URL is NULL!");
    if (self.query) {
        NSRange range = [self.query rangeOfString:parameterString];
        if (range.location != NSNotFound) {
            return [self.query componentsSeparatedByString:parameterString];
        }
        else {
            return [NSArray arrayWithObject:self.query];
        }
    }
    return nil;
}

- (NSString*) valueWithKey:(const NSString *)key
{
    NSAssert(self,@"URL is NULL!");
    NSAssert(key, @"key is NULL!");
    NSAssert([key length],@"key is empty!");
    
    NSArray *array = [self paramContents];
    for (NSUInteger i = 0 ; i < [array count];i++) {
        
        NSString *content = [array objectAtIndex:i];
        NSRange range = [content rangeOfString:parameterComparString];
        NSString *keyTemp = nil;
        
        if (range.location != NSNotFound) {
            keyTemp = [content substringToIndex:range.location];
            if ([key isEqualToString:keyTemp]) {
                NSString *valTemp = [content  substringFromIndex:range.location + 1];
                return valTemp;
            }
        }
    }
    return @"";
}

@end
