//
//  UIViewWithShadow.m
//  micker
//
//  Created by allen.wang on 8/27/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIViewWithShadow.h"

@implementation UIViewWithShadow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

-(void) layoutSubviews {
	CGFloat coloredBoxMargin = kShadowWidth;
    CGFloat coloredBoxHeight = self.frame.size.height;
    _coloredBoxRect = CGRectMake(coloredBoxMargin, 
                                 0, 
                                 coloredBoxMargin, 
                                 coloredBoxHeight);
}

-(void) drawRect:(CGRect)rect {
    
 	CGColorRef lightColor =  [UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f blue:216.0f/255.0f alpha:0.8].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.4].CGColor;   
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	// Draw shadow
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(-5, 0), 10, shadowColor);
	CGContextSetFillColorWithColor(context, lightColor);
    CGContextFillRect(context, _coloredBoxRect);
	CGContextRestoreGState(context);
}

@end
