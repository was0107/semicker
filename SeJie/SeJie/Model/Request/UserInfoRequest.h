//
//  UserInfoRequest.h
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface UserInfoRequest : ListRequestBase

@property (nonatomic, copy)     NSString    *userid;
@property (nonatomic, copy)     NSString    *usertype;  //a:B5M用户   b:第三方用户


@end
