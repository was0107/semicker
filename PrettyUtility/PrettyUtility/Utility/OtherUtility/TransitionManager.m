//
//  TransitionManager.m
//  micker
//
//  Created by Jarry Zhu on 12-6-18.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "TransitionManager.h"

@implementation TransitionManager

@synthesize oldController = _oldController;
@synthesize currentController = _currentController;

static TransitionManager *sharedTransitionManager = nil;

+ (TransitionManager*)sharedTransitionManager {
	if (!sharedTransitionManager) {
		sharedTransitionManager = [[TransitionManager alloc] init];
	}
	return sharedTransitionManager;
}

- (TransitionManager*)init {
	if (self = [super init]) {
//		tempOverlayView = [[UIImageView alloc] init];
//		tempOverlayView.transform = CGAffineTransformScale(tempOverlayView.transform, 1, -1)
//        transitionType = HMGLTransitionTypeNone;		
//		// Just create transition view.
//		[self transitionView];
	}
	return self;
}

#pragma mark - Memory
- (void)dealloc {
//	[tempOverlayView release];
	[_oldController release];
	[_currentController release];
	[super dealloc];
}


- (void)switchViewControllers {
    
    /*
	NSAssert(self.transitionView.transition, @"Transition not set.");
	
	transitionView.transform = CGAffineTransformIdentity;
	tempOverlayView.transform = CGAffineTransformIdentity;
	
	// transition view
	[self.transitionView reset];
	self.transitionView.transform = oldController.view.transform;
	self.transitionView.frame = oldController.view.frame;
	[transitionView layoutSubviews];
	
	// create begin texture
	UIImage *image = [transitionView createBeginTextureWithView:oldController.view];
	
	// temp overlay image
	tempOverlayView.image = image;
    
	// create end texture
	currentController.view.transform = oldController.view.transform;	
	currentController.view.frame = oldController.view.frame;
	[self.transitionView createEndTextureWithView:currentController.view];
	
	// transition view
	[oldController.view.superview addSubview:transitionView];
	
	// add temp overlay view
	CGRect rect = oldController.view.frame;
	
	// temp overlay view
	tempOverlayView.contentMode = UIViewContentModeBottomLeft;
	tempOverlayView.transform = oldController.view.transform;	
	tempOverlayView.transform = CGAffineTransformScale(tempOverlayView.transform, 1, -1);			
	tempOverlayView.frame = rect;	
	[oldController.view.superview insertSubview:tempOverlayView belowSubview:transitionView];	
	[transitionView startAnimation];	*/
}

- (void)presentModalViewController:(UIViewController*)modalViewController onViewController:(UIViewController*)viewController {
    
	//transitionType = HMGLTransitionTypeControllerPresentation;
	self.oldController = viewController;
	self.currentController = modalViewController;
	[self switchViewControllers];
}

- (void)dismissModalViewController:(UIViewController*)modalViewController {
    
//	transitionType = HMGLTransitionTypeControllerDismission;
	self.oldController = modalViewController;
	if ([modalViewController respondsToSelector:@selector(presentingViewController)]) {
        self.currentController = [modalViewController presentingViewController];
    }
    else {
        self.currentController = modalViewController.parentViewController;
    }
	[self switchViewControllers];
}

/*
- (void)transitionViewDidFinishTransition:(HMGLTransitionView*)_transitionView {
    
	// finish transition
	[transitionView removeFromSuperview];
	[tempOverlayView removeFromSuperview];
	
	// view controllers
	if (transitionType == HMGLTransitionTypeControllerPresentation) {
		[oldController presentModalViewController:currentController animated:NO];
	}
	else if (transitionType == HMGLTransitionTypeControllerDismission) {
		[oldController dismissModalViewControllerAnimated:NO];
	}	
	
	// transition type
	transitionType = HMGLTransitionTypeNone;
}
 */

@end
