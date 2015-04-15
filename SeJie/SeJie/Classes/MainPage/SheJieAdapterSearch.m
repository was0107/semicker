//
//  SheJieAdapterSearch.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterSearch.h"
#import "MainTableView.h"
#import "SejieSearchRequest.h"

@implementation SheJieAdapterSearch

@synthesize response    = _response;

- (void) setContentData
{
    [super setContentData];
    
    self.pageViewId     = TD_PAGE_SEJIE_SEARCH;
    self.title          = kTitleSearchString;
    self.method         = @"search/";
    self.responseClass  = @"SejieSearchResponse";
    self.modelClass     = @"LayoutCellShejieModel";
    self.headerBlock    = nil;
    self.request        = [[[SejieSearchRequest alloc] init] autorelease];
    self.showArrow      = YES;
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

- (void) setRequestData:(NSString *)keyword category:(NSString *)category
{
    self.title = kTitleSearchEx(keyword);
    [((SejieSearchRequest*)self.request) setKeyword:keyword];
    
    NSMutableArray *array = [NSMutableArray array];
    if (category && category.length > 0) {
        [array addObject:category];
        self.title = kTitleSearchEx(category);
    }
    [((SejieSearchRequest*)self.request) setCategory:array];
}

- (NSString *) refreshPV
{
    return TD_EVENT_SEARCH_REFRESH_PV;
}

- (NSString *) imagePV
{
    return TD_EVENT_SEARCH_IMAGE_PV;
}

- (NSString *) imageSavePV
{
    return TD_EVENT_SEARCH_IMAGE_SAVE_PV;
}

- (NSString *) imageLikePV
{
    return TD_EVENT_SEARCH_IMAGE_LIKE_PV;
}

- (NSString *) imageSharePV
{
    return TD_EVENT_SEARCH_IMAGE_SHARE_PV;
}

- (NSString *) imageUserPV
{
    return TD_EVENT_SEARCH_IMAGE_USER_PV;
}

- (NSString *) imageGoodsPV
{
    return TD_EVENT_SEARCH_IMAGE_GOODS_PV;
}

- (NSString *) imageGoodsMC
{
    return TD_EVENT_SEARCH_IMAGE_GOODS_MC;
}

- (NSString *) imageGoodsCPS
{
    return TD_EVENT_SEARCH_IMAGE_GOODS_CPS;
}

- (void) actionNoLeave
{
    [self emptyContents];
    [self sendRequestToServer];
}
@end
