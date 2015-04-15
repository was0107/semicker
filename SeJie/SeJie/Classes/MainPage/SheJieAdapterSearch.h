//
//  SheJieAdapterSearch.h
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterBase.h"
#import "SejieSearchResponse.h"
#import "SejieSearchRequest.h"

@interface SheJieAdapterSearch : SheJieAdapterBase

@property (nonatomic, retain) SejieSearchResponse   *response;

- (void) setRequestData:(NSString *)keyword category:(NSString *)category;

@end
