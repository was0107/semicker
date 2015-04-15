//
//  ListPaggingRequestBase.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"

@interface ListPaggingRequestBase : ListRequestBase
@property (nonatomic, assign) NSUInteger      pageno;                //(Int)：页码
@property (nonatomic, assign) NSUInteger      pagesize;              //(Int)：每页最大数据量
@property (nonatomic, copy)   NSString        *max;

- (id) nextPage;

- (id) firstPage;

- (BOOL) isFristPage;
@end
