//
//  SheJieAdapterManagerEx.h
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SheJieAdapterManagerBase.h"

#import "SheJieAdapterAccount.h"
#import "SheJieAdapterOtherAccount.h"
@interface SheJieAdapterManagerEx : SheJieAdapterManagerBase
@property (nonatomic, retain) SheJieAdapterAccount      *adapterAccount;
@property (nonatomic, retain) SheJieAdapterOtherAccount *adapterUserAccount;

- (id) initWithSuperView:(UIView *) superView titleView:(UIImageLabel *) titleView type:(int) type;

- (id) changeToShare;
- (id) changeToLike;

@end
