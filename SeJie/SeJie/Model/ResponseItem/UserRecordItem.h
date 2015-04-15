//
//  UserRecordItem.h
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListResponseItemBase.h"
#import "ListSeiJieItem.h"

@interface UserRecordItem : ListResponseItemBase

@property (nonatomic, copy)     NSString        *itemid;            //:ID
@property (nonatomic, copy)     NSString        *userid;            //:用户ID
@property (nonatomic, copy)     NSString        *username;          //:用户名称
@property (nonatomic, copy)     NSString        *targetUrl;         //:图片Url
@property (nonatomic, copy)     NSString        *docid;             //:图片docid
@property (nonatomic, copy)     NSString        *comment;           //:评论
@property (nonatomic, copy)     NSString        *time;              //:时间
@property (nonatomic, assign)   NSInteger       actionId;           //:recordID



@property (nonatomic, copy)     NSString        *usertype;              //*: 用户类型
@property (nonatomic, copy)     NSString        *title;                 //*: 标题
@property (nonatomic, copy)     NSString        *orgincreatedate;       //*: 分享时间
@property (nonatomic, copy)     NSString        *keyword;               //*: 搜色界中关键字
@property (nonatomic, copy)     NSString        *content;               //*: SF1搜到的内容
@property (nonatomic, copy)     NSString        *labelnames;            //*: SF1搜到的标题

- (CGFloat) imageHeight;


- (ListSeiJieItem *) seiJieItem;

@end
