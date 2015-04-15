//
//  CustomShareViewController_Private.h
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "CustomShareViewController.h"
#import "MainTableView.h"
#import "SheJieAdapterManagerEx.h"
#import "CustomPickerViewController.h"
#import "B5MShareViewController.h"

@interface CustomShareViewController ()<CustomPickerrDelegate>
{
    int _currentType;
    CustomPickerViewController *pickerController;
}
@property (nonatomic, retain) MainTableView             *tableView;
@property (nonatomic, retain) SheJieAdapterManagerEx    *adapter;
@property (nonatomic, copy)   NSString                  *name;


@end
