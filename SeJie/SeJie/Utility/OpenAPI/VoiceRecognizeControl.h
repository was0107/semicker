//
//  VoiceRecognizeControl.h
// sejieios
//
//  Created by Jarry on 13-1-6.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "iFlyMSC/IFlyRecognizeControl.h"

@interface VoiceRecognizeControl : NSObject //<IFlyRecognizeControlDelegate>

//@property (nonatomic, retain)   IFlyRecognizeControl    *iFlyRecognizeControl;
@property (nonatomic, retain)   UIButton                *backView;

@property (nonatomic, copy)     voidBlock   cancelBlock;
@property (nonatomic, copy)     idBlock     completeBlock;


+ (VoiceRecognizeControl *) sharedInstance;


- (void) startRecognize:(UIView *) parentView completeBlock:(idBlock) completeBlock cancelBlock:(voidBlock) cancelBlock;

- (void) startRecognize:(idBlock) completeBlock cancelBlock:(voidBlock) cancelBlock;

- (void) cancel;

- (void) bringToFront:(UIView *) parentView;

@end
