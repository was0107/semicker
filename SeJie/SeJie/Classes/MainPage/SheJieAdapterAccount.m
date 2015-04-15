//
//  SheJieAdapterAccount.m
// sejieios
//
//  Created by allen.wang on 1/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SheJieAdapterAccount.h"
#import "MainTableView.h"

@implementation SheJieAdapterAccount

- (void) setContentData
{
    [super setContentData];
    
    self.pageViewId     = TD_PAGE_USERCENTER_SHARE;
    self.title          = kTitleMyShareString;
//    self.method         = [URLMethod picsearch];
    self.responseClass  = @"ListAccountResponseBase";
    self.modelClass     = @"LayoutCellShejieModel";
    self.headerBlock    = nil;
    self.request        = [[[ListMyShareRequest alloc] init] autorelease];
    self.rightButtonHidden = NO;
    self.tipType           = eTipTypeCustom;

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

- (NSString *) imagePV
{
    return TD_EVENT_USER_IMAGE_PV;
}

- (NSString *) imageSavePV
{
    return TD_EVENT_USER_IMAGE_SAVE_PV;
}

- (NSString *) imageLikePV
{
    return TD_EVENT_USER_IMAGE_LIKE_PV;
}

- (NSString *) imageSharePV
{
    return TD_EVENT_USER_IMAGE_SHARE_PV;
}

- (NSString *) imageGoodsPV
{
    return TD_EVENT_USER_IMAGE_GOODS_PV;
}

- (NSString *) imageGoodsMC
{
    return TD_EVENT_USER_IMAGE_GOODS_MC;
}

- (NSString *) imageGoodsCPS
{
    return TD_EVENT_USER_IMAGE_GOODS_CPS;
}

@end
