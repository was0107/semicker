//
//  WASUImageViewDecorate.m
//  micker
//
//  Created by allen.wang on 7/24/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASUImageViewDecorate.h"


CGPoint initialPoint;
BOOL    isOne;


@interface WASUImageViewDecorate()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) eWASGestureRecognizer gesture;    //type

/**
 * @brief added when init the imageview
 * @return              void
 * @note
 */
- (void)addGestureToImageView;

/**
 * @brief rotate the imageview
 * @param [in]  N/A     gestureRecognizer      

 * @return              void
 * @note
 */
- (void)rotatePicture:(UIRotationGestureRecognizer *)gestureRecognizer;

/**
 * @brief )scale the imageview
 * @param [in]  N/A     gestureRecognizer      
 * @return              void
 * @note
 */
- (void)scalePicture:(UIPinchGestureRecognizer *)gestureRecognizer;
@end

@implementation WASUImageViewDecorate
@synthesize gesture     = _gesture;


- (id)init
{
    [NSException raise:@"Incomplete initializer" 
                format:@"WASUImageViewDecorate must be initialized with a UIImageView and a eWASGestureRecognizer.\
     Use the initWithImageView:gesture: method."];
    return nil;
}


- (void)addWithGesture:(eWASGestureRecognizer)theGesture;
{
	self.clipsToBounds = YES;	
    self.transform = CGAffineTransformIdentity;
    _gesture   = theGesture;
    [self addGestureToImageView];
}


- (void) backToNormal
{
    self.transform = CGAffineTransformIdentity;
}


- (void)dealloc 
{
    [super dealloc];

}
#pragma mark -- private

- (void)addGestureToImageView
{
    if (eWASGestureRecognizerRotation == (_gesture & eWASGestureRecognizerRotation)) {
        //旋转手势
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self 
                                                                                                   action:@selector(rotatePicture:)];
        [self addGestureRecognizer:rotationGesture];
        [rotationGesture setDelegate:self];
        [rotationGesture release];
    }
    
    if (eWASGestureRecognizerPinch == (_gesture & eWASGestureRecognizerPinch)) {
        //放大缩小手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self 
                                                                                          action:@selector(scalePicture:)];
        [pinchGesture setDelegate:self];
        [self addGestureRecognizer:pinchGesture];
        [pinchGesture release];
    }
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *picture = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:picture];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:picture.superview];
        
        picture.layer.anchorPoint = CGPointMake(locationInView.x / picture.bounds.size.width, 
                                                locationInView.y / picture.bounds.size.height);
        picture.center = locationInSuperview;
    }
}

- (void)rotatePicture:(UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform],
                                                                     [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

- (void)scalePicture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], 
                                                                    [gestureRecognizer scale], 
                                                                    [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded  ||
             [gestureRecognizer state] == UIGestureRecognizerStateCancelled  )
    {
        if ([gestureRecognizer scale] < 1 ) {
            
            [gestureRecognizer view].transform = CGAffineTransformIdentity;
            [gestureRecognizer setScale:1];
        }
    }
}

#pragma mark -- gesture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.view != self)
        return NO;
    
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || 
        [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    
    return YES;
}
@end
