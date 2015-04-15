//
//  UserCoverRecordRequest.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCoverRecordRequest.h"

@implementation UserCoverRecordRequest

@synthesize target  = _target;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_target);
    [super dealloc];
}

- (id) init {
    self = [super init];
    if (self) {
        self.action = [NSString stringWithFormat:@"%d",eRecordActionCover];
    }
    return self;
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid",@"username",@"target",@"action", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:[self userid],[self username],[self target],[self action], nil];
}

@end
