//
//  UserAdapter.m
// sejieios
//
//  Created by allen.wang on 2/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UserAdapter.h"

@implementation UserAdapter
@synthesize b5mUser     = _b5mUser;
@synthesize sinaUser    = _sinaUser;
@synthesize weixinUser  = _weixinUser;

+ (UserAdapter *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static UserAdapter * sharedInstance;
    dispatch_once(&onceToken, ^{ sharedInstance = [[UserAdapter alloc] init]; });
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self) {
        _userType = eB5MUserType;
        [self readUserDataFromDB];
    }
    return self;
}

- (UserObject *) b5mUser
{
    if (!_b5mUser) {
        _b5mUser = [[UserObject alloc] init];
        _b5mUser.userIdentifier = @"B5M";
    }
    return _b5mUser;
}

- (UserObject *) sinaUser
{
    if (!_sinaUser) {
        _sinaUser = [[UserObject alloc] init];
        _sinaUser.userType = @"b";
        _b5mUser.userIdentifier = @"SINA";
    }
    return _sinaUser;
}

- (UserObject *) weixinUser
{
    if (!_weixinUser) {
        _weixinUser = [[UserObject alloc] init];
        _weixinUser.userType = @"b";
        _b5mUser.userIdentifier = @"WEIXIN";
    }
    return _weixinUser;
}

- (void) saveCurrentTypeToDB
{
    static NSString *TYPE[] = {@"B5M",@"SINA",@"WEIXIN"};
    UserObject *OBJECT[] = {self.b5mUser,self.sinaUser,self.weixinUser};
    for (NSUInteger i = 0 ; i < 3; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:OBJECT[i] forKey:TYPE[i]];
    }
}

- (void) readUserDataFromDB
{
    static NSString *TYPE[] = {@"B5M",@"SINA",@"WEIXIN"};
    UserObject *OBJECT[] = {self.b5mUser,self.sinaUser,self.weixinUser};
    for (NSUInteger i = 0 ; i < 3; i++) {
        UserObject *object = OBJECT[i];
        UserObject *objectDB =  [[NSUserDefaults standardUserDefaults] objectForKey:TYPE[i]];
        if (objectDB) {
            object.userID       = objectDB.userID;
            object.userName     = objectDB.userName;
            object.userHeader   = objectDB.userHeader;
            object.userGender   = objectDB.userGender;
            object.userNickName = objectDB.userNickName;
        }
    }
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_b5mUser);
    TT_RELEASE_SAFELY(_sinaUser);
    TT_RELEASE_SAFELY(_weixinUser);
    [super dealloc];
}

- (UserObject *) changeUserTypeTo:(int) type
{
    switch (type) {
        case eSinaUserType:
            return [self sinaUser];
        case eWeixinUserType:
            return [self weixinUser];
        default:
            return [self b5mUser];
    }
}

- (UserObject *) currentUserObject
{
    return [self changeUserTypeTo:[self currentUserType]];
}

- (int) currentUserType
{
    return _userType;
}

@end
