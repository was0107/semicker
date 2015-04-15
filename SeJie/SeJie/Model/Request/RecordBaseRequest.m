//
//  RecordBaseRequest.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "RecordBaseRequest.h"

@implementation RecordBaseRequest

@synthesize userid   = _userid;
@synthesize username = _username;
@synthesize action   = _action;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_action);
    [super dealloc];
}



@end
