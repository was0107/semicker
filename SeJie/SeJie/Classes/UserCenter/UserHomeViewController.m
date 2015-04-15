//
//  UserHomeViewController.m
// sejieios
//
//  Created by Jarry on 13-1-22.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserHomeViewController.h"
#import "UIView+extend.h"
#import "UserDefaultsManager.h"
#import "MainDetailViewController.h"

@interface UserHomeViewController ()

@end

@implementation UserHomeViewController

@synthesize userCenterView = _userCenterView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_USERCENTER;
    
    [[self titleLabel] setText:kTitleMySejieString];
    [self.titleView addSubview:self.leftButton];
    
    [self.view addSubview:self.userCenterView];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_userCenterView);
    [super reduceMemory];
}

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    return leftButton;
}

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) updateWithItem:(ListSeiJieItem *)item
{
    self.userCenterView.content = item;
    self.userCenterView.isFromOtherUser = YES;
    [self.userCenterView updateAccount:item.userid userName:item.username userType:item.userType];
    if (![item.userid isEqualToString:[UserDefaultsManager userId]]) {
        [self.titleLabel setText:kTitleSeJieString(item.username) show:NO];
    }
}

- (UserCenterOthers *) userCenterView
{
    if (!_userCenterView) {
        _userCenterView = [[UserCenterOthers alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height-44)];
        _userCenterView.controller = self;
        _userCenterView.settingButton.hidden = YES;
        
        [self addItemsBlock];
    }
    return _userCenterView;
}

// 列表项的点击事件
- (id) addItemsBlock
{
    __block UserHomeViewController *blockSelf = self;
    idBlock itemBlock = ^(id content) {
        /*
        MainDetailViewController *detail = [[[MainDetailViewController alloc] init] autorelease];
        //detail.adapter = _adapter.currentAdapter;
        [blockSelf.navigationController pushViewController:detail animated:YES];
        detail.responseItem = content;
        //detail.keyword = [_adapter getKeyword];
        detail.contents = _userCenterView.photoResponse.result;
        detail.enableClickUser = NO;
        // 图片查看 PV
        //        [[DataTracker sharedInstance] trackEvent:_adapter.currentAdapter.imagePV
        //                                       withLabel:detail.responseItem.label
        //                                        category:TD_EVENT_Category];
         */
    };
    self.userCenterView.itemBlock = itemBlock;
    //[self.adapter currentAdapter].cellBlock = itemBlock;
    return self;
}

@end
