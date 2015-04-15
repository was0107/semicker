//
//  SheJieAdapterManagerEx.m
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SheJieAdapterManagerEx.h"

@implementation SheJieAdapterManagerEx

@synthesize adapterAccount   = _adapterAccount;
@synthesize adapterUserAccount= _adapterUserAccount;

- (id) initWithSuperView:(UIView *) superView titleView:(UIImageLabel *) titleView type:(int) type
{
    self = [super initWithSuperView:superView titleView:titleView];
    if (self) {
        self.currentType = type;
    }
    return self;
}

- (id) setNetTableView:(UITableView *) tableView
{
    [[self currentAdapter] setTableView:tableView];
    return self;
}

- (SheJieAdapterAccount *) adapterAccount
{
    if (!_adapterAccount) {
        _adapterAccount = [[SheJieAdapterAccount alloc] init];
    }
    return _adapterAccount;
}

- (SheJieAdapterOtherAccount *) adapterUserAccount
{
    if (!_adapterUserAccount) {
        _adapterUserAccount = [[SheJieAdapterOtherAccount alloc] init];
    }
    return _adapterUserAccount;
}

- (SheJieAdapterBase *) adapterAt:(NSUInteger) type
{
    switch (type) {
        case eSheJieCustomAccount:
            return [self adapterAccount];
        default:
            return [self adapterUserAccount];
    }
}

- (id) changeSearchType:(NSString *) searchType
{
    ListAccountRequest *request = (ListAccountRequest *)[[self currentAdapter] request];
    request.searchType = searchType;
    return self;
}

- (id) changeToShare
{
    return [self changeSearchType:@"SHARE"];
}

- (id) changeToLike
{
    return [self changeSearchType:@"LIKE"];
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_adapterAccount);
    TT_RELEASE_SAFELY(_adapterUserAccount);
    [super dealloc];
}

@end
