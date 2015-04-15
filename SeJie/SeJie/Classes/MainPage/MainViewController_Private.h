//
//  MainViewController_Private.h
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "MainViewController.h"
#import "ListGuangRequest.h"
#import "ListGuangResponse.h"
#import "MainTableView.h"
#import "SheJieAdapterManager.h"
#import "FilterView.h"
#import "ExplorerTableView.h"
#import "UpdateTipView.h"
#import "TopFilterTableView.h"
#import "MainDetailViewController.h"
#import "SearchBarView.h"
#import "CustomPickerViewController.h"

@interface MainViewController () <CustomPickerrDelegate>
{
    CGFloat tipImageAlpha;
    int     currentType;
    __block CustomPickerViewController *pickerController ;

}
@property (nonatomic, retain) MainTableView             *tableView;
@property (nonatomic, retain) ExplorerTableView         *explorerTableView;
@property (nonatomic, retain) TopFilterTableView        *topFilterTableView;
@property (nonatomic, retain) FilterView                *filterView;
@property (nonatomic, retain) UIButton                  *bottomView;
@property (nonatomic, retain) SheJieAdapterManager      *adapter;
@property (nonatomic, retain) UpdateTipView             *updateTipView;
@property (nonatomic, retain) UIImageView               *tipImageView;
@property (nonatomic, retain) SearchBarView             *searchView;

@property (nonatomic, copy)   NSString                  *firstLevel;

@end
