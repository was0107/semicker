//
//  ListGuangItem.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListImageItem.h"

@interface ListGuangItemBase : ListImageItem
@property (nonatomic, copy) NSString        *docid;                 //": "7973656",
@property (nonatomic, copy) NSString        *title;                 //": "",
@property (nonatomic, copy) NSString        *like;                 //": "123"

@end

@interface ListGuangItem : ListGuangItemBase

- (NSString *) subItemRequestString;

@end
