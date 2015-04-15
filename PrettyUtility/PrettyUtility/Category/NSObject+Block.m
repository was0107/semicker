//
//  NSObject+Block.m
//  micker
//
//  Created by allen.wang on 6/28/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "NSObject+Block.h"

B5M_FIX_CATEGORY_BUG(NSObjectBlock)


@implementation NSObject (Block)

-(void) callBlock:(VoidBlockEx) block
{
    if (block) {
        block();
    }
}

- (void) performBlock:(VoidBlockEx) aBlock
{
    [self performSelector:@selector(callBlock:) withObject:[[aBlock copy] autorelease]];
}

- (void) performBlock:(VoidBlockEx) aBlock afterDelay:(NSTimeInterval) delay
{
    [self performSelector:@selector(callBlock:) withObject:[[aBlock copy] autorelease] afterDelay:delay];
}

@end
