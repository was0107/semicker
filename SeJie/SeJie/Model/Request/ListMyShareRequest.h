//
//  ListMyShareRequest.h
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@interface ListAccountRequest : ListPaggingRequestBase

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *searchType;
@end

@interface ListMyShareRequest : ListAccountRequest

@end
