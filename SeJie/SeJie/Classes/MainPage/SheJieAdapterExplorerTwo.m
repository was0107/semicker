//
//  SheJieAdapterExplorerTwo.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterExplorerTwo.h"
#import "MainTableView.h"

@implementation SheJieAdapterExplorerTwo

- (void) setContentData
{
    [super setContentData];
    
    self.pageViewId     = TD_PAGE_SEJIE_EXPLORE;
    self.method         = @"favorite/food_drink/";
    self.responseClass  = @"ListSeiJieResponseBase";
    self.modelClass     = @"LayoutCellShejieModel";
    self.headerBlock    = nil;
    self.request        = [[[ListSheJieExplorerRequest alloc] init] autorelease];
    self.rightButtonHidden = NO;
    self.showArrow         = YES;
}

- (void) emptyContents
{
    [((MainTableView *)[self tableView]) emptyData];
}

- (void) sendRequestToServer
{
    ((MainTableView *)[self tableView]).adapterBase = self;
    [(MainTableView *)[self tableView] doSendRequest:YES];
}

- (NSString *) refreshPV
{
    return TD_EVENT_EXPLORE_REFRESH_PV;
}

- (NSString *) imagePV
{
    return TD_EVENT_EXPLORE_IMAGE_PV;
}

- (NSString *) imageSavePV
{
    return TD_EVENT_EXPLORE_IMAGE_SAVE_PV;
}

- (NSString *) imageLikePV
{
    return TD_EVENT_EXPLORE_IMAGE_LIKE_PV;
}

- (NSString *) imageSharePV
{
    return TD_EVENT_EXPLORE_IMAGE_SHARE_PV;
}

- (NSString *) imageUserPV
{
    return TD_EVENT_EXPLORE_IMAGE_USER_PV;
}

- (NSString *) imageGoodsPV
{
    return TD_EVENT_EXPLORE_IMAGE_GOODS_PV;
}

- (NSString *) imageGoodsMC
{
    return TD_EVENT_EXPLORE_IMAGE_GOODS_MC;
}

- (NSString *) imageGoodsCPS
{
    return TD_EVENT_EXPLORE_IMAGE_GOODS_CPS;
}

- (void) actionNoLeave
{
    [self emptyContents];
    [self sendRequestToServer];
}

@end
