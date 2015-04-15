//
//  AutoFillRequest.m
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "AutoFillRequest.h"

@implementation AutoFillRequest

@synthesize keyword = _keyword;
@synthesize limit = _limit;

- (id) init {
    self = [super init];
    if (self) {
        _limit = 20;
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_keyword);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"keyword", @"limit", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.keyword, kIntToString(self.limit), nil];
}

@end
