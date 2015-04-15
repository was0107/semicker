//
//  ThirdLoginRequest.h
// sejieios
//
//  Created by Jarry on 13-1-18.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface ThirdLoginRequest : ListRequestBase

/**
 * uid*(String)：第三方授权ID
 * type*(String): weibo/qq
 */
@property (nonatomic, copy)     NSString    *uid;
@property (nonatomic, copy)     NSString    *type;

@end
