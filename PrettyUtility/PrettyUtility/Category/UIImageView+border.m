//
//  UIImageView+border.m
//  PrettyUtility
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UIImageView+border.h"

@implementation UIImageView (border)

- (void) addEffect
{
//    dispatch_queue_t newQueue = NULL;
//    if(!newQueue)
//        newQueue = dispatch_queue_create("EFFECT", NULL);
//    
    __block UIImageView *blockSelf = self;
    
//    dispatch_async(newQueue, ^
//    {
        blockSelf.layer.cornerRadius = 2.0f;
        blockSelf.layer.masksToBounds = YES;
        blockSelf.layer.borderWidth = 1.8f;
        blockSelf.layer.borderColor  = [kWhiteColor CGColor];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [blockSelf setNeedsDisplay];
//        });
//    });
}
@end
