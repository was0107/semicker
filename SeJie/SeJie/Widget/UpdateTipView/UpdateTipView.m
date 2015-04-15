//
//  UpdateTipView.m
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import "UpdateTipView.h"
#import "UIView+extend.h"
#import "CustomAnimation.h"

@implementation UpdateTipView

@synthesize updateLabel = _updateLabel;
@synthesize bgImageView = _bgImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        self.bgImageView = [self addBackgroundStretchableImage:kMainUpdateTipImage leftCapWidth:8 topCapHeight:8];
        self.bgImageView.backgroundColor = kClearColor;
        UILabel *updateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 2, frame.size.width, frame.size.height-4)] autorelease];
        [updateLabel setBackgroundColor:kClearColor];
        [updateLabel setText:@"99+"];
        [updateLabel setTextColor:kWhiteColor];
        [updateLabel setTextAlignment:NSTextAlignmentCenter];
        [updateLabel setFont:BOLDSYSTEMFONT(kFontSize10)];
        [self addSubview:updateLabel];
        self.backgroundColor = kClearColor;
        self.updateLabel = updateLabel;
        
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_updateLabel);
    TT_RELEASE_SAFELY(_bgImageView);
    [super dealloc];
}

- (void) showViewAnimated
{
    self.alpha = 0.0f;
    if ([self.updateLabel.text length] <= 0) {
        return;
    }
    CAKeyframeAnimation *anim = [CustomAnimation scaleKeyFrameAnimation:AnimateTime.NORMAL];
    self.alpha = 1.0f;
    [self.layer addAnimation:anim forKey:nil];
}

- (void) setUpdateText:(NSString *)text
{
    [self.updateLabel setText:text];
}

@end
