//
//  WASEXTableView.h
//  micker
//
//  Created by allen.wang on 7/12/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WASRefreshTableHeader.h"
#import "WASScrollViewDecorate.h"

@protocol WASEXTableViewDelegate;

@interface WASEXTableView : UITableView 

@property (nonatomic, assign) BOOL didReachTheEnd;
@property (nonatomic, assign) id<WASScrollViewDecorateDelegate> exDelegate;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id) theDelegate;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)launchRefreshing;

- (void)prepareRefreshing:(voidBlock)block;

- (void)tableViewDidFinishedLoading ;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

@end
