//
//  UserObject.m
// sejieios
//
//  Created by allen.wang on 2/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject
@synthesize userID          = _userID;
@synthesize userName        = _userName;
@synthesize userNickName    = _userNickName;
@synthesize userType        = _userType;
@synthesize userHeader      = _userHeader;
@synthesize userGender      = _userGender;
@synthesize userIdentifier  = _userIdentifier;

- (id) init
{
    self = [super init];
    if (self) {
        self.userType = @"a";
    }
    return self;
}

- (NSString *) userNickName
{
    return (_userNickName) ? _userNickName : self.userName;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userID);
    TT_RELEASE_SAFELY(_userName);
    TT_RELEASE_SAFELY(_userNickName);
    TT_RELEASE_SAFELY(_userType);
    TT_RELEASE_SAFELY(_userHeader);
    TT_RELEASE_SAFELY(_userGender);
    [super dealloc];
}
@end
