//
//  ListShareRequest.h
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListRequestBase.h"

@interface ListShareRequest : ListRequestBase
{
    __block NSString *_pic;
}

@property (nonatomic, copy)     NSString    *userID;
@property (nonatomic, copy)     NSString    *username;
@property (nonatomic, copy)     NSString    *comment;
@property (nonatomic, copy)     NSString    *pic;
@property (nonatomic, copy)     NSString    *userType;

@end
