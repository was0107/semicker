//
//  WASLabel.m
//  micker
//
//  Created by allen.wang on 7/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASLabel.h"

@interface WASLabel ()
- (void)_initialize;
@end


@implementation WASLabel

#pragma mark - Accessors

@synthesize verticalTextAlignment = _verticalTextAlignment;

- (void)setVerticalTextAlignment:(WASLabelVerticalTextAlignment)verticalTextAlignment {
	_verticalTextAlignment = verticalTextAlignment;
    
	[self setNeedsLayout];
}


@synthesize textEdgeInsets = _textEdgeInsets;

- (void)setTextEdgeInsets:(UIEdgeInsets)textEdgeInsets {
	_textEdgeInsets = textEdgeInsets;
	
	[self setNeedsLayout];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		[self _initialize];
	}
	return self;
}


#pragma mark - UILabel

- (void)drawTextInRect:(CGRect)rect {
	rect = UIEdgeInsetsInsetRect(rect, _textEdgeInsets);
	
	if (self.verticalTextAlignment == WASLabelVerticalTextAlignmentTop) {
		CGSize sizeThatFits = [self sizeThatFits:rect.size];
		rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, sizeThatFits.height);
	} else if (self.verticalTextAlignment == WASLabelVerticalTextAlignmentBottom) {
		CGSize sizeThatFits = [self sizeThatFits:rect.size];
		rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - sizeThatFits.height), rect.size.width, sizeThatFits.height);
	}
    
	[super drawTextInRect:rect];
}


#pragma mark - Private

- (void)_initialize {
	self.verticalTextAlignment = WASLabelVerticalTextAlignmentMiddle;
	self.textEdgeInsets = UIEdgeInsetsZero;
}

@end
