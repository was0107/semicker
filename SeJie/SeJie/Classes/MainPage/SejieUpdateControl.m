//
//  SejieUpdateControl.m
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SejieUpdateControl.h"

@implementation SejieUpdateControl

@synthesize updateCount = _updateCount;


+ (SejieUpdateControl *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static SejieUpdateControl * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SejieUpdateControl alloc] init];
    });
    return sharedInstance;
}

- (SejieUpdateControl *) init
{
    if ((self = [super init])) {
        //
        self.updateCount = -1;
    }
    return self;
}

- (void)dealloc
{
    [self stopTimer];
    [super dealloc];
}

- (void) startTimer
{
    [self stopTimer];
        
    int time = [self getRandomNumber:30 to:90];
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                    target:self
                                                  selector:@selector(timerAction)
                                                  userInfo:nil
                                                   repeats:NO];
    DEBUGLOG(@"-- update startTimer == %d", time);
}

- (void) stopTimer
{
    if (_updateTimer && [_updateTimer isValid]) {
        [_updateTimer invalidate];
        _updateTimer = nil;
    }
}

- (void) timerAction
{
    self.updateCount += [self getRandomNumber:11 to:20];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSejieUpdateNotification object:[self getCountString]];
    
    if (self.updateCount <= 99) {
        [self startTimer];
    }
    else {
        [self stopTimer];
    }
}

- (NSString *) getCountString
{
    return (self.updateCount > 99) ? @"99+" : kIntToString(self.updateCount);
}

- (void) resetCount
{
    self.updateCount = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSejieUpdateNotification object:nil];
    
}

- (int) getRandomNumber:(int)from to:(int)to
{
    return (int) (from + arc4random() % (to-from));
}

@end
