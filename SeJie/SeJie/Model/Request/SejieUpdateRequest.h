//
//  SejieUpdateRequest.h
// sejieios
//
//  Created by Jarry on 13-1-9.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface SejieUpdateRequest : ListRequestBase

@property (nonatomic, assign) NSUInteger    size;   //(Int)：条目数(需小于等于50)
@property (nonatomic, assign) NSUInteger    time;   //(Int)：次数（第几次更新，由客户端管理维护，每调用此接口一次加１，一天过后还原成１）

@end
