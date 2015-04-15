//
//  ListResponseBase.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface ListResponseBase : NSObject

@property (nonatomic, assign) NSInteger       succ;                     // *(Int) ：操作状态，1表示成功，0表示失败
@property (nonatomic, copy)   NSString        *msg;                     // *(String)：操作中文信息描述

- (id) initWithJsonString:(NSString *) jsonString;

- (id) initWithDictionary:(const NSDictionary *) dictionary;

@end
