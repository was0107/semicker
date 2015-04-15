//
//  WASASILogAdatper.m
//  micker
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASASILogAdatper.h"

@interface WASASILogAdatper()
@property (nonatomic, retain)  WASBaseAdapter *adapter;
@property (nonatomic, assign)  NSTimeInterval late1;
@end


@implementation WASASILogAdatper
@synthesize adapter = _adapter;
@synthesize late1   = _late1;

- (id) initWithAdapter:(WASBaseAdapter *)adapter
{
    self = [super init];
    if (self) {
        [self setAdapter:adapter];
    }
    return self;
}

- (void) startService
{
    [super startService];

    _late1 =[[NSDate date] timeIntervalSince1970];
    [_adapter startService];
}

- (void) success
{
    [super success];

    DEBUGLOG(@">>>>>>succeed time interval = [%f]", [[NSDate date] timeIntervalSince1970] - _late1);
    [_adapter success];
}

- (void) failed
{
    [super failed];
    
    DEBUGLOG(@"<<failed time interval = [%f]", [[NSDate date] timeIntervalSince1970] - _late1);
    [_adapter failed];
}

- (void) error
{
    [super error];
    
    DEBUGLOG(@"<<error time interval = [%f]", [[NSDate date] timeIntervalSince1970] - _late1);
    [_adapter error];
}


- (void) dealloc
{
    [_adapter release], _adapter = nil;
    [super dealloc];
}
@end
