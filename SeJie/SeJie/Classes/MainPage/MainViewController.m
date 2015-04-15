//
//  MainViewController.m
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewController_Private.h"
#import "UIView+extend.h"
#import "UIView+Shadow.h"
#import "UIColor+extend.h"
#import "NSObject+Block.h"
#import "SearchViewController.h"
#import "MainDetailViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "SejieUpdateControl.h"
#import "LabelsManager.h"
#import "VoiceRecognizeControl.h"
#import "CustomAnimation.h"
#import "UserDefaultsManager.h"
#import "B5MShareViewController.h"
#import "UserRecordItem.h"

@implementation MainViewController
@synthesize tableView           = _tableView;
@synthesize filterView          = _filterView;
@synthesize bottomView          = _bottomView;
@synthesize adapter             = _adapter;
@synthesize explorerTableView   = _explorerTableView;
@synthesize updateTipView       = _updateTipView;
@synthesize topFilterTableView  = _topFilterTableView;
@synthesize tipImageView        = _tipImageView;
@synthesize searchView          = _searchView;
@synthesize userCenterView      = _userCenterView;
@synthesize firstLevel          = _firstLevel;

- (void) reduceMemory
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_filterView);
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_adapter);
    TT_RELEASE_SAFELY(_explorerTableView);
    TT_RELEASE_SAFELY(_topFilterTableView);
    TT_RELEASE_SAFELY(_updateTipView);
    TT_RELEASE_SAFELY(_tipImageView);
    TT_RELEASE_SAFELY(_searchView);
    TT_RELEASE_SAFELY(_firstLevel);
    TT_RELEASE_SAFELY(pickerController);
    TT_RELEASE_SAFELY(_userCenterView);
    [super reduceMemory];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [[self titleLabel] setText:kTitleSejieString];
    [self.titleView addSubview:[self leftButton]];
    [self.titleView addSubview:[self rightButton]];
    [self.titleView addSubview:[self updateTipView]];
    [self.titleView addSubview:[self tipImageView]];
    [self.view addSubview:[self tableView]];
    [self.view addSubview:[self explorerTableView]];
    
    [self.view addSubview:[self userCenterView]];

    [self sendMessageToServer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotifiCation:) name:kSejieUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSuccessNotifiCation:) name:kSejieUpdateSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMoreNotification:) name:kSendRequestToLoadMoreNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareButtonNotification:) name:kButtonShareNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userShareNotification:) name:kUserShareInfoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customShareNotification:) name:kCustomShareInfoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSucceedNotification:) name:kShareSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexChangedNotifiCation:) name:kSeJieSexTypeChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToNormalNotification:) name:kLogoutToNormalNotification object:nil];
    
    //[self showUpdateTipView:YES];
    //[[SejieUpdateControl sharedInstance] startTimer];
    
    currentType = eSheJieNormal;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark actions

- (IBAction)leftButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kImageRotateNotification object:[NSNumber numberWithBool:NO]];
    if (_searchView.superview) {
        [self removeSearchView:NO];
        return;
    }
    
    if (self.topFilterTableView.superview) {
        [UIView animateWithDuration:AnimateTime.SHORT
                         animations:^
         {
             [_topFilterTableView setFrameY:-kContentBoundsHeight];
         } completion:^(BOOL finished) {
             [_topFilterTableView removeFromSuperview];
         }];
    }
    
//    tipImageAlpha = self.tipImageView.alpha;
    // 显示当前帐号
    [self.filterView.bottomView updateAccount];
    
    if ([self.adapter isAdapterNormal]) {
        [self.filterView showUpdateTipView:NO];
    }
    
    [self.filterView setFrameX:-kFilterViewWidth];
    self.bottomView.alpha = 0;
    [self.bottomView addSubview:self.filterView];
    [self.view addSubview:self.bottomView];
    
    [UIView animateWithDuration:AnimateTime.NORMAL
                     animations:^
     {
         [_filterView setFrameX:0];
         _bottomView.alpha = 1;
         _tipImageView.alpha = 0.0;
     } completion:^(BOOL finished) {
         if (![self.adapter isAdapterNormal]) {
             [self.filterView showUpdateTipView:YES];
         }
     }];
    
    // Navigation Button PV
    [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_BUTTON_PV
                                   withLabel:@""
                                    category:TD_EVENT_Category];
}

- (IBAction)rightButtonAction:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kImageRotateNotification object:[NSNumber numberWithBool:NO]];
    if (self.adapter.currentType == eSheJieUserCenter) {
        
        pickerController = [[CustomPickerViewController alloc] init];
        [pickerController setCustomImagePickerDelegate:self];
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
        return;
    }
    
    if (_searchView.superview) {
        [self removeSearchView:YES];
        return;
    }
    
    [self.rightButton setSelected:YES];
    
    if (self.topFilterTableView.superview) {
        [UIView animateWithDuration:AnimateTime.SHORT
                         animations:^
         {
             [_topFilterTableView setFrameY:-kContentBoundsHeight];
         } completion:^(BOOL finished) {
             [_topFilterTableView removeFromSuperview];
         }];
    }
    
    [self.searchView.searchField setText:@""];
    [self.searchView setFrameY:0];
    self.bottomView.alpha = 0;
    [self.bottomView addSubview:self.searchView];
    [self.view addSubview:self.bottomView];
    
    [self.view bringSubviewToFront:self.titleView];
    [self.view bringSubviewToFront:self.searchView.autoFillList];
    
    [_searchView setSearchPage:[self.adapter currentType]];
    [_searchView activateSearchField:YES];
    
    [UIView animateWithDuration:AnimateTime.NORMAL
                     animations:^
     {
         [_searchView setFrameY:64];
         _bottomView.alpha = 1;
     } completion:^(BOOL finished) {
         
     }];
    
}

- (IBAction) bottomViewAction:(id)sender
{
    
    if (_filterView.superview) {
        [self removeFilterView];
    }
    
    if (_searchView.superview) {
        [self removeSearchView:YES];
    }
}

- (void) removeFilterView
{
    [UIView animateWithDuration:AnimateTime.NORMAL
                     animations:^
     {
         [_filterView setFrameX:-kFilterViewWidth];
         _bottomView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         [_filterView removeFromSuperview];
         [_bottomView removeFromSuperview];
     }];
    
    if ((currentType != eSheJieNormal || self.updateTipView.alpha==0.0f) && [[SejieUpdateControl sharedInstance] updateCount] > 0) {
        CAKeyframeAnimation *anim = [CustomAnimation scaleKeyFrameAnimation:AnimateTime.NORMAL];
        self.tipImageView.alpha = 1.0f;
        [self.tipImageView.layer addAnimation:anim forKey:nil];
    }
    else {
        self.tipImageView.alpha = 0.0f;
    }
}

- (void) removeSearchView:(BOOL)animated
{
    [self.rightButton setSelected:NO];
    [_searchView activateSearchField:NO];
    [[VoiceRecognizeControl sharedInstance] cancel];
    
    [UIView animateWithDuration:animated ? AnimateTime.NORMAL:AnimateTime.SHORT
                     animations:^
     {
         [_searchView setFrameY:-_searchView.height];
         _bottomView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         [_searchView removeFromSuperview];
         [_bottomView removeFromSuperview];
     }];
}

- (void) titleDidTapped:(UIGestureRecognizer *)gesture
{
    if ([_adapter currentAdapter].headerBlock) {
        [_adapter currentAdapter].headerBlock();
    }
}


- (void) sendMessageToServer
{
    [self.adapter sendRequestToServer];
}

- (void) showUpdateTipView:(BOOL)show
{
    if (show) {
        [self.updateTipView showViewAnimated];
    }
    else {
        [self.updateTipView setAlpha:0];
    }
}

- (void) shareButtonNotification:(NSNotification *) notification
{
    [self rightButtonAction:nil];
}

- (void) loadMoreNotification:(NSNotification *) notification
{
    if (_tableView.loadMoreBlock) {
        _tableView.loadMoreBlock(nil);
    }
}
- (void) changeToNormalNotification:(NSNotification *) notification
{
    [self filterView].block(eSheJieNormal, nil);
}
- (void) sexChangedNotifiCation:(NSNotification *) notification
{
    //    [self.adapter sendRequestToServer];
    if (self.adapter.currentType == eSheJieNormal) {
        [self.adapter sendRequestToServer];
    }
    else {
        [[LabelsManager sharedInstance].currentItem resetState];
        [self.adapter.adapterNormal setIsNeedRefresh:YES];
        [SejieUpdateControl sharedInstance].updateCount = 100;
        [self.adapter changeTypeTo:eSheJieNormal];
        self.rightButton.hidden = [_adapter currentAdapter].rightButtonHidden;
    }
}

- (void) shareSucceedNotification:(NSNotification *) notification
{
    if ([_adapter currentAdapter] == _adapter.adapterUserCenter) {
        [_adapter.adapterUserCenter sendRequestToServer];
//        [((MainTableView *)[_adapter.adapterUserCenter tableView]) doSendRequest:YES];
    }
}


- (void) customShareNotification:(NSNotification *) notification
{
    self.filterView.block(eSheJieUserCenter,nil);
}

- (void) userShareNotification:(NSNotification *) notification
{
    if (notification.object) {
        
        _adapter.adapterUserAccount.item = notification.object;
        
        [[DataTracker sharedInstance] trackEvent:_adapter.currentAdapter.imageUserPV
                                       withLabel:_adapter.adapterUserAccount.item.username
                                        category:TD_EVENT_Category];
        
        self.filterView.block(eSheJieOtherAccount,nil);
    }
}

- (void) updateNotifiCation:(NSNotification *)notification
{
    DEBUGLOG(@"-- updateNotifiCation == %@", notification.object);
    
    if (!notification.object) {
        [self showUpdateTipView:NO];
        self.tipImageView.alpha = 0.0f;
        tipImageAlpha = 0.0f;
        return;
    }
    
    tipImageAlpha = 1.0f;
    self.tipImageView.alpha = 0.0f;
    
    if ([self.adapter isAdapterNormal]) {
        [self.updateTipView setUpdateText:notification.object];
        [self showUpdateTipView:YES];
    }
    else if (!_bottomView.superview) {
        CAKeyframeAnimation *anim = [CustomAnimation scaleKeyFrameAnimation:AnimateTime.NORMAL];
        self.tipImageView.alpha = 1.0f;
        [self.tipImageView.layer addAnimation:anim forKey:nil];
    }
}

- (void) updateSuccessNotifiCation:(NSNotification *)notification
{
    DEBUGLOG(@"-- updateNotifiCation Success == %@", notification.object);
    
    __block MainViewController *blockSelf = self;
    [self performBlock:^{
        [blockSelf showUpdateSuccess:notification.object];
    } afterDelay:.3f];
}

- (void) showUpdateSuccess:(NSString *)count
{
    DEBUGLOG(@"-- showUpdateSuccess");
    //
    UILabel * updateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 30)] autorelease];
    updateLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"update_tips_bg"]];
    updateLabel.textAlignment = NSTextAlignmentCenter;
    updateLabel.alpha = 0.0f;
    updateLabel.text = count ? [NSString stringWithFormat:@"%@ 张新图片", count] : @"暂无更新图片";
    updateLabel.textColor = kOrangeColor;
    updateLabel.font = TNRFontSIZEBIG(kFontSize14);
    [self.view addSubview:updateLabel];
    [self.view bringSubviewToFront:self.titleView];
    
    [UIView animateWithDuration:AnimateTime.NORMAL
                          delay:.1f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [updateLabel setFrameY:44];
         updateLabel.alpha = 0.8f;
     }
                     completion:^(BOOL finished)
     {
         
         [UIView animateWithDuration:AnimateTime.NORMAL
                               delay:3.0f
                             options:UIViewAnimationOptionCurveLinear
                          animations:^
          {
              [updateLabel setFrameY:0];
              updateLabel.alpha = 0.0f;
              
          }
                          completion:^(BOOL finished)
          {
              [updateLabel removeFromSuperview];
          }];
         
     }];
    
}

- (void) changeToSearchView:(NSString *)keyword
{
    SearchViewController *controller = [[[SearchViewController alloc] init] autorelease];
    controller.keyword = keyword;
    controller.completeBlock = ^ (id content) {
        [[SejieSearchResponseManager instanceManger] resetData];
        self.adapter.adapterSearch.title = kTitleSearchEx(content);
        [self showUpdateTipView:NO];
        [self.adapter.adapterSearch setRequestData:content category:@""];
        [self.adapter changeTypeTo:eSheJieSearch];
        currentType = eSheJieSearch;
    };
    [self.navigationController pushViewController:controller animated:YES];
}

// 直接搜索
- (void) doSearch:(NSString *) keyword
{
    [[SejieSearchResponseManager instanceManger] resetData];
    self.adapter.adapterSearch.keyWord = keyword;
    [self showUpdateTipView:NO];
    [self.adapter.adapterSearch setRequestData:keyword category:@""];
    [self.adapter changeTypeTo:eSheJieSearch];
    currentType = eSheJieSearch;
}

#pragma mark --
#pragma mark setter and getter

- (UIButton *) bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _bottomView.frame = self.view.bounds;
        _bottomView.backgroundColor = kClearColor;
        _bottomView.alpha = 0.0f;
        
        UIView *grayView = [[[UIView alloc] initWithFrame:kContentWithBarFrame] autorelease];
        grayView.backgroundColor = kBlackColor;
        grayView.alpha = .4f;
        grayView.userInteractionEnabled = NO;
        [_bottomView addSubview:grayView];
        [_bottomView addTarget:self action:@selector(bottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (SearchBarView *) searchView
{
    if (!_searchView) {
        _searchView = [[SearchBarView alloc] initWithFrame:CGRectMake(0, 60, 320, 44)];
        //_searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kSearchBarPopBackGround]];
        [_searchView setFrameY:44];
        [_searchView addBottomShadow];
        
        [self.searchView initAutoFillList:self.view history:NO
                                backColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kSearchBarPopBackGround]]];    //[UIColor getColor:@"ffffff" alpha:0.9f]
        
        __block MainViewController *blockSelf = self;
        _searchView.completeBlock = ^ (id content)
        {
            [blockSelf removeSearchView:YES];
            [blockSelf doSearch:content];
        };
    }
    return _searchView;
}

- (UIView *) updateTipView
{
    if (!_updateTipView) {
        _updateTipView = [[UpdateTipView alloc] initWithFrame:kHeaderUpdateFrame];
        _updateTipView.alpha = 0.0f;
    }
    return _updateTipView;
}

- (UIImageView *)tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[[UIImageView alloc] initWithFrame:kHeaderDotImageFrame] autorelease];
        _tipImageView.image = [UIImage imageNamed:@"update_left_top"];
        _tipImageView.backgroundColor = kClearColor;
        _tipImageView.alpha = 0.0f;
    }
    return _tipImageView;
}

- (SheJieAdapterManager *) adapter
{
    if (!_adapter) {
        _adapter = [[SheJieAdapterManager alloc] initWithSuperView:self.view
                                                         titleView:self.titleLabel];
    }
    return _adapter;
}

- (MainTableView *) tableView
{
    if (!_tableView) {
        _tableView = [[MainTableView alloc] initWithFrame:kContentWithBarFrame
                                                    style:UITableViewStylePlain
                                                     type:(eTypeHeader | eTypeFooter)
                                                 delegate:nil];
        [self.adapter setNetTableView:self.tableView];
        [[[[[self addItemsBlock] addFilterNormalBlock] addFilterTwoHeaderBlock] addFilterTwoBlock] addSearchHeaderBlock];
    }
    
    return _tableView;
}

// 列表项的点击事件
- (id) addItemsBlock
{
//    __block MainViewController *blockSelf = self;
    idBlock itemBlock = ^(id content) {
        /*

        MainDetailViewController *detail = [[[MainDetailViewController alloc] init] autorelease];
        detail.adapter = _adapter.currentAdapter;
        detail.enableClickUser = YES;
        [blockSelf.navigationController pushViewController:detail animated:YES];
        
//        [blockSelf performBlock:^{
            detail.responseItem = content;
            detail.keyword = [_adapter getKeyword];
            detail.contents = _tableView.response.result;
//        } afterDelay:0 ];
        
        // 图片查看 PV
        [[DataTracker sharedInstance] trackEvent:_adapter.currentAdapter.imagePV
                                       withLabel:detail.responseItem.label
         category:TD_EVENT_Category];
         */
    };
    
    self.adapter.adapterNormal.cellBlock = itemBlock;
    self.adapter.adapterSearch.cellBlock = itemBlock;
    self.adapter.adapterExplorTwo.cellBlock = itemBlock;
    self.adapter.adapterAccount.cellBlock = itemBlock;
    self.adapter.adapterUserAccount.cellBlock = itemBlock;
    return self;
}

// 精彩色界头部点击事件
- (id) addFilterNormalBlock
{
    __block MainViewController *blockSelf = self;
    self.adapter.adapterNormal.headerBlock = ^
    {
        if (blockSelf.searchView.superview) {
            [blockSelf removeSearchView:NO];
            return;
        }
        
        if ([SejieUpdateControl sharedInstance].updateCount == 0)
        {
            return;
        }
        [_adapter.adapterNormal setIsNeedRefresh:YES];
        [_adapter.adapterNormal doUpdateRequest];
        //[blockSelf sendMessageToServer];
    };
    return self;
}

// 发现色界 点击事件
- (id) addFilterTwoHeaderBlock
{
    __block MainViewController *blockSelf = self;
    self.adapter.adapterExplorTwo.headerBlock = ^
    {
        if (blockSelf.searchView.superview) {
            [blockSelf removeSearchView:NO];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kImageRotateNotification
                                                            object:[NSNumber numberWithBool:blockSelf.topFilterTableView.superview ? NO : YES]];
        
        if (blockSelf.topFilterTableView.superview) {
            [UIView animateWithDuration:AnimateTime.NORMAL
                             animations:^
             {
                 [blockSelf.topFilterTableView setFrameY:-kContentBoundsHeight+20];
             }
                             completion:^(BOOL finished)
             {
                 [_topFilterTableView removeFromSuperview];
             }];
        } else {
            _topFilterTableView.block = ^(id content)
            {
                blockSelf.adapter.adapterExplorTwo.headerBlock();
                ListSheJieExplorerRequest *request = (ListSheJieExplorerRequest *) (_adapter.adapterExplorTwo).request;
                request.labelTwo = content;
                _adapter.adapterExplorTwo.title = kTitleFindEx([[content componentsSeparatedByString:kSeperateString] lastObject]);
                _adapter.adapterExplorTwo.keyWord = content;
                LabelItem *item = [LabelsManager sharedInstance].currentItem;
                if (item) {
                    _adapter.adapterExplorTwo.method = item.urlName;
                }
                [blockSelf.adapter changeTypeTo:eSheJieExplorSecond];
                currentType = eSheJieExplorSecond;
            };
            
            NSString *label = [[blockSelf.firstLevel componentsSeparatedByString:kSeperateString] objectAtIndex:0];
            //DEBUGLOG(@"-- label == %@=", label);
            // 2级标签列表
            NSMutableArray *labelList = [[LabelsManager sharedInstance] getSubLabelList:1 title:label];
            [_topFilterTableView setContentArray:labelList];
            [_topFilterTableView setCellContents:nil];
            [_topFilterTableView reloadData];
            
            [blockSelf.view addSubview:_topFilterTableView];
            [blockSelf.view sendSubviewToBack:_topFilterTableView];
            [blockSelf.view sendSubviewToBack:_tableView];
            [UIView animateWithDuration:AnimateTime.NORMAL
                             animations:^
             {
                 [blockSelf.topFilterTableView setFrameY:kNavigationBarHeight + 20 ];
             }];
        }
    };
    
    return self;
}

- (id) addSearchHeaderBlock
{
    __block MainViewController *blockSelf = self;
    self.adapter.adapterSearch.headerBlock = ^
    {
        if (blockSelf.searchView.superview) {
            [blockSelf removeSearchView:NO];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kImageRotateNotification
                                                            object:[NSNumber numberWithBool:blockSelf.topFilterTableView.superview ? NO : YES]];
        
        if (blockSelf.topFilterTableView.superview) {
            [UIView animateWithDuration:AnimateTime.NORMAL
                             animations:^
             {
                 [blockSelf.topFilterTableView setFrameY:20-kContentBoundsHeight];
             }
                             completion:^(BOOL finished) {
                                 [_topFilterTableView removeFromSuperview];
                             }];
        } else {
            _topFilterTableView.block = ^(id content)
            {
                blockSelf.adapter.adapterSearch.headerBlock();
                SejieSearchRequest *request = (SejieSearchRequest *) (_adapter.adapterSearch).request;
                [_adapter.adapterSearch setRequestData:request.keyword category:content];
                [blockSelf.adapter changeTypeTo:eSheJieSearch];
                currentType = eSheJieSearch;
                [[SejieSearchResponseManager instanceManger] setCurrentItem:content];
            };
            //
            SejieSearchResponse *response = (SejieSearchResponse *) (((MainTableView *)[_adapter.adapterSearch tableView]).response);
            [[SejieSearchResponseManager instanceManger] setTheKeyword:[((SejieSearchRequest *)_adapter.adapterSearch.request) keyword]];
            [_topFilterTableView setContentArray:[[SejieSearchResponseManager instanceManger] contents]];

            if (response.tagsGroup.count > 0) {
                [[SejieSearchResponseManager instanceManger] setCellsArray:response.tagsGroup];
                [_topFilterTableView setCellContents:[[SejieSearchResponseManager instanceManger] cellsArray]];
            }
            [_topFilterTableView reloadData];
            
            [blockSelf.view addSubview:_topFilterTableView];
            [blockSelf.view sendSubviewToBack:_topFilterTableView];
            [blockSelf.view sendSubviewToBack:_tableView];
            [UIView animateWithDuration:AnimateTime.NORMAL
                             animations:^
             {
                 [blockSelf.topFilterTableView setFrameY:kNavigationBarHeight];
             }];
        }
    };
    
    return self;
}

//二级类目表格选中
- (id) addFilterTwoBlock
{
    idBlock block = ^(id content) {
        ListSheJieExplorerRequest *request =  (ListSheJieExplorerRequest *)_adapter.adapterExplorTwo.request;
        request.label = content;
        _adapter.adapterExplorTwo.title = content;
        _adapter.adapterExplorTwo.keyWord = content;
        _filterView.block(eSheJieExplorSecond,content);
        //
        [[DataTracker sharedInstance] trackEvent:TD_EVENT_EXPLORE_CLASS1_PV withLabel:content category:TD_EVENT_Category];
    };
    self.adapter.adapterExplorOne.cellBlock = block;
    return self;
}

- (ExplorerTableView *) explorerTableView
{
    if (!_explorerTableView) {
        _explorerTableView = [[ExplorerTableView alloc] initWithFrame:kContentWithBarFrame
                                                                style:UITableViewStylePlain
                                                                 type:eTypeNone
                                                             delegate:nil];
        _explorerTableView.alpha = 0;
        [self.adapter setNormalTableView:_explorerTableView];
    }
    return _explorerTableView;
}

- (TopFilterTableView *) topFilterTableView
{
    if (!_topFilterTableView) {
        _topFilterTableView = [[TopFilterTableView alloc] initWithFrame:kContentWithBarFrame
                                                                  style:UITableViewStylePlain
                                                                   type:eTypeNone
                                                               delegate:nil];
        
        [_topFilterTableView setFrameY:-kContentBoundsHeight+20];
    }
    return _topFilterTableView;
}

- (FilterView *) filterView
{
    if (!_filterView) {
        CGRect rect = kContentWithBarFrame;
        rect.size.width = kFilterViewWidth;
        _filterView = [[FilterView alloc] initWithFrame:rect];
        
        __block MainViewController *blockSelf = self;
        _filterView.block = ^(int type, id content) {
            
            currentType = type;
            [blockSelf bottomViewAction:nil];
            
            if (eSheJieSearch == type) { // 搜色界 点击事件
                [blockSelf changeToSearchView:@""];
                return;
            }
            else if (eSheJieVoice == type) { // 语音按钮 点击事件
                [[VoiceRecognizeControl sharedInstance] startRecognize:blockSelf.view
                                                         completeBlock:^(id text)
                 {
                     DEBUGLOG(@"-- voice text == %@", text);
                     //[blockSelf changeToSearchView:text];
                     // Search Voice PV
                     [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_SEARCH_VOICE_PV
                                                    withLabel:text
                                                     category:TD_EVENT_Category];
                     //直接搜索
                     [blockSelf doSearch:text];
                     
                 } cancelBlock:^{
                     
                 }];
                return;
            }
            else if (eSheJieAbout == type) { // 关于按钮 点击事件
                AboutViewController *about = [[[AboutViewController alloc] init] autorelease];
                [self.navigationController pushViewController:about animated:YES];
                return;
            }
            else if (eSheJieUserCenter == type) { // 登录 / 用户中心
                
                NSString *userID = [UserDefaultsManager userId];
                if (!userID || userID.length == 0) {
                    LoginViewController *loginController = [[[LoginViewController alloc] init] autorelease];
                    loginController.block = ^ (id content) {
                        [blockSelf.adapter changeTypeTo:eSheJieUserCenter];
                        [blockSelf.rightButton setNormalImage:kMainCameraIconImage hilighted:kMainCameraIconHlImage selectedImage:kMainCameraIconHlImage];
                    };
                    [blockSelf.navigationController pushViewController:loginController animated:YES];
                    return;
                }
                // 个人中心 PV
                [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_USERCENTER_PV
                                               withLabel:userID
                                                category:TD_EVENT_Category];
                //return;
            }
            /*else if (eSheJieCustomAccount == type) { // 登录 / 用户中心
                
                NSString *userID = [UserDefaultsManager userId];
                if (!userID || userID.length == 0) {
                    LoginViewController *loginController = [[[LoginViewController alloc] init] autorelease];
                    loginController.block = ^ (id content) {
                        [blockSelf.adapter changeTypeTo:eSheJieCustomAccount];
                        [self.rightButton setNormalImage:kMainCameraIconImage hilighted:kMainCameraIconHlImage selectedImage:kMainCameraIconHlImage];
                    };
                    [self.navigationController pushViewController:loginController animated:YES];
                    return;
                }
                // 个人中心 PV
                [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_USERCENTER_PV
                                               withLabel:userID
                                                category:TD_EVENT_Category];
            }*/
            else if (eSheJieExplorSecond == type) {
                _adapter.adapterExplorTwo.keyWord = content;
                blockSelf.firstLevel = content;
                _adapter.adapterExplorTwo.title = kTitleFindEx(content);
                ListSheJieExplorerRequest *request = (ListSheJieExplorerRequest *) (_adapter.adapterExplorTwo).request;
                LabelItem *item = [LabelsManager sharedInstance].currentItem;
                if (item) {
                    _adapter.adapterExplorTwo.method = item.urlName;
                }
                request.label = content;
            }
            else if (eSheJieNormal == type) {
                _tipImageView.alpha = 0.0f;
                [_adapter.adapterNormal setIsNeedRefresh:([[SejieUpdateControl sharedInstance] updateCount] > 0) ? YES:NO];
                // 精彩色界查看 PV
                [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_INDEX_PV
                                               withLabel:@""
                                                category:TD_EVENT_Category];
            }
            else if (eSheJieExplorFirst == type) {
                // 发现色界查看 PV
                [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_EXPLORE_PV
                                               withLabel:@""
                                                category:TD_EVENT_Category];
            }
            [[LabelsManager sharedInstance].currentItem resetState];
            [blockSelf.adapter changeTypeTo:type];
            blockSelf.rightButton.hidden = [_adapter currentAdapter].rightButtonHidden;
            // 只有精彩色界 显示更新数
            if (type == eSheJieNormal && [[SejieUpdateControl sharedInstance] updateCount] > 0) {
                [blockSelf.updateTipView setUpdateText:[[SejieUpdateControl sharedInstance] getCountString]];
                [blockSelf showUpdateTipView:YES];
            }
            else {
                [blockSelf showUpdateTipView:NO];
            }
            // 切换按钮
            if (eSheJieUserCenter == type) {
                [blockSelf.rightButton setNormalImage:kMainCameraIconImage hilighted:kMainCameraIconHlImage selectedImage:kMainCameraIconHlImage];
            }
            else {
                [blockSelf.rightButton setNormalImage:kMainSearchIconImage hilighted:kMainSearchIconHlImage selectedImage:kMainSearchIconSelImage];
            }
        } ;
    }
    return _filterView;
}

- (UserCenterView *) userCenterView
{
    if (!_userCenterView) {
        _userCenterView = [[UserCenterView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height-44)];
        _userCenterView.controller = self;
        _userCenterView.alpha = 0.0f;
        [self.adapter.adapterUserCenter setUserCenterView:_userCenterView];
        
//        __block MainViewController *blockSelf = self;
        _userCenterView.itemBlock = ^ (id content) {
            
            UserRecordItem *recored = (UserRecordItem *) content;
            ListSeiJieItem *seijieItem = [recored seiJieItem];
            
            if (!seijieItem.docid || seijieItem.docid.length == 0) {
                return;
            }
            /*

            MainDetailViewController *detail = [[[MainDetailViewController alloc] init] autorelease];
            detail.adapter = _adapter.currentAdapter;
            detail.enableClickUser = NO;
            [blockSelf.navigationController pushViewController:detail animated:YES];
            detail.responseItem = seijieItem;
            detail.keyword = [_adapter getKeyword];
            detail.contents = [NSMutableArray arrayWithObject:seijieItem];
            */
            // 图片查看 PV
            [[DataTracker sharedInstance] trackEvent:TD_EVENT_USER_TIME_PV
                                           withLabel:seijieItem.label
                                            category:TD_EVENT_Category];
        };
    }
    return _userCenterView;
}


- (BOOL) isUserCenterView
{
    return _adapter.currentType == eSheJieUserCenter;
}

#pragma mark ==
#pragma mark == UIImagePickerControllerDelegate

- (void)customImagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    DEBUGLOG(@"didFinishPickingImage image = %@",image);
    [picker setNavigationBarHidden:YES];
    B5MShareViewController *share = [[[B5MShareViewController alloc] init] autorelease];
    [picker pushViewController:share animated:YES];
    [share performBlock:^{ [share setShareImage:image]; } afterDelay:0];
}

- (void) rebackFromPhoto:(UIImagePickerController *)picker
{
    [self.navigationController presentViewController:pickerController animated:YES completion:nil];
}

@end
