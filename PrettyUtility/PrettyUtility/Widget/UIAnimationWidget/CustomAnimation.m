//
//  CustomAnimation.m
//  micker
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "CustomAnimation.h"

@implementation CustomAnimation

//
+ (void)dropRecycleAnim:(UIView*)view center:(CGPoint)point size:(CGSize)size {
    UIImageView * animation = [[UIImageView alloc] init];
    animation.frame = CGRectMake(point.x-size.width/2-1, point.y-size.height/2-1, size.width, size.height);
    
    animation.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed: @"kill5.png"],
                                 [UIImage imageNamed: @"kill4.png"],
                                 [UIImage imageNamed: @"kill3.png"],
                                 [UIImage imageNamed: @"kill2.png"],
                                 [UIImage imageNamed: @"kill1.png"]
                                 ,nil];
    [animation setAnimationRepeatCount:1];
    [animation setAnimationDuration:0.3];
    [animation startAnimating];
    [view addSubview:animation];
    //[animation bringSubviewToFront:self.mainView];
    [animation release];
    animation = nil;
}

//
+ (void)shakeAnimation:(UIView*)view 
              duration:(CGFloat)duration 
                vigour:(CGFloat)vigour 
                number:(NSInteger)number 
             direction:(NSInteger)direction {
    
    [view.layer removeAllAnimations];
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSInteger d = 1;
    if (direction < 0) {
        d = -1;
    }
	
    CGRect frame = view.layer.frame;
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
	for (int index = 0; index < number; ++index) {
		CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame) - d * frame.size.width * vigour,CGRectGetMidY(frame));
		CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame) + d * frame.size.width * vigour,CGRectGetMidY(frame));
	}
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = duration;
    CFRelease(shakePath);
    
    [view.layer addAnimation:shakeAnimation forKey:kCATransition];
}

+ (void) flipAnimation:(UIView *)view
              flipView:(UIView *)flipView
              duration:(CGFloat)duration
                 isAdd:(BOOL) flag {
    UIViewAnimationTransition trans ;
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:duration];
    if (flag) {
        [view addSubview:flipView];
        trans = UIViewAnimationTransitionFlipFromLeft;
    }
    else {
        if ([view.subviews containsObject:flipView]) {
            [flipView removeFromSuperview];
        }
        trans = UIViewAnimationTransitionFlipFromRight;

    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
    [UIView setAnimationTransition:trans forView:view cache:YES];
    [UIView commitAnimations]; 
}


+ (void) flipAnimationEx:(UIImageView *)imageView
                flipView:(UIImage  *)image  //翻转
{
    if (!image || !imageView) {
        return;
    }
//    imageView.image  = image;

    //remove animation
//    return;
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration = .26;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fillMode = kCAFillModeForwards;
    imageView.image  = image;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:0.4f];
    theAnimation.toValue = [NSNumber numberWithFloat:1.0f]; 
    [imageView.layer addAnimation:theAnimation forKey:@"animationOpacity"];
}

+ (void) moveToPosition:(UIImageView *) imageView
                   time:(CGFloat )time
                   from:(NSNumber *) from
                     to:(NSNumber *) to  //横向移动
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    theAnimation.duration = time;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
//    theAnimation.fromValue  = from; 
    theAnimation.toValue    = to; 
    theAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [imageView.layer addAnimation:theAnimation forKey:@"transform.translation.x"];
}

+ (void) addOrRemoveAnimate:(UIView *) parentView subView:(UIView *) subView flag:(BOOL) flag
{
    [UIView animateWithDuration:0.26 animations:^{
        if (flag) {
            subView.alpha = 0.3f;
        }
        else {
            subView.alpha = 1.0f;
            [parentView addSubview:subView];
        }
        
    } completion:^(BOOL finished) {
        if (flag) {
            [subView removeFromSuperview];
        }
    }];
}


+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time; //有闪烁次数的动画
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.6];
    animation.repeatCount=repeatTimes;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=YES;
    return  animation;
}

+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x //横向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=x;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)moveX:(float)time fromX:(NSNumber *)FromX ToX:(NSNumber *)ToX //横向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue=FromX;
    animation.toValue=ToX;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y //纵向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=y;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes//缩放
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=orginMultiple;
    animation.toValue=Multiple;
    animation.duration=time;
    animation.autoreverses=YES;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes //组合动画
{
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes //路径动画
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    return animation;
}

+(CABasicAnimation *)movepoint:(CGPoint )point //点移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue=[NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount //旋转
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= dur;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount; 
    animation.delegate= self;
    
    return animation;
}

+ (CAKeyframeAnimation *) scaleKeyFrameAnimation:(CGFloat) time
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = time;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    return animation;
}

+ (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    
    switch (orientation) {
            
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(-DegreesToRadians(90));
            
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(DegreesToRadians(90));
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(DegreesToRadians(180));
            
        case UIInterfaceOrientationPortrait:
        default:
            return CGAffineTransformMakeRotation(DegreesToRadians(0));
    }
}
@end
