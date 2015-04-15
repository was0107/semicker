//
//  SheJieAdapterExplorer.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterExplorer.h"
#import "ExplorerTableView.h"

@implementation SheJieAdapterExplorer

- (void) setContentData
{
    [super setContentData];

    self.pageViewId     = TD_PAGE_SEJIE_EXPLORE;
    self.title          = kTitleDiscoveryString;
    self.method         = @"explore/xiajijiepai/";
    self.responseClass  = @"ListSeiJieResponseBase";
    self.modelClass     = @"LayoutCellExploreModel";
    self.headerBlock    = nil;
    self.rightButtonHidden = NO;

}

- (void) sendRequestToServer
{
    ((ExplorerTableView *)[self tableView]).adapterBase = self;
    [(ExplorerTableView *)[self tableView] doSendRequest:YES];
}

- (NSString *) refreshPV
{
    return TD_EVENT_EXPLORE_REFRESH_PV;
}

@end
