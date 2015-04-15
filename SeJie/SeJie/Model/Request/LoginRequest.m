//
//  LoginRequest.m
// sejieios
//
//  Created by Jarry on 13-1-17.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

@synthesize username = _username;
@synthesize password = _password;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_password);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"username", @"password", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.username, self.password, nil];
}

@end
