//
//  ListDetailRequest.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListRequestBase.h"

@interface ListDetailRequest : ListRequestBase

@property (nonatomic, copy)     NSString        *docid;     //*(String)：色界图片ID值
@property (nonatomic, copy)     NSString        *label;     //(String): 此图片对应的标签值，允许为空
@property (nonatomic, copy)     NSString        *keyword;   //*(String)：针对搜索详情接口
@property (nonatomic, copy)     NSString        *userid;     //*(String)：色界图片ID值
@property (nonatomic, copy)     NSString        *usertype;   //(String): 此图片对应的标签值，允许为空

@property (nonatomic, copy)     NSString        *content;
@property (nonatomic, copy)     NSString        *labelname;

@end
