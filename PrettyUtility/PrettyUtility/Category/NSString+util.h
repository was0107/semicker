//
//  NSString+util.h
//  micker
//
//  Created by allen.wang on 9/26/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (util)

- (bool)isEmpty;
- (NSString *)trim;
- (NSNumber *)numericValue;
@end
