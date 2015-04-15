//
//  UserCountButton.m
// sejieios
//
//  Created by Jarry on 13-1-23.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCountButton.h"

@implementation UserCountButton

@synthesize count   = _count;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.font = TNRFontSIZEBIG(kFontSize12);
        [self setTitleColor:kOrangeColor forState:UIControlStateHighlighted];
        
        self.count = @"--";
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_count);
    [super dealloc];
}

- (void) setCount:(NSString *)count
{
    _count = [count retain];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.titleLabel.textColor set];
    [self.count drawInRect:CGRectMake(0, 5, self.frame.size.width, 12)
                     withFont:TNRFontSIZEBIG(kFontSize12)
                lineBreakMode:NSLineBreakByTruncatingTail
                    alignment:NSTextAlignmentCenter];
}

//- (CGRect) imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(10, 22, 9, 9);
//}
//
- (CGRect) titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(16, 20, 30, 16);
}

@end
