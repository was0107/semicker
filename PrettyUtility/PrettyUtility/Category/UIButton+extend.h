//
//  UIButton+extend.h
//  PrettyUtility
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (extend)

- (void) setNormalImage:(NSString *)imageNormal
          selectedImage:(NSString *)imageSelected;

- (void) setNormalImageEx:(UIImage *)imageNormal
          selectedImageEx:(UIImage *)imageSelected;

- (void) setNormalImage:(NSString *)imageNormal
              hilighted:(NSString *) imageHilight
          selectedImage:(NSString *)imageSelected;

- (void) setBackgroundImage:(NSString *)imageNormal
              selectedImage:(NSString *)imageSelected
                 clickImage:(NSString *)clickImage;

- (void) doExchangeImage;

@end
