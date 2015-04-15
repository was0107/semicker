//
//  FilterView.h
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTopView.h"
#import "FilterBottomView.h"

@interface FilterView : WASContainer
@property (nonatomic, retain) FilterTopView *topView;
@property (nonatomic, retain) UITableView   *tableView;
@property (nonatomic, retain) FilterBottomView *bottomView;
@property (nonatomic, copy)   intIdBlock     block;

- (void) showUpdateTipView:(BOOL)show;

@end
