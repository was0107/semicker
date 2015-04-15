//
//  WASMotionDecorate.h
//  micker
//
//  Created by allen.wang on 8/17/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

#ifndef motionBlock
typedef void (^motionBlock)(CMAccelerometerData *accelerometerData, NSError *error);
#endif

enum EWASMotionType {
    EWASMotionCustom = 1,   /**< custom motion  description */
    EWASMotionShake = 1<<1, /**< shake motion description */
    EWASMotionLow   = 1<<2, /**< low motion description */
    EWASMotionMid   = 1<<3, /**< mid motion description */
    EWASMotionHigh  = 1<<4  /**< high motion description */
};
typedef NSUInteger WASMotionType;

enum EWASAcceleration {
    EWASAccelerationX  = 0,
    EWASAccelerationY  = 1,
    EWASAccelerationXY = 1<<1,
};

typedef NSUInteger WASAccelration;



@interface WASMotionDecorate : NSObject

/**
 *	@brief	add motion with block , importent "..." are all motionBlock content.
 *          when this function is called . all that added before will be dealloced
 *
 *  @importent: the block parameters should be ended with nil,or It will crashed.
 */
+ (void) addMotionWithType:(WASMotionType ) type withBlocks:(motionBlock) block,...;
+ (void) addMotionAccleration:(WASAccelration) accleration WithType:(WASMotionType ) type withBlocks:(motionBlock) block,...;

@end
