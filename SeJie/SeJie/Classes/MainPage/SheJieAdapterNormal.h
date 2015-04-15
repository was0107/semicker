//
//  SheJieAdapterNormal.h
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterBase.h"
#import "ListPaggingResponseBase.h"

@interface SheJieAdapterNormal : SheJieAdapterBase

@property (nonatomic, assign) BOOL          isNeedRefresh;
@property (nonatomic, retain) NSMutableArray    *contentArray;

@property (nonatomic, retain) ListPaggingResponseBase *response;

- (void) saveTableContent;

- (void) doUpdateRequest;

@end
