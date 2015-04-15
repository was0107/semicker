//
//  DetailScrollView.h
// sejieios
//
//  Created by allen.wang on 1/15/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseSwipeView.h"
#import "ListSeiJieItem.h"
#import "SheJieAdapterBase.h"

@interface DetailScrollView : BaseSwipeView
{
    __block BOOL indexDidChanged;
    __block BOOL didReachTheEnd;
}
@property (nonatomic, copy)   NSString          *keyword;
@property (nonatomic, retain) ListSeiJieItem    *responseItem;
@property (nonatomic, assign) UIViewController  *viewController;
@property (nonatomic, assign) BOOL              enableClickUser;

@property (nonatomic, assign) SheJieAdapterBase *adapter;


- (void) saveImage;

@end
