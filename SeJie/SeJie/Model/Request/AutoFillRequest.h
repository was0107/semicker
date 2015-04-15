//
//  AutoFillRequest.h
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface AutoFillRequest : ListRequestBase

@property (nonatomic, copy)     NSString    *keyword;
@property (nonatomic, assign)   NSUInteger  limit;

@end
