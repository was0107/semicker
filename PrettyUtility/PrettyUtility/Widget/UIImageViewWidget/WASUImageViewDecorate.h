//
//  WASUImageViewDecorate.h
//  micker
//
//  Created by allen.wang on 7/24/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  
{
    eWASGestureRecognizerNone     = 0,          // no  recognizer
    eWASGestureRecognizerRotation = 1<<0,       // add rotation to the imageView
    eWASGestureRecognizerPinch    = 1<<1,       // add pinch to the imageView
    
}eWASGestureRecognizer;

@interface WASUImageViewDecorate : UIImageView


/**
 * @brief add gesture to the imageView
 *
 * 
 * @param [in]  N/A     theGesture      It's combined by eWASGestureRecognizer type
 * @return              void
 * @note
 */
- (void)addWithGesture:(eWASGestureRecognizer)theGesture;

- (void) backToNormal;

@end
