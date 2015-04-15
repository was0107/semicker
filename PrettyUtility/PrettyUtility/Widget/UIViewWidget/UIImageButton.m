//
//  UIImageButton.m
//  PrettyUtility
//
//  Created by allen.wang on 1/11/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UIImageButton.h"
#import "CustomAnimation.h"
#import "AnimateTime.h"

@implementation UIImageButton
@synthesize popImageView = _popImageView;
@synthesize popLabel     = _popLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
//        [self addSubview:self.popImageView];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_popLabel);
    TT_RELEASE_SAFELY(_popImageView);
    [super dealloc];
}


- (UILabel *) popLabel
{
    if (!_popLabel) {
        _popLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 100, 20)];
        _popLabel.text = @"喜欢添加成功哦+";
        _popLabel.backgroundColor = kClearColor;
        _popLabel.font = TNRFONTSIZE(kFontSize11);
        _popLabel.textColor = kWhiteColor;
    }
    return _popLabel;
}

- (UIImageView *)popImageView
{
    if (!_popImageView) {
        _popImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 106, 100)];
        _popImageView.image = [UIImage imageNamed:@"detail_red_heart"];
        [_popImageView addSubview:self.popLabel];
    }
    return _popImageView;
}

- (void) showPopView
{
    if (self.superview) {
        
        if (self.popImageView.superview) {
            [self.popImageView removeFromSuperview];
            return;
        }
        CGRect rect = self.frame;
        CGFloat x = rect.origin.x - 40;
        CGFloat y = rect.origin.y - 60;
        
        self.popImageView.frame = CGRectMake(x, y, 80, 80);
        [self.superview addSubview:self.popImageView];
        [self.superview bringSubviewToFront:self.popImageView];
        
        CAKeyframeAnimation *anim = [CustomAnimation scaleKeyFrameAnimation:AnimateTime.NORMAL];
        anim.delegate = self;
        self.popImageView.alpha = 1.0f;
        [self.popImageView.layer addAnimation:anim forKey:nil];
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.popImageView removeFromSuperview];
}

@end
