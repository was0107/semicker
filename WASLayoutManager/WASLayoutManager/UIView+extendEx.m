//
//  UIView+extend.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIView+extendEx.h"

B5M_FIX_CATEGORY_BUG(UIViewExtendEx)

@implementation UIView (extendEx)
- (int)x
{
    return self.frame.origin.x;
}
- (int)y
{
    return self.frame.origin.y;
}
- (int)width
{
    return self.frame.size.width;
}
- (int)height
{
    return self.frame.size.height;
}

- (int)boundsX
{
    return self.bounds.origin.x;
}
- (int)boundsY
{
    return self.bounds.origin.y;
}
- (int)boundsWidth
{
    return self.bounds.size.width;
}
- (int)boundsHeight
{
    return self.bounds.size.height;
}

- (UIView *) setFrameEX:(CGRect) frame
{
    self.frame = frame;
    return self;
}

- (int)maxWidth
{
    return self.x + self.width;
}

- (int)maxHeight
{
    return self.y + self.height;
}

- (UIView *) setFrameX:(CGFloat) x
{
    CGRect rect = self.frame;
    rect.origin.x = (int)x;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setFrameY:(CGFloat) y
{
    CGRect rect = self.frame;
    rect.origin.y = (int)y;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setFrameWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.size.width = (int)width;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setFrameHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.size.height = (int)height;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setBoundsX:(CGFloat) x
{
    CGRect rect = self.bounds;
    rect.origin.x = (int)x;
    self.bounds = rect;    
    return self;
}

- (UIView *) setBoundsY:(CGFloat) y
{
    CGRect rect = self.bounds;
    rect.origin.y = (int)y;
    self.bounds = rect;
    return self;
}

- (UIView *) setBoundsWidth:(CGFloat) width
{
    CGRect rect = self.bounds;
    rect.size.width = (int)width;
    self.bounds = rect;  
    return self;
}

- (UIView *) setBoundsHeight:(CGFloat) height
{
    CGRect rect = self.bounds;
    rect.size.height = (int)height;
    self.bounds = rect;
    return self;
}

- (UIView *) setFrameOrigin:(CGPoint) origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setFrameSize:(CGSize) size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setBoundsOrigin:(CGPoint) origin
{
    CGRect rect = self.bounds;
    rect.origin = origin;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsSize:(CGSize) size
{
    CGRect rect = self.bounds;
    rect.size = size;
    self.bounds = rect;
    return self;
}

- (UIView *) setExtendHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.origin.y += (int)height;
    rect.size.height -= (int)height;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setExtendWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.origin.x += (int)width;
    rect.size.width -= (int)width;
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setShiftVertical:(CGFloat) vertical
{
    CGRect rect = self.frame;
    rect.origin.y += (int)vertical;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setShiftHorizon:(CGFloat) horizon
{
    CGRect rect = self.frame;
    rect.origin.x += (int)horizon;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) addFillSubView:(UIView *) subView
{
    [subView setFrame:self.bounds];
    [self addSubview:subView];
    return self;
}

- (UIView *) addCenterSubview:(UIView *) subView
{
    [self addSubview:subView];
    subView.center = self.center;
    return self;
}


- (UIView *) emptySubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    return self;
}

@end
