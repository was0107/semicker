//
//  ListPaggingResponseBase.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListResponseBase.h"

@interface ListPaggingResponseBase : ListResponseBase

@property (nonatomic, retain) NSMutableArray * result;                  //结果集
@property (nonatomic, assign) NSInteger       count;                    // *(int): 结果集总数
@property (nonatomic, assign) NSInteger       arrayCount;               // (int)：搜索结果组合列表计数

- (NSString *) resultKey;

- (id) translateFrom:(const NSDictionary *) dictionary;
- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index;

- (void) appendPaggingFromJsonString:(NSString *) jsonString;

- (BOOL) reachTheEnd;

- (BOOL) isEmpty;


@end
