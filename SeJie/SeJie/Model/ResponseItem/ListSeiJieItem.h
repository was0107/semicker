//
//  ListSeiJieItem.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListImageItem.h"

@interface ListSeiJieItemBase : ListImageItem

@property (nonatomic, copy) NSString        *docid;                 //": "7973656",
@property (nonatomic, copy) NSString        *title;                 //": "",
@property (nonatomic, copy) NSString        *urlName;                 //": "",



- (NSString *) subItemRequestString;

@end


//3.3.	精彩色界更新  (wonderfulupdate)
//3.4.	发现色界搜索翻页  (commsejiesearch)
@interface ListSeiJieItem : ListSeiJieItemBase


@property (nonatomic, copy)     NSString        *pinId;
@property (nonatomic, copy)     NSString        *label;             //": "123"
@property (nonatomic, copy)     NSString        *userid;            //:用户ID
@property (nonatomic, copy)     NSString        *username;          //:用户名称
@property (nonatomic, copy)     NSString        *userType;          //:用户类型
//@property (nonatomic, copy)     NSString        *userImg;           //:用户头像
@property (nonatomic, copy)     NSString        *type;              //:分享类型
@property (nonatomic, copy)     NSString        *likecnt;           //:喜欢数
@property (nonatomic, copy)     NSString        *commentcnt;        //:评论数
@property (nonatomic, copy)     NSString        *visitcnt;          //:浏览数
@property (nonatomic, copy)     NSString        *createtime;        //:创建时间

@property (nonatomic, assign)   NSUInteger      commentIntCnt;      //
@property (nonatomic, copy)     NSString        *content;
@property (nonatomic, copy)     NSString        *labelname;
@property (nonatomic, copy)     NSString        *keyword;


@property (nonatomic, retain) id        detailResponse;
@property (nonatomic, retain) id        commentResponse;

@end
