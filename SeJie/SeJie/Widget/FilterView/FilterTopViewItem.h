//
//  FilterTopViewItem.h
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+extend.h"

#import "UpdateTipView.h"

@interface FilterTopViewItem : UIButton
@property (nonatomic, retain) UpdateTipView *tipImageView;
@property (nonatomic, retain) UIImageView *leftImageView;
@property (nonatomic, retain) UILabel     *textLabel;
@property (nonatomic, retain) UILabel     *detailLabel;



@end
