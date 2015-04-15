//
//  UserAdapter.h
// sejieios
//
//  Created by allen.wang on 2/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"

enum EUSERTYPE {
    eB5MUserType = 0,
    eSinaUserType,
    eWeixinUserType,
};
@interface UserAdapter : NSObject
{
    int _userType;
}

@property (nonatomic, retain) UserObject *b5mUser;
@property (nonatomic, retain) UserObject *sinaUser;
@property (nonatomic, retain) UserObject *weixinUser;

+ (UserAdapter *) sharedInstance;

- (int) currentUserType;

- (UserObject *) currentUserObject;

- (UserObject *) changeUserTypeTo:(int) type;
@end
