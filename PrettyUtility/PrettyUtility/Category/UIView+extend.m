//
//  UIView+extend.m
//  micker
//
//  Created by allen.wang on 8/22/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIView+extend.h"

B5M_FIX_CATEGORY_BUG(UIViewExtend)

@implementation  UIView(extend)
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
    if (CGRectEqualToRect(frame,self.frame)) {
        return self;
    }
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
    rect.origin.x = x;
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setFrameY:(CGFloat) y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setFrameWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setFrameHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setBoundsX:(CGFloat) x
{
    CGRect rect = self.bounds;
    rect.origin.x = x;
    self.bounds = rect;    
    return self;
}
- (UIView *) setBoundsY:(CGFloat) y
{
    CGRect rect = self.bounds;
    rect.origin.y = y;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsWidth:(CGFloat) width
{
    CGRect rect = self.bounds;
    rect.size.width = width;
    self.bounds = rect;  
    return self;
}
- (UIView *) setBoundsHeight:(CGFloat) height
{
    CGRect rect = self.bounds;
    rect.size.height = height;
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
    rect.origin.y += height;
    rect.size.height -= height;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setExtendWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.origin.x += width;
    rect.size.width -= width;
    if (CGRectEqualToRect(rect,self.frame)) {
        return self;
    }
    self.frame = CGRectIntegral(rect);
    return self;
}

- (UIView *) setShiftVertical:(CGFloat) vertical
{
    CGRect rect = self.frame;
    rect.origin.y += vertical;
    self.frame = CGRectIntegral(rect);
    return self;
}
- (UIView *) setShiftHorizon:(CGFloat) horizon
{
    CGRect rect = self.frame;
    rect.origin.x += horizon;
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

- (UIView *) addCenterSubview:(UIView *) subView shiftOriginY:(int) yShift
{
    [self addSubview:subView];
    CGPoint center = self.center;
    center.y += yShift;
    subView.center = center;
    return self;
}
- (UIView *) addCenterSubview:(UIView *) subView shiftOriginX:(int) xShift
{
    [self addSubview:subView];
    CGPoint center = self.center;
    center.x += xShift;
    subView.center = center;
    return self;
}



- (UIView *) emptySubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    return self;
}

- (UIView *) addBackgroundImage:(NSString *)imageName
{
    UIImage *bgImage = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:bgImage] autorelease];
    [imageView setFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];

    [self setFrameSize:imageView.frame.size];
    [self addSubview:imageView];
    [self sendSubviewToBack:imageView];

    return self;
}

- (UIImageView *) addBackgroundStretchableImage:(NSString *)imageName
                              leftCapWidth:(CGFloat)leftCapWidth
                              topCapHeight:(CGFloat)topCapHeight
{
    UIImage *bgImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                           topCapHeight:topCapHeight];
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:bgImage] autorelease];
    imageView.backgroundColor = kClearColor;
    [self addFillSubView:imageView];
    [self sendSubviewToBack:imageView];
    
    return imageView;
}


@end
