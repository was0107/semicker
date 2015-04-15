//
//  NSString+util.m
//  micker
//
//  Created by allen.wang on 9/26/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "NSString+util.h"

B5M_FIX_CATEGORY_BUG(NSStringutil)


@implementation NSString (util)
- (bool)isEmpty {
    return self.length == 0;
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *)numericValue {
    return [NSNumber numberWithInt:[self intValue]];
}
@end
