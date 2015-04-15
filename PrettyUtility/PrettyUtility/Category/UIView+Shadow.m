//
//  UIView+Shadow.m
//  micker
//
//  Created by allen.wang on 8/27/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIView+Shadow.h"
#import "UIViewWithShadow.h"

B5M_FIX_CATEGORY_BUG(UIViewShadow)

@implementation UIView(Shadow)

- (id) addLeftShadow
{
    UIViewWithShadow* verticalLineView = [[[UIViewWithShadow alloc] initWithFrame:CGRectMake(-40, 0, 40 , self.frame.size.height)] autorelease];
    [verticalLineView setBackgroundColor:[UIColor clearColor]];
    [verticalLineView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [verticalLineView setClipsToBounds:NO];
    [self addSubview:verticalLineView];
    return self;
}


- (id) addLeftPadding:(NSString *) imageName
{
    UIImageView* imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4 , self.frame.size.height)] autorelease];//
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [imageView setClipsToBounds:NO];
    [self addSubview:imageView];
    
    CGRect newRect = self.frame;
    newRect.origin.x += 4;
    newRect.size.width -= 4;
    [self setFrame:newRect];
    return self;
}

- (id) addBottomShadow
{
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius  = 3.0f;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowColor   = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset  = CGSizeZero;
    self.layer.shadowPath    = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    return self;
}

@end
