//
//  SejieUpdateRequest.m
// sejieios
//
//  Created by Jarry on 13-1-9.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SejieUpdateRequest.h"

@implementation SejieUpdateRequest

@synthesize size = _size;
@synthesize time = _time;

- (id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"size",@"time", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:kIntToString(self.size),kIntToString(self.time), nil];
}

@end
