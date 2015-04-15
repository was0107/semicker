//
//  ThirdLoginRequest.m
// sejieios
//
//  Created by Jarry on 13-1-18.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ThirdLoginRequest.h"

@implementation ThirdLoginRequest

@synthesize uid = _uid;
@synthesize type = _type;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_uid);
    TT_RELEASE_SAFELY(_type);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"uid", @"type", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.uid, self.type, nil];
}

@end
