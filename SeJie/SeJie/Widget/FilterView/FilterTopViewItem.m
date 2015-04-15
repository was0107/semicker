//
//  FilterTopViewItem.m
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "FilterTopViewItem.h"
#import "CreateObject.h"

@implementation FilterTopViewItem
@synthesize tipImageView  = _tipImageView;
@synthesize leftImageView = _leftImageView;
@synthesize textLabel     = _textLabel;
@synthesize detailLabel   = _detailLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
//        [self addSubview:self.leftImageView];
//        [self addSubview:self.textLabel];
//        [self addSubview:self.detailLabel];
        
    }
    return self;
}

- (UpdateTipView *) tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[UpdateTipView alloc] initWithFrame:kFilterUpdateFrame];
        [_tipImageView setUpdateText:kEmptyString];
        _tipImageView.alpha = 0.0f;
    }
    return _tipImageView;
}

- (UILabel *) textLabel
{
    if (!_textLabel) {
        _textLabel = [[CreateObject label] retain];
        [_textLabel setFrame:CGRectMake(50, 5, 150, 24)];
        _textLabel.font = TNRFONTSIZE(kFontSize16);
        _textLabel.textColor = kWhiteColor;
        _textLabel.backgroundColor = kClearColor;
        
    }
    return _textLabel;
}

- (UILabel *) detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[CreateObject label] retain];
        [_detailLabel setFrame:CGRectMake(50, 30, 150, 16)];
        _detailLabel.font = TNRFONTSIZE(kFontSize12);
        _detailLabel.textColor = kRedColor;
        _detailLabel.backgroundColor = kClearColor;
    }
    return _detailLabel;
}

- (UIImageView *) leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[CreateObject imageView:nil] retain];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.frame = CGRectMake(5, 5, 40, 40);
        _leftImageView.backgroundColor = kClearColor;
    }
    return _leftImageView;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_tipImageView);
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_textLabel);
    TT_RELEASE_SAFELY(_detailLabel);
    [super dealloc];
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextBeginPath(context);
    [kRedColor setStroke];
	CGContextMoveToPoint(context, 0.0f, self.bounds.size.height-1);
	CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height-1);
    [kWhiteColor setStroke];
	CGContextMoveToPoint(context, 0.0f, self.bounds.size.height);
	CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
	CGContextStrokePath(context);
}

@end
