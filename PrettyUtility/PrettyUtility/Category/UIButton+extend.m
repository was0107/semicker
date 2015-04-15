//
//  UIButton+extend.m
//  PrettyUtility
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UIButton+extend.h"

@implementation UIButton (extend)

- (void) setNormalImage:(NSString *)imageNormal
          selectedImage:(NSString *)imageSelected
{
    [self setNormalImage:imageNormal hilighted:imageSelected selectedImage:imageSelected];
}


- (void) setNormalImageEx:(UIImage *)imageNormal
          selectedImageEx:(UIImage *)imageSelected
{
    [self setImage:imageNormal forState:UIControlStateNormal];
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateHighlighted];
    }
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateSelected];
    }

}


- (void) setNormalImage:(NSString *)imageNormal
              hilighted:(NSString *) imageHilight
          selectedImage:(NSString *)imageSelected
{
    UIImage *image1 = [UIImage imageNamed:imageNormal];
    UIImage *image2 = [UIImage imageNamed:imageHilight];
    UIImage *image3 = [UIImage imageNamed:imageSelected];
    
    [self setImage:image1 forState:UIControlStateNormal];
    if (image2) {
        [self setImage:image2 forState:UIControlStateHighlighted];
    }
    if (image3) {
        [self setImage:image3 forState:UIControlStateSelected];
    }
}

- (void) setBackgroundImage:(NSString *)imageNormal
              selectedImage:(NSString *)imageSelected
                 clickImage:(NSString *)clickImage
{
    UIImage *image1 = [UIImage imageNamed:imageNormal];
    UIImage *image2 = [UIImage imageNamed:imageSelected];
    UIImage *image3 = [UIImage imageNamed:clickImage];
    [self setBackgroundImage:image1 forState:UIControlStateNormal];
    if (image2) {
        [self setBackgroundImage:image2 forState:UIControlStateSelected];
    }
    if (image3) {
        [self setBackgroundImage:image3 forState:UIControlStateHighlighted];
    }
}

- (void) doExchangeImage
{
    UIImage *normalImage    = [[self imageForState:UIControlStateNormal] retain];
    UIImage *selectedImage  = [[self imageForState:UIControlStateSelected] retain];
    
    if (normalImage != selectedImage)
    {
        [self setImage:normalImage forState:UIControlStateSelected];
        [self setImage:selectedImage forState:UIControlStateNormal];
    }
    
    [normalImage release];
    [selectedImage release];
}

@end
