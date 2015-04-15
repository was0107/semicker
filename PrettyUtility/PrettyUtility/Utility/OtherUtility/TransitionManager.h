//
//  TransitionManager.h
//  micker
//
//  Created by Jarry Zhu on 12-6-18.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionManager : NSObject
{
    // UIViewController transitions
	UIViewController *_oldController;
	UIViewController *_currentController;

    UIView      *_upperView;
    UIView      *_lowerView;
}

@property (nonatomic, retain) UIViewController *oldController;
@property (nonatomic, retain) UIViewController *currentController;


+ (TransitionManager*)sharedTransitionManager;

// UIViewController transitions
- (void)presentModalViewController:(UIViewController*)modalViewController onViewController:(UIViewController*)viewController;
- (void)dismissModalViewController:(UIViewController*)modalViewController;


@end
