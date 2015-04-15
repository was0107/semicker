//
//  UserInfoResponse.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserInfoResponse.h"

@implementation UserInfoResponse

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
