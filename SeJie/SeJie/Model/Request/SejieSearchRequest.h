//
//  SejieSearchRequest.h
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListSheJieRequestBase.h"


@interface SejieSearchRequest : ListSheJieRequestBase
@property (nonatomic, copy)     NSString            *keyword;
@property (nonatomic, copy)     NSMutableArray      *category;

@end
