//
//  ListCommentsRequest.h
// sejieios
//
//  Created by allen.wang on 1/10/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@interface ListCommentsRequest : ListPaggingRequestBase
@property (nonatomic, copy)     NSString        *docid;     //

@end
