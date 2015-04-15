//
//  UITableViewBaseCell.h
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateObject.h"
#import "UIImageView+(ASI).h"
#import "UIImage+extend.h"
#import "UIView+extend.h"

@interface UITableViewBaseCell : UITableViewCell

- (void) setupContentView;

- (void) reduceMemory;

@end
