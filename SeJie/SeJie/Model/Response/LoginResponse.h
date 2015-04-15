//
//  LoginResponse.h
// sejieios
//
//  Created by Jarry on 13-1-18.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListResponseBase.h"
#import "UserInfoItem.h"

@interface LoginResponse : ListResponseBase

@property (nonatomic, retain) UserInfoItem *userInfo;

- (id) translateFrom:(const NSDictionary *) dictionary;

@end
