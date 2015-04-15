//
//  UIImageLabel.m
//  PrettyUtility
//
//  Created by allen.wang on 1/10/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UIImageLabel.h"

@interface UIImageLabel()

@end

@implementation UIImageLabel
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateNotification:) name:kImageRotateNotification object:nil];
    }
    return self;
}

- (UIImageView *) imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"top_down_tip"];
        
    }
    
    return _imageView;
}

- (void) setText:(NSString *)text show:(BOOL) flag
{
    CGSize size = [text sizeWithFont:self.font constrainedToSize:self.bounds.size];
    CGFloat start = self.bounds.size.width - (self.bounds.size.width - size.width)/2;
    CGRect frame = CGRectMake(start, 18, 12, 8);
    [[self imageView] setFrame:frame];
    if (flag) {
        self.text = [NSString stringWithFormat:@"%@  ",text];
        [self addSubview:self.imageView];
    } else {
        [self.imageView removeFromSuperview];
        self.text = text;
    }
}

- (void) rotateNotification:(NSNotification *)notification
{
    [UIView animateWithDuration:.25f animations:^{
        if ([notification.object boolValue]) {
            _imageView.transform = CGAffineTransformMakeRotation(-M_PI);
        } else {
            _imageView.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_imageView);
    [super dealloc];
}
@end
