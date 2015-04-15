//
//  WASLabel.h
//  micker
//
//  Created by allen.wang on 7/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The vertical alignment of text within a label.
 */
typedef enum {
	/** Aligns the text vertically at the top in the label (the default). */
	WASLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	
	/** Aligns the text vertically in the center of the label. */
	WASLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
	
	/** Aligns the text vertically at the bottom in the label. */
	WASLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} WASLabelVerticalTextAlignment;

@interface WASLabel : UILabel
/**
 The vertical text alignment of the receiver.
 
 The default is `SSLabelVerticalTextAlignmentMiddle` to match `UILabel`.
 */
@property (nonatomic, assign) WASLabelVerticalTextAlignment verticalTextAlignment;

/**
 The edge insets of the text.
 
 The default is `UIEdgeInsetsZero` so it behaves like `UILabel` by default.
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;


@end
