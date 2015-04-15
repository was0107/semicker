//
//  BaseTitleViewController.h
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageLabel.h"
#import "UIButton+extend.h"

@interface BaseTitleViewController : BaseViewController

@property (nonatomic, retain) UIView        *titleView;
@property (nonatomic, retain) UIImageView   *imageView;
@property (nonatomic, retain) UIImageLabel  *titleLabel;
@property (nonatomic, retain) UIButton      *leftButton;
@property (nonatomic, retain) UIButton      *rightButton;

@end
