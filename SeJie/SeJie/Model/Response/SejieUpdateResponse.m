//
//  SejieUpdateResponse.m
// sejieios
//
//  Created by Jarry on 13-1-9.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SejieUpdateResponse.h"

@implementation SejieUpdateResponse
@synthesize times = _times;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_times);
    [super dealloc];
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    [super translateFrom:dictionary];
    self.times = [dictionary objectForKey:@"times"];
    return self;
}

@end
