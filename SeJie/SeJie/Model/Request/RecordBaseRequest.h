//
//  RecordBaseRequest.h
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface RecordBaseRequest : ListRequestBase

@property (nonatomic, copy)     NSString    *userid;
@property (nonatomic, copy)     NSString    *username;
@property (nonatomic, copy)     NSString    *action;

@end
