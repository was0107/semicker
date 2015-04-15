//
//  ListDetailResponse.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListPaggingResponseBase.h"
#import "ListGoodsItem.h"
#import "ListDetailItem.h"


//3.5.	色界详情  (detail)
@interface ListDetailResponse : ListPaggingResponseBase
@property (nonatomic, retain) ListDetailItem *detailItem;

@end
