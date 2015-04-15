//
//  UIView+extend.h
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extendEx)

- (int)x;
- (int)y;
- (int)width;
- (int)height;
- (int)boundsX;
- (int)boundsY;
- (int)boundsWidth;
- (int)boundsHeight;
- (int)maxWidth;
- (int)maxHeight;


- (UIView *) setFrameEX:(CGRect) frame;
- (UIView *) setFrameX:(CGFloat) x;
- (UIView *) setFrameY:(CGFloat) y;
- (UIView *) setFrameWidth:(CGFloat) width;
- (UIView *) setFrameHeight:(CGFloat) height;
- (UIView *) setBoundsX:(CGFloat) x;
- (UIView *) setBoundsY:(CGFloat) y;
- (UIView *) setBoundsWidth:(CGFloat) width;
- (UIView *) setBoundsHeight:(CGFloat) height;
- (UIView *) setFrameOrigin:(CGPoint) origin;
- (UIView *) setFrameSize:(CGSize) size;
- (UIView *) setBoundsOrigin:(CGPoint) origin;
- (UIView *) setBoundsSize:(CGSize) size;

- (UIView *) setExtendHeight:(CGFloat) height;
- (UIView *) setExtendWidth:(CGFloat) width;

- (UIView *) setShiftVertical:(CGFloat) vertical;
- (UIView *) setShiftHorizon:(CGFloat) horizon;

- (UIView *) addFillSubView:(UIView *) subView;
- (UIView *) addCenterSubview:(UIView *) subView;

- (UIView *) emptySubviews;

@end
