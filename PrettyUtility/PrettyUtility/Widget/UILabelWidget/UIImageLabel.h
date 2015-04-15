//
//  UIImageLabel.h
//  PrettyUtility
//
//  Created by allen.wang on 1/10/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageRotateNotification        @"kImageRotateNotification"

@interface UIImageLabel : UILabel
@property (nonatomic, retain) UIImageView *imageView;

- (void) setText:(NSString *)text show:(BOOL) flag;

@end
