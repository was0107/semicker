//
//  SNSShareViewController.h
// sejieios
//
//  Created by Jarry on 13-2-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "BaseShareViewController.h"
#import "ListSeiJieItem.h"


@interface SNSShareViewController : BaseShareViewController

@property   (nonatomic, assign)     ListSeiJieItem  *itemData;
@property   (nonatomic, retain)     UIView          *selectView;
@property   (nonatomic, retain)     UIButton        *weiboBtn;
@property   (nonatomic, retain)     UIButton        *weixinBtn;

@property   (nonatomic, assign)     NSInteger       shareType;

@end
