//
//  NSObject+Block.h
//  micker
//
//  Created by allen.wang on 6/28/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^VoidBlockEx)();

@interface NSObject (Block)

- (void) performBlock:(VoidBlockEx) block;
- (void) performBlock:(VoidBlockEx) block afterDelay:(NSTimeInterval) delay;

@end
