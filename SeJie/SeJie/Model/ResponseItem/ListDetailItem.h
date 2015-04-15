//
//  ListDetailItem.h
// sejieios
//
//  Created by allen.wang on 1/9/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListSeiJieItem.h"

@interface ListDetailItem : ListImageItem
@property (nonatomic, copy)     NSString        *userImg;           //:用户头像
@property (nonatomic, copy)     NSString        *likecnt;           //:喜欢数
@property (nonatomic, copy)     NSString        *visitcnt;          //:浏览数

@end
