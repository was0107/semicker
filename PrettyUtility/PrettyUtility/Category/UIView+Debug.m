//
//  UIView+Debug.m
//  micker
//
//  Created by allen.wang on 9/24/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIView+Debug.h"

#define RANDOMCOLOR [UIColor colorWithRed:(arc4random()%255)/255 green:(arc4random()%255)/255 blue:(arc4random()%255)/255 alpha:1]


B5M_FIX_CATEGORY_BUG(UIViewDebug)

@implementation UIView (Debug)

- (id) drawDebugBorder {
    self.layer.borderColor = [[UIColor redColor] CGColor];
    self.layer.borderWidth = 2.0;
    
    NSLog(@"debug self = %@", self);
    return self;
}

- (id) drawDebugBorders
{
    for (UIView *subView in self.subviews) {
        subView.layer.borderColor = [RANDOMCOLOR CGColor];
        subView.layer.borderWidth = 2.0;
    }
    
    [self drawDebugBorder];
    return self;
}

@end
