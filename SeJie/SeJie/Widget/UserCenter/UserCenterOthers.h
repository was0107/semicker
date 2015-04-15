//
//  UserCenterOthers.h
// sejieios
//
//  Created by Jarry on 13-2-6.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCenterView.h"
#import "MainTableView.h"
#import "ListMyShareRequest.h"
#import "ListSeiJieResponseBase.h"

@interface UserCenterOthers : UserCenterView

@property (nonatomic, retain)   UIImageView     *tagImageView;
@property (nonatomic, retain)   UIImageView     *emptyTipView;

@property (nonatomic, retain)   ListAccountResponseBase *photoResponse;
@property (nonatomic, retain)   ListAccountRequest      *photoRequest;
@property (nonatomic, retain)   NSMutableArray          *contentArray;
@property (nonatomic, retain)   LayoutCellShejieModel   *cellModel;


@end
