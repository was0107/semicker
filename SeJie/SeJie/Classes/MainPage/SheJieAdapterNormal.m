//
//  SheJieAdapterNormal.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterNormal.h"
#import "MainTableView.h"
#import "SejieUpdateControl.h"

@implementation SheJieAdapterNormal

@synthesize isNeedRefresh = _isNeedRefresh;
@synthesize contentArray = _contentArray;
@synthesize response     = _response;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_contentArray);
    TT_RELEASE_SAFELY(_response);
    [super dealloc];
}

- (void) setContentData
{
    [super setContentData];
    
    self.pageViewId     = TD_PAGE_SEJIE_INDEX;
    self.keyWord        = kTitleSejieString;
    self.title          = kTitleSejieString;
    self.method         = @"explore/yumao/";
    self.responseClass  = @"ListSeiJieResponseBase";
    self.modelClass     = @"LayoutCellShejieModel";
    self.headerBlock    = nil;
    self.request        = [[[ListSheJieNormalRequest alloc] init] autorelease];
    
    self.isNeedRefresh  = YES;
}

- (void) emptyContents
{
    if (!_isNeedRefresh) {
        return;
    }

    [((MainTableView *)[self tableView]) emptyData];
}

- (void) sendRequestToServer
{
    ((MainTableView *)[self tableView]).adapterBase = self;
    
    if (!_isNeedRefresh && _response.count > 0) {
        [self reloadTableViewData];
        return;
    }
    
    NSInteger count = [[SejieUpdateControl sharedInstance] updateCount];
    if (count > 10) { // && count < 50
        [self reloadTableViewData];
        [(MainTableView *)[self tableView] prepareToRefresh:^{
            [(MainTableView *)[self tableView] doNormalUpdateRequest];
        }];
    }
    else {
        self.request.pageno = 0;
        [(MainTableView *)[self tableView] doFirstRequest];
    }
}

- (void) saveTableContent
{
    DEBUGLOG(@">>>>>>saveTableContent");
    _response = [((MainTableView *)[self tableView]).response retain];
}

- (void) reloadTableViewData
{
    [((MainTableView *)[self tableView]) hideEmtpyView];
    [((MainTableView *)[self tableView]) setResponse: self.response];
}

- (void) doUpdateRequest
{
    ((MainTableView *)[self tableView]).adapterBase = self;
    
    [(MainTableView *)[self tableView] prepareToRefresh:^{
        [(MainTableView *)[self tableView] doNormalUpdateRequest];
    }];
}

- (NSString *) refreshPV
{
    return TD_EVENT_INDEX_REFRESH_PV;
}

- (NSString *) imagePV
{
    return TD_EVENT_INDEX_IMAGE_PV;
}

- (NSString *) imageSavePV
{
    return TD_EVENT_INDEX_IMAGE_SAVE_PV;
}

- (NSString *) imageLikePV
{
    return TD_EVENT_INDEX_IMAGE_LIKE_PV;
}

- (NSString *) imageSharePV
{
    return TD_EVENT_INDEX_IMAGE_SHARE_PV;
}

- (NSString *) imageUserPV
{
    return TD_EVENT_INDEX_IMAGE_USER_PV;
}

- (NSString *) imageGoodsPV
{
    return TD_EVENT_INDEX_IMAGE_GOODS_PV;
}

- (NSString *) imageGoodsMC
{
    return TD_EVENT_INDEX_IMAGE_GOODS_MC;
}

- (NSString *) imageGoodsCPS
{
    return TD_EVENT_INDEX_IMAGE_GOODS_CPS;
}

- (void) actionAfterLeave
{
    [self saveTableContent];
}

@end
