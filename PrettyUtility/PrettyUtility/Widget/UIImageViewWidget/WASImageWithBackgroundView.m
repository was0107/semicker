//
//  WASImageWithBackgroundView.m
//  PrettyUtility
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "WASImageWithBackgroundView.h"
#import "UIImageView+border.h"

@implementation WASImageWithBackgroundView
@synthesize backString = _backString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_backString);
    [super dealloc];
}

- (void) setBackString:(NSString *)backString
{
    if (_backString != backString) {
        [_backString release];
        _backString = [backString retain];
        [self addEffect];
    }
}

@end
