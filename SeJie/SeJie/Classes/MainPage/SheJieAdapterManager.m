//
//  SheJieAdapterManager.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "SheJieAdapterManager.h"


@implementation SheJieAdapterManager
@synthesize adapterNormal    = _adapterNormal;
@synthesize adapterExplorOne = _adapterExplorOne;
@synthesize adapterExplorTwo = _adapterExplorTwo;
@synthesize adapterSearch    = _adapterSearch;
@synthesize adapterAccount   = _adapterAccount;
@synthesize adapterUserAccount= _adapterUserAccount;
@synthesize adapterUserCenter = _adapterUserCenter;

- (id) initWithSuperView:(UIView *) superView titleView:(UIImageLabel *) titleView
{
    self = [super initWithSuperView:superView titleView:titleView];
    if (self) {
        oldType          = eSheJieNormal;
        self.currentType = eSheJieNormal;
        //
        [[DataTracker sharedInstance] beginTrackPage:[self adapterNormal].pageViewId];
    }
    return self;
}

- (id) setNetTableView:(UITableView *) tableView
{
    [[self adapterNormal] setTableView:tableView];
    [[self adapterExplorTwo] setTableView:tableView];
    [[self adapterSearch] setTableView:tableView];
    [[self adapterAccount] setTableView:tableView];
    [[self adapterUserAccount] setTableView:tableView];
    return self;
}

- (id) setNormalTableView:(UITableView *) tableView
{
    [[self adapterExplorOne] setTableView:tableView];
    return self;
}

- (SheJieAdapterNormal *) adapterNormal
{
    if (!_adapterNormal) {
        _adapterNormal = [[SheJieAdapterNormal alloc] init];
    }
    return _adapterNormal;
}

- (SheJieAdapterExplorer *) adapterExplorOne
{
    if (!_adapterExplorOne) {
        _adapterExplorOne = [[SheJieAdapterExplorer alloc] init];
    }
    return _adapterExplorOne;
}

- (SheJieAdapterExplorerTwo *) adapterExplorTwo
{
    if (!_adapterExplorTwo) {
        _adapterExplorTwo = [[SheJieAdapterExplorerTwo alloc] init];
    }
    return _adapterExplorTwo;
}

- (SheJieAdapterSearch *) adapterSearch
{
    if (!_adapterSearch) {
        _adapterSearch = [[SheJieAdapterSearch alloc] init];
    }
    return _adapterSearch; 
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

- (ShejieAdapterUserCenter *) adapterUserCenter
{
    if (!_adapterUserCenter) {
        _adapterUserCenter = [[ShejieAdapterUserCenter alloc] init];
    }
    return _adapterUserCenter;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_adapterNormal);
    TT_RELEASE_SAFELY(_adapterExplorOne);
    TT_RELEASE_SAFELY(_adapterExplorTwo);
    TT_RELEASE_SAFELY(_adapterSearch);
    TT_RELEASE_SAFELY(_adapterAccount);
    TT_RELEASE_SAFELY(_adapterUserAccount);
    TT_RELEASE_SAFELY(_adapterUserCenter);
    [super dealloc];
}

- (BOOL) isAdapterNormal
{
    return self.currentType == eSheJieNormal;
}

- (SheJieAdapterBase *) adapterAt:(NSUInteger) type
{
    switch (type) {
        case eSheJieExplorFirst:
            return [self adapterExplorOne];
        case eSheJieExplorSecond:
            return [self adapterExplorTwo];
        case eSheJieSearch:
            return [self adapterSearch];
        case eSheJieCustomAccount:
            return [self adapterAccount];
        case eSheJieOtherAccount:
            return [self adapterUserAccount];
        case eSheJieUserCenter:
            return [self adapterUserCenter];
        default:
            return [self adapterNormal];
    }
}

- (NSString *) getKeyword
{
    if (eSheJieSearch == [self currentType]) {
        return [self adapterSearch].keyWord;
    }
    return [super getKeyword];
}

- (id) changeTypeTo:(int)type
{
    [[super changeTypeTo:type] switchContent];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSeJieTypeChangedNotification object:[NSNumber numberWithInteger:self.currentType]];
    return [self currentAdapter];
}

- (void) switchContent
{
    [[DataTracker sharedInstance] beginTrackPage:[self pageViewIdAt:self.currentType]];
    
    if (oldType == eSheJieExplorSecond && self.currentType != eSheJieExplorSecond) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kExplorerTwoReloadNotification object:nil];
    }
    
    if (oldType != self.currentType) {
        
        [[self adapterAt:oldType] removeTopButton];
        
        [[self adapterAt:oldType] actionAfterLeave];
        [[self adapterAt:self.currentType] actionBeforeCome];
        
        SheJieAdapterBase *oldAdapter = [self adapterAt:oldType];
        SheJieAdapterBase *newAdapter = [self adapterAt:self.currentType];
        
        NSUInteger oldIndex = [[_superView subviews] indexOfObject:[oldAdapter contentView]];
        NSUInteger newIndex = [[_superView subviews] indexOfObject:[newAdapter contentView]];
                
        if (oldIndex == newIndex)
        {
            [self exchangeTitle:newAdapter.title showImage:[newAdapter showArrow]];
            [newAdapter sendRequestToServer];
            return;
        }

        [newAdapter emptyContents];
        [_superView exchangeSubviewAtIndex:oldIndex withSubviewAtIndex:newIndex];

        [self exchangeTitle:newAdapter.title showImage:[newAdapter showArrow]];
        
        [UIView animateWithDuration:AnimateTime.NORMAL
                         animations:^
         {
             [oldAdapter contentView].alpha = 0.0f;
             [newAdapter contentView].alpha = 1.0f;
        }
                         completion:^(BOOL finished)
        {
            [newAdapter sendRequestToServer];
        }];
    }
    else
    {
        [[self currentAdapter] actionNoLeave];
        [_titleView setText:[self currentAdapter].title show:[[self currentAdapter] showArrow]];
    }
}

- (NSString *) pageViewIdAt:(NSUInteger) type
{
    switch (type) {
        case eSheJieNormal:
        case eSheJieExplorFirst:
        case eSheJieExplorSecond:
        case eSheJieSearch:
        case eSheJieUserCenter:
            return [[self adapterAt:type] pageViewId];
        default:
            return nil;
    }
}

@end
