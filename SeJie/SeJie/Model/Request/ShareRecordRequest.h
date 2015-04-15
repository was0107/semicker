//
//  ShareRecordRequest.h
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "RecordBaseRequest.h"
#import "ListSeiJieItem.h"

@interface ShareRecordRequest : RecordBaseRequest

@property (nonatomic, copy)     NSString    *touserid;
@property (nonatomic, copy)     NSString    *tousername;
@property (nonatomic, copy)     NSString    *target;
@property (nonatomic, copy)     NSString    *label;


@property (nonatomic, copy)     NSString        *docid;              //*: 用户类型
@property (nonatomic, copy)     NSString        *usertype;              //*: 用户类型
@property (nonatomic, copy)     NSString        *title;                 //*: 标题
@property (nonatomic, copy)     NSString        *orgincreatedate;       //*: 分享时间
@property (nonatomic, copy)     NSString        *keyword;               //*: 搜色界中关键字
@property (nonatomic, copy)     NSString        *content;               //*: SF1搜到的内容
@property (nonatomic, copy)     NSString        *labelnames;            //*: SF1搜到的标题


- (id) initWithItem:(ListSeiJieItem *) item target:(NSString *) target label:(NSString *) label action:(NSUInteger) type;

@end
