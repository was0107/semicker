//
//  SejieUpdateControl.h
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SejieUpdateControl : NSObject
{
    NSTimer *_updateTimer;
}

@property (nonatomic, assign)   NSInteger updateCount;


+ (SejieUpdateControl *) sharedInstance;

- (void) startTimer;

- (void) stopTimer;

- (NSString *) getCountString;

- (void) resetCount;

@end
