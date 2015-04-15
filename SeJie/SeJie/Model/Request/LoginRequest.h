//
//  LoginRequest.h
// sejieios
//
//  Created by Jarry on 13-1-17.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface LoginRequest : ListRequestBase

/**
 * username*(String)：用户名
 * password*(String): 密码
 */
@property (nonatomic, copy)     NSString    *username;
@property (nonatomic, copy)     NSString    *password;

@end
