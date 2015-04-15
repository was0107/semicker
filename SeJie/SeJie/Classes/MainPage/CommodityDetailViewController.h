//
//  CommodityDetailViewController.h
// sejieios
//
//  Created by allen.wang on 1/14/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "BaseWebViewController.h"
#import "ListGoodsItem.h"

@interface CommodityDetailViewController : BaseWebToolViewController
@property (nonatomic, copy) NSString    *docID;
@property (nonatomic, assign) int type;
@property (nonatomic, retain) ListGoodsItem *goodItem;
@property (nonatomic, copy) NSString    *cpsEvent;

- (id) initWithDocID:(NSString *) theDocID;
- (id) initWithDocID:(NSString *) theDocID withType:(int) theType;
- (id) initWithGoodsItem:(ListGoodsItem *)item;

@end
