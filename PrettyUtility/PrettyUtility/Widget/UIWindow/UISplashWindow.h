//
//  UISplashWindow.h
//  PrettyUtility
//
//  Created by allen.wang on 1/29/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISplashWindow : UIWindow
@property (nonatomic, copy) voidBlock block;

+ (UISplashWindow *) instance;

- (void) dissmiss;
@end
