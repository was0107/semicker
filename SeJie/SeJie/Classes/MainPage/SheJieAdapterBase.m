//
//  SheJieAdapterBase.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterBase.h"
#import "MainTableView.h"

@implementation SheJieAdapterBase
@synthesize title           = _title;
@synthesize keyWord         = _keyWord;
@synthesize responseClass   = _responseClass;
@synthesize modelClass      = _modelClass;
@synthesize method          = _method;
@synthesize headerBlock     = _headerBlock;
@synthesize itemBlock       = _itemBlock;
@synthesize cellBlock       = _cellBlock;
@synthesize request         = _request;
@synthesize showArrow       = _showArrow;
@synthesize tipType         = _tipType;
@synthesize pageViewId      = _pageViewId;
@synthesize rightButtonHidden = _rightButtonHidden;

@synthesize refreshPV       = _refreshPV;
@synthesize imagePV         = _imagePV;
@synthesize imageSavePV     = _imageSavePV;
@synthesize imageLikePV     = _imageLikePV;
@synthesize imageSharePV    = _imageSharePV;
@synthesize imageUserPV     = _imageUserPV;
@synthesize imageGoodsPV    = _imageGoodsPV;
@synthesize imageGoodsMC    = _imageGoodsMC;
@synthesize imageGoodsCPS   = _imageGoodsCPS;

- (id) init
{
    self = [super init];
    if (self) {
        [self setContentData];
    }
    return self;
}

- (void) setContentData
{
    self.title              = kEmptyString;
    self.keyWord            = kEmptyString;
    self.rightButtonHidden  = NO;
    self.method             = @"explore/yumao/";
    self.tipType            = eTipTypeNormal;
    self.showArrow          = NO;
}

- (UITableView *)tableView
{
    return _tableView;
}

- (void) setTableView:(UITableView *) tableView
{
    _tableView = tableView;
}

- (void) emptyContents
{
    
}

- (void) sendRequestToServer
{
    
}

- (void) actionBeforeCome
{
    
}

- (void) actionNoLeave
{
    
}

- (void) actionAfterLeave
{
    
}

- (UIView *) contentView
{
    return self.tableView;
}

- (void) removeTopButton
{
    [((MainTableView *)self.tableView).toTopButton setHidden:YES];
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_method);
    TT_RELEASE_SAFELY(_modelClass);
    TT_RELEASE_SAFELY(_responseClass);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_itemBlock);
    TT_RELEASE_SAFELY(_cellBlock);
    TT_RELEASE_SAFELY(_headerBlock);
    TT_RELEASE_SAFELY(_pageViewId);
    
    TT_RELEASE_SAFELY(_refreshPV);
    TT_RELEASE_SAFELY(_imagePV);
    TT_RELEASE_SAFELY(_imageSavePV);
    TT_RELEASE_SAFELY(_imageSharePV);
    TT_RELEASE_SAFELY(_imageLikePV);
    TT_RELEASE_SAFELY(_imageUserPV);
    TT_RELEASE_SAFELY(_imageGoodsPV);
    TT_RELEASE_SAFELY(_imageGoodsMC);
    TT_RELEASE_SAFELY(_imageGoodsCPS);
    [super dealloc];
}
@end
