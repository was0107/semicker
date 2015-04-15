//
//  UIView+BaseKit.h
//  micker
//
//  Created by allen.wang on 9/24/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BaseKit)

- (UIView *)findFirstResponder;

- (id)findFirstTextField;

- (NSArray *)findTextFields;

/**
 Set alpha value of the receiver to 1
 */
- (void)show;

/**
 Set alpha value of the receiver to 0
 */
- (void)hide;

/**
 Toggle alpha value or the receiver between 0 and 1
 */
- (void)toggle;

/**
 Receiver will fade in
 
 @param duration of the animation
 */
- (void)fadeInWithDuration:(NSTimeInterval)duration;

/**
 Receiver will fade out
 
 @param duration of the animation
 */
- (void)fadeOutWithDuration:(NSTimeInterval)duration;

/**
 Receiver will fade out and remove the view from its superview after animation ended
 
 @param duration of the animation
 */
- (void)fadeOutAndRemoveFromSuperviewWithDuration:(NSTimeInterval)duration;
@end
