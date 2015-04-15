//
//  WASScrollViewDecorate.h
//  TestTableView
//
//  Created by allen.wang on 9/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WASRefreshTableHeader.h"
#import "BlockDefines.h"

#define kContentSizeHeightDecorate      10.0f

@protocol WASScrollViewDecorateDelegate;

@interface WASScrollViewDecorate : UIView<UIScrollViewDelegate>
@property (nonatomic, assign) BOOL didReachTheEnd;
@property (nonatomic, assign) BOOL waitUntilEndDragging;
@property (nonatomic, assign) BOOL autoScrollToNextPage;
@property (nonatomic, assign) id<WASScrollViewDecorateDelegate> exDelegate;
@property (nonatomic, retain) UIScrollView *scrollContentView;

- (id)initWithFrame:(CGRect)frame with:(UIScrollView *) scrollView type:(eViewType)theType delegate:(id) theDelegate;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)launchRefreshing;

- (void)prepareRefreshing:(voidBlock)block;

- (void)tableViewDidFinishedLoading ;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

@end


@protocol WASScrollViewDecorateDelegate <NSObject>
@optional

- (void)tableViewDidStartRefreshing:(WASScrollViewDecorate *)tableView;

- (void)tableViewDidStartLoading:(WASScrollViewDecorate *)tableView;

@end