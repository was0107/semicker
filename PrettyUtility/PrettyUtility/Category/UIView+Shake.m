//
//  UIView+Shake.m
//  micker
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+Shake.h"

B5M_FIX_CATEGORY_BUG(UIViewShakeAddition)

@implementation UIView (ShakeAddition)

- (void)shakeStatus:(BOOL)enabled {
    
    if (enabled) {
        CGFloat rotation = 0.03;
        
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
        shake.duration = 0.13;
        shake.autoreverses = YES;
        shake.repeatCount  = MAXFLOAT;
        shake.removedOnCompletion = NO;
        shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
        shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
        
        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    }
    else {
        [self.layer removeAnimationForKey:@"shakeAnimation"];
    }
}

- (void)shakeForCount:(NSInteger)count {
    
    CGFloat rotation = 0.08;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = count;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

@end
