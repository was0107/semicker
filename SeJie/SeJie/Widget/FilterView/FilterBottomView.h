//
//  FilterBottomView.h
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTopViewItem.h"
#import "WASSegmentControl.h"

@interface FilterBottomView : UIView

@property (nonatomic, retain) UIButton      *voiceButton;
@property (nonatomic, retain) UIButton      *infoButton;
@property (nonatomic, retain) UIButton      *manButton;
@property (nonatomic, retain) UIButton      *womanButton;
@property (nonatomic, retain) UIButton      *downloadButton;
@property (nonatomic, retain) FilterTopViewItem *searchView;
@property (nonatomic, retain) WASSegmentControl *segmentControl;
@property (nonatomic, retain) UIButton      *accountButton;
@property (nonatomic, retain) UIButton      *accountTextBtn;

@property (nonatomic, copy)   intIdBlock    block;

- (void) updateAccount;

@end
