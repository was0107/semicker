//
//  LoginResponse.m
// sejieios
//
//  Created by Jarry on 13-1-18.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

@synthesize userInfo = _userInfo;

- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.userInfo = [self translateFrom:dictionary];
    }
    return self;
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    return [[[UserInfoItem alloc] initWithDictionary:dictionary] autorelease];
}


@end
