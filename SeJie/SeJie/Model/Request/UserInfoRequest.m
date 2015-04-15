//
//  UserInfoRequest.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserInfoRequest.h"

@implementation UserInfoRequest

@synthesize userid      = _userid;
@synthesize usertype    = _usertype;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_usertype);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid",@"usertype", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:[self userid],[self usertype], nil];
}

@end
