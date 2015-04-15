//
//  ListAddCommentRequest.h
// sejieios
//
//  Created by allen.wang on 1/23/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListRequestBase.h"
#import "ListSeiJieItem.h"

@interface ListAddCommentRequest : ListRequestBase

@property (nonatomic, copy)     NSString        *docid;      //*(String)：色界图片ID值
@property (nonatomic, copy)     NSString        *userid;     //*(String)：色界图片ID值
@property (nonatomic, copy)     NSString        *comment;    //*(String)：comment's content

@property (nonatomic, copy)     NSString        *username;          //*: 喜欢用户名,
@property (nonatomic, copy)     NSString        *touserid;          //*: 被喜欢用户,
@property (nonatomic, copy)     NSString        *tousername;        //*: 被喜欢用户名,
@property (nonatomic, copy)     NSString        *target;            //*: 喜欢对象,
@property (nonatomic, copy)     NSString        *label;             //*: 对象标签


@property (nonatomic, copy)     NSString        *usertype;              //*: 用户类型
@property (nonatomic, copy)     NSString        *title;                 //*: 标题
@property (nonatomic, copy)     NSString        *orgincreatedate;       //*: 分享时间
@property (nonatomic, copy)     NSString        *keyword;               //*: 搜色界中关键字
@property (nonatomic, copy)     NSString        *content;               //*: SF1搜到的内容
@property (nonatomic, copy)     NSString        *labelnames;            //*: SF1搜到的标题

- (id) initWithDocID:(NSString *) docID userID:(NSString *) userID comment:(NSString *) content item:(ListSeiJieItem *) item;
@end
