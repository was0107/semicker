//
//  WASShareTipView.m
//  PrettyUtility
//
//  Created by allen.wang on 1/19/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "WASShareTipView.h"
#import "CustomLabel.h"
#import "UIButton+extend.h"

@interface WASShareTipView()

@property (nonatomic, retain) UIButton    *tipImage;
@property (nonatomic, retain) CustomLabel *tipLabel;

@end

@implementation WASShareTipView
@synthesize tipImage = _tipImage;
@synthesize tipLabel = _tipLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        [self setupContentView];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_tipImage);
    TT_RELEASE_SAFELY(_tipLabel);
    [super dealloc];
}

- (void) setupContentView
{
    [self tipImage];
    [self tipLabel];
}

- (void) didMoveToSuperview
{
    if (self.superview) {
        CGPoint point = self.superview.center;
        point.y -= 20;
        self.center = point;
    }
}
- (UIButton *) tipImage
{
    if (!_tipImage) {
        _tipImage = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _tipImage.frame = CGRectMake(50,0,56,42);
        [_tipImage setNormalImage:@"no_share_con"  selectedImage:@"no_share_con_hover"];
        [_tipImage addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _tipImage.backgroundColor = kClearColor;
        [self addSubview:_tipImage];
    }
    return _tipImage;
}


- (CustomLabel *) tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(120,0,150,42)];
        _tipLabel.backgroundColor = kClearColor;
        _tipLabel.customColor     = kRedColor;
        _tipLabel.textAlignment   = NSTextAlignmentLeft;
        _tipLabel.font            = TNRFontSIZEBIG(kFontSize17);
        
        NSString *tipString = @"还没有任何分享 :) 快去分享吧";
        NSRange range =  [tipString rangeOfString:@"分享" options:NSBackwardsSearch];
        _tipLabel.colorArray = [NSMutableArray arrayWithObject:[NSDictionary dictionaryWithObject:[NSValue valueWithRange:range] forKey:kColorKey]];
        _tipLabel.text = tipString;
        [self addSubview:_tipLabel];
        
    }
    return _tipLabel;
}

- (IBAction)buttonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kButtonShareNotification object:nil];
}


@end
