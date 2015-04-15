//
//  ListUserRecordRequest.h
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@interface ListUserRecordRequest : ListPaggingRequestBase

@property (nonatomic, copy)     NSString    *userid;

@end
