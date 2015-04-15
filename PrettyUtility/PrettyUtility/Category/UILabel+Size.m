//
//  UILabel+Size.m
//  B5MApp
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Size.h"

B5M_FIX_CATEGORY_BUG(UILabelSize)

@implementation UILabel (Size)

//
- (void)setTextAutoResize:(NSString*)text {
    
    [self setText:text];
    [self autoResize];
}

- (void)setFontAutoResize:(UIFont*)font {
    
    [self setFont:font];
    [self autoResize];
}

- (void)autoResize {
    
    UIFont *font = [self font];
    CGSize size = CGSizeMake(300,1024);
    CGSize labelsize = [self.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    if (labelsize.width < 28) {
        labelsize = CGSizeMake(28, labelsize.height);
    }
    else if (labelsize.width > 112) {
        labelsize = CGSizeMake(112, labelsize.height);
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, labelsize.width+18, labelsize.height+8)];
}

- (void)adjustFrameWithTextRight
{
    if (!self.text || self.text.length <= 0) {
        return;
    }
    if (self.frame.origin.x > 5.0f) {
        return;
    }
    self.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    UIFont *font = [self font];
    CGSize size  = CGSizeMake(100,font.pointSize);
    CGSize labelsize = [self.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat startX   = self.frame.origin.x + (size.width - labelsize.width) - 18;
    [self setFrame:CGRectMake(startX, self.frame.origin.y, labelsize.width + 6, labelsize.height)];

}

@end
