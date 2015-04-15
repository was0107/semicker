//
//  UIImageButton.h
//  PrettyUtility
//
//  Created by allen.wang on 1/11/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageButton : UIButton
@property (nonatomic, retain) UIImageView *popImageView;
@property (nonatomic, retain) UILabel     *popLabel;


- (void) showPopView;

@end
