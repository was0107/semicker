//
//  ListSeiJieResponseBase.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListPaggingResponseBase.h"
#import "ListSeiJieItem.h"



//3.3.	精彩色界更新  (wonderfulupdate)
//3.4.	发现色界搜索翻页  (commsejiesearch)
@interface ListSeiJieResponseBase : ListPaggingResponseBase
@property (nonatomic, assign) NSInteger         realpageno;     //*(int):服务器设置的页码
@property (nonatomic, copy) NSString            *maxId;


@end



@interface ListAccountResponseBase : ListSeiJieResponseBase

@end
