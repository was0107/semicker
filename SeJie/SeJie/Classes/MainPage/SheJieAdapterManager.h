//
//  SheJieAdapterManager.h
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SheJieAdapterManagerBase.h"
#import "SheJieAdapterNormal.h"
#import "SheJieAdapterExplorer.h"
#import "SheJieAdapterExplorerTwo.h"
#import "SheJieAdapterSearch.h"
#import "SheJieAdapterAccount.h"
#import "SheJieAdapterOtherAccount.h"
#import "ShejieAdapterUserCenter.h"

@interface SheJieAdapterManager : SheJieAdapterManagerBase
@property (nonatomic, retain) SheJieAdapterNormal       *adapterNormal;
@property (nonatomic, retain) SheJieAdapterExplorer     *adapterExplorOne;
@property (nonatomic, retain) SheJieAdapterExplorerTwo  *adapterExplorTwo;
@property (nonatomic, retain) SheJieAdapterSearch       *adapterSearch;
@property (nonatomic, retain) SheJieAdapterAccount      *adapterAccount;
@property (nonatomic, retain) SheJieAdapterOtherAccount *adapterUserAccount;
@property (nonatomic, retain) ShejieAdapterUserCenter   *adapterUserCenter;

- (id) setNormalTableView:(UITableView *) tableView;

- (BOOL) isAdapterNormal;

@end
