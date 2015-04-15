//
//  MainDetailViewController.h
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseViewController.h"
#import "ListSeiJieItem.h"
#import "ListDetailResponse.h"
#import "SheJieAdapterBase.h"

@interface MainDetailViewController : BaseViewController
@property (nonatomic, copy)   NSString          *keyword;
@property (nonatomic, retain) ListSeiJieItem    *responseItem;
@property (nonatomic, copy)   NSString          *imageURLString;
@property (nonatomic, retain) NSMutableArray    *contents;

@property (nonatomic, assign) SheJieAdapterBase *adapter;
@property (nonatomic, assign) BOOL               enableClickUser;
@end
