//
//  ListVisitAndLikeResponse.h
// sejieios
//
//  Created by allen.wang on 1/21/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListResponseBase.h"

@interface ListVisitAndLikeResponse : ListResponseBase
@property (nonatomic, copy)     NSString        *likecnt;           //:喜欢数
@property (nonatomic, copy)     NSString        *visitcnt;          //:浏览数
@end
