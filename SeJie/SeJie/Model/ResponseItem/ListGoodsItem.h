//
//  ListGoodsItem.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListSeiJieItem.h"

//3.5.	色界详情  (detail)
@interface ListGoodsItem : ListSeiJieItemBase
@property (nonatomic, copy)     NSString        *price;             //:
@property (nonatomic, copy)     NSString        *source;            //:
@property (nonatomic, copy)     NSString        *category;          //:
@property (nonatomic, copy)     NSString        *type;              //:

@end
