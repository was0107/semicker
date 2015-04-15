//
//  WASMotionDecorate.m
//  micker
//
//  Created by allen.wang on 8/17/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASMotionDecorate.h"
#import "UIDevice+extend.h"

#define kMotionDefatultRate      1.0f/10.0f
#define kAccelerometerData0      0.25f
#define kAccelerometerData1      0.55f
#define kAccelerometerData2      0.6f
#define kAccelerometerData3      0.8f
#define kSharkeAccelerometer     1.8f
#define kListStartCount          100

@interface WASMotionDecorate()
{
    BOOL                    _isTaped;               // check if it's tapped
    BOOL                    _isAngle;               // check if it's tapped
    BOOL                    _isShaked;              // check if it's shaked
}

@property (nonatomic, copy) motionBlock  customMotion;
@property (nonatomic, copy) motionBlock  shakedMotion;
@property (nonatomic, copy) motionBlock  lowMotion;
@property (nonatomic, copy) motionBlock  midMotion;
@property (nonatomic, copy) motionBlock  highMotion;
@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) NSOperationQueue *motionQueue;
@property (nonatomic, assign) WASAccelration    acclelration;

/**
 *	@brief	add motion block with type
 */
- (NSUInteger) addMotion:(WASMotionType ) type withBlock:(motionBlock) block;

/**
 *	@brief	stop motion
 */
- (void) stopMotionManager;

/**
 *	@brief	start motion
 */
- (void) startMotionManager;

/**
 *	@brief	set all bloks to nil    
 */
- (void) emptyBlocks;


@end

@implementation WASMotionDecorate
@synthesize customMotion = _customMotion;
@synthesize shakedMotion = _shakedMotion;
@synthesize lowMotion    = _lowMotion;
@synthesize midMotion    = _midMotion;
@synthesize highMotion   = _highMotion;
@synthesize motionQueue  = _motionQueue;
@synthesize motionManager= _motionManager;
@synthesize acclelration = _acclelration;


+ (WASMotionDecorate*)sharedMotion {
    static dispatch_once_t once;
    static WASMotionDecorate *sharedMotion;
    dispatch_once(&once, ^ { sharedMotion = [[WASMotionDecorate alloc] init]; });
    return sharedMotion;
}

- (CMMotionManager *) motionManager
{
    if (!_motionManager)  {
        
        _motionManager  = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = kMotionDefatultRate;
    }
    return _motionManager;
}

- (NSOperationQueue *) motionQueue
{
    if (!_motionQueue)  {
        _motionQueue = [NSOperationQueue currentQueue];
        
    }
    return _motionQueue;
}

- (void) emptyBlocks
{
    self.customMotion = nil;
    self.shakedMotion = nil;
    self.lowMotion    = nil;
    self.midMotion    = nil;
    self.highMotion   = nil;
}


- (void) stopMotionManager
{
    if ([self motionManager]) {
        
        [[self motionManager] stopAccelerometerUpdates];
        [self emptyBlocks];
    }
}

- (void) dealloc
{
    [self stopMotionManager];
    self.motionManager = nil;
    self.motionQueue = nil;
    [super dealloc];
}

- (void) startMotionManager
{
    _isShaked   = NO;  
    _isTaped    = NO;
    _isAngle    = NO;
    
    if ([[UIDevice currentDevice] isIPhone3GS]) {
        return;
    }
    
    if ([self motionManager].isDeviceMotionAvailable)
    {
        
        if ([self motionManager].isAccelerometerActive) {
            DEBUGLOG(@"motion manager is active!" );
            return;
        }
        __block int  count  = 0;    
        [[self motionManager] startAccelerometerUpdatesToQueue:[self motionQueue]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) 
        {
            if (self.customMotion) {
                self.customMotion(accelerometerData, error);
            }
            else {
                float valueX= fabsf(accelerometerData.acceleration.x);
                float valueY= fabsf(accelerometerData.acceleration.y);
                float value = 0.0f;
                
                if(EWASAccelerationX ==  self.acclelration)
                    value = valueX;
                else if (EWASAccelerationY ==  self.acclelration)
                    value = valueY;
                else {
                    value = fmaxf(valueX,valueY);
                }
                
                if (value > kSharkeAccelerometer)
                {
                    if (!_isShaked) 
                    {
                        _isShaked = YES;
                        [self stopMotionManager];
                        if (self.shakedMotion) 
                        {
                            self.shakedMotion(accelerometerData, error);
                        }
                    }
                    return;
                }
                
                if (value < kAccelerometerData0)
                {
                    _isTaped = NO;
                    if (self.lowMotion) 
                    {
                        self.lowMotion(accelerometerData, error);
                    }
                    _isAngle = NO;
                    count    = 0;
                }
                else if ( value > kAccelerometerData1)
                {
                    _isAngle = YES;
                    if (INT32_MAX == count++ ) 
                    {       
                        count = kListStartCount;
                    }
                    if (!_isTaped && self.midMotion) 
                    {
                        self.midMotion(accelerometerData, error);
                    }
                }
                else 
                {
                    _isAngle = YES;
                    if (INT32_MAX == count++ ) 
                    {       
                        count = kListStartCount;
                    }
                    if (!_isTaped && self.highMotion)
                    {                                
                        self.highMotion(accelerometerData, error);
                        
                    }
                    
                }
            }
        } ];
        
    }
    else 
    {
        DEBUGLOG(@"device motion is not available." );
        TT_RELEASE_SAFELY(_motionManager);
    }

}

- (NSUInteger) addMotion:(WASMotionType ) type withBlock:(motionBlock) block
{
    if (!block)
        return 0;

    if (EWASMotionCustom == (type & EWASMotionCustom)) 
    {
        self.customMotion = block;
        return type ^ EWASMotionCustom;
    }
    else if(EWASMotionShake == (type & EWASMotionShake))
    {
        self.shakedMotion = block;
        return type ^ EWASMotionShake;
    }
    else if(EWASMotionLow == (type & EWASMotionLow))
    {
        self.lowMotion = block; 
        return type ^ EWASMotionLow;
    }
    else if(EWASMotionMid == (type & EWASMotionMid))
    {
        self.midMotion = block;
        return type ^ EWASMotionMid;
    }
    else if(EWASMotionHigh == (type & EWASMotionHigh))
    {
        self.highMotion = block;
        return type ^ EWASMotionHigh;
    }
    return 0;
}

#pragma mark public function


+ (void) addMotionWithType:(WASMotionType ) type withBlocks:(motionBlock) block,...
{
    [[WASMotionDecorate sharedMotion] stopMotionManager];

    if (block)
    {
        [[WASMotionDecorate sharedMotion] setAcclelration:EWASAccelerationX];
        
        va_list list;
        motionBlock arg         = NULL;
        NSUInteger motionType   = type;

        motionType = [[WASMotionDecorate sharedMotion] addMotion:motionType withBlock:block];
        
        va_start(list, block);
        while( (arg = va_arg(list,motionBlock)))   
        {  
            motionType = [[WASMotionDecorate sharedMotion] addMotion:motionType withBlock:arg];
        }  
        va_end(list);
        [[WASMotionDecorate sharedMotion] startMotionManager];
    }
    
}

+ (void) addMotionAccleration:(WASAccelration) accleration WithType:(WASMotionType ) type withBlocks:(motionBlock) block,...
{
    [[WASMotionDecorate sharedMotion] stopMotionManager];
    
    if (block)
    {
        [[WASMotionDecorate sharedMotion] setAcclelration:accleration];
    
        va_list list;
        motionBlock arg         = NULL;  
        NSUInteger motionType   = type;
      
        motionType = [[WASMotionDecorate sharedMotion] addMotion:motionType withBlock:block];
        
        va_start(list, block);
        while( (arg = va_arg(list,motionBlock)))   
        {  
            motionType = [[WASMotionDecorate sharedMotion] addMotion:motionType withBlock:arg];
        }  
        va_end(list);
        
        [[WASMotionDecorate sharedMotion] startMotionManager];
    }
}


@end
