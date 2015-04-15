//
//  DetailItemScrollView.h
// sejieios
//
//  Created by allen.wang on 1/15/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListSeiJieItem.h"
#import "DetailTopView.h"
#import "DetailMiddleView.h"
#import "B5MTableViewBase.h"
#import "CommentsTableView.h"
#import "CommodityDetailViewController.h"
#import "DetailCommentsView.h"


@interface DetailItemScrollView : UIView<UIScrollViewDelegate>
{
    int _staticHeight ;
}

@property (nonatomic, retain) ListSeiJieItem    *responseItem;
@property (nonatomic, assign)   NSString        *imageURLString;
@property (nonatomic, copy)   NSString          *keyword;
@property (nonatomic, retain) DetailTopView     *topView;
@property (nonatomic, retain) DetailMiddleView  *middleView;
@property (nonatomic, retain) CommentsTableView *tableView;
@property (nonatomic, retain) UILabel           *guessLabel;
@property (nonatomic, retain) UIScrollView      *contentView;
@property (nonatomic, retain) DetailCommentsView *commentsView;
@property (nonatomic, assign) UIViewController  *viewController;
@property (nonatomic, assign) BOOL              enableClickUser;
@property (nonatomic, assign) SheJieAdapterBase *adapter;


- (void) sendRequestToServer;

- (void) sendCommentsToServer;

- (BOOL) sendRequestToServerEx;

- (BOOL) sendCommentsToServerEx;

- (void) resetData;

@end
