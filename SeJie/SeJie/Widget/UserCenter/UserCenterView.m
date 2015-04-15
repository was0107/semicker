//
//  UserCenterView.m
// sejieios
//
//  Created by Jarry on 13-1-22.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCenterView.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"
#import "UserHeaderView.h"
#import "UserCenterTableCell.h"
#import "CustomShareViewController.h"
#import "UserDefaultsManager.h"
#import "UserInfoRequest.h"
#import "UserInfoResponse.h"
#import "ListUserRecordRequest.h"
#import "ListUserRecordResponse.h"
#import "FrontCoverImages.h"
#import "UIImageView+(ASI).h"
#import "UIImage+extend.h"
#import "UITableView+ZGParallelView.h"

#define     kHeaderImageHeight      140.0f
#define     kUserHeaderHeight       120.0f
#define     kCellHeight             95+30

@implementation UserCenterView

@synthesize headerImageView = _headerImageView;
@synthesize footerImageView = _footerImageView;
@synthesize userHeader      = _userHeader;
@synthesize likeButton      = _likeButton;
@synthesize shareButton     = _shareButton;
@synthesize controller      = _controller;
@synthesize tableView       = _tableView;
@synthesize settingButton   = _settingButton;
@synthesize result          = _result;
@synthesize content         = _content;
@synthesize isFromOtherUser = _isFromOtherUser;
@synthesize decorate        = _decorate;
@synthesize request         = _request;
@synthesize response        = _response;
@synthesize userID          = _userID;
@synthesize itemBlock       = _itemBlock;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackGroundImage]];
        
        /*CGSize contentSize = self.frame.size;
        contentSize.height *= 1.2f;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.contentSize = contentSize;
        self.delegate = self;
        
        [self addSubview:self.headerImageView withAcceleration:CGPointMake(0.0f, 0.5f)];*/
        
        //[self addSubview:self.viewContent];
        
        /*UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(66, kHeaderImageHeight, 2, 960)] autorelease];
        lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_line_bg"]];
        lineView.tag = 101;
        lineView.hidden = YES;
        [self addSubview:lineView];*/
        
        [self addSubview:self.tableView];
        
        [self addSubview:self.toTopButton];
        
        //
        UIView *btnView = [[[UIView alloc] initWithFrame:CGRectMake(204, 30, 116, 40)] autorelease];
        [btnView setTag:99];
        [btnView addBackgroundStretchableImage:@"user_button_bg" leftCapWidth:0 topCapHeight:0];
        [btnView addSubview:self.likeButton];
        [btnView addSubview:self.shareButton];
        [self.tableView addSubview:btnView];
        
        self.isFromOtherUser = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frontCoverChanged:) name:kFontCoverImageDidChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userIconChanged:) name:kSeJieUserIconChangedNotification object:nil];
    }
    return self;
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_headerImageView);
    TT_RELEASE_SAFELY(_footerImageView);
    TT_RELEASE_SAFELY(_userHeader);
    TT_RELEASE_SAFELY(_likeButton);
    TT_RELEASE_SAFELY(_shareButton);
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_settingButton);
    TT_RELEASE_SAFELY(_result);
    TT_RELEASE_SAFELY(_decorate);
    TT_RELEASE_SAFELY(_userID);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_itemBlock);
    [super dealloc];
}

- (void) frontCoverChanged:(NSNotification *)notification
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[[FrontCoverImages instance] stringURL]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            _headerImageView.image = [image imageWithCornerRadius:4];
        }
    }];
    [self tableViewDidStartRefreshing:nil];
}

- (void) userIconChanged:(NSNotification *)notification
{
    [_userHeader updatePhotoImage:[UserDefaultsManager userIcon]];
    [self tableViewDidStartRefreshing:nil];
}

- (void) clearData
{
    if (self.result) {
        [self.result removeAllObjects];
        [self.tableView reloadData];
    }
}

- (void) updateMyAccount
{
    [self updateAccount:[UserDefaultsManager userId]
               userName:[UserDefaultsManager userName]
               userType:@"a"];
    [self.userHeader resetPhotoImage];
    [self.userHeader updatePhotoImage:[UserDefaultsManager userIcon]];
}

- (void) updateAccount:(NSString *)userId userName:(NSString *)name userType:(NSString *)type
{
    [self.userHeader.userNameLabel setText:name];
    
    [self requestUserInfo:userId userType:type];
    
    [self requestRecordList:userId];
}

- (void) adjustViewContentSize
{
//    if (self.result.count == 0) {
//        [[self viewWithTag:101] setHidden:YES];
//    } else {
//        [[self viewWithTag:101] setHidden:NO];
//    }
}

- (void) requestUserInfo:(NSString *)userId userType:(NSString *)type
{
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        UserInfoResponse *response = [[[UserInfoResponse alloc] initWithJsonString:content] autorelease];
        
        //[self.userHeader.userNameLabel setText:response.userInfo.username];
        
        if ([response.userInfo.likecnt isEqualToString:@"0"]) {
            [[self viewWithTag:99] setFrameX:262];
        }
        else {
            [[self viewWithTag:99] setFrameX:204];
        }
        
        [self.likeButton setCount:response.userInfo.likecnt];
        [self.shareButton setCount:response.userInfo.sharecnt];
        
        [self.userHeader updatePhotoImage:response.userInfo.icon];
        
        if ([userId isEqualToString:[UserDefaultsManager userId]]) {
            [UserDefaultsManager saveUserIcon:response.userInfo.icon];
        }
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
    };
    
    //
    [self showProgress];
    
    UserInfoRequest *request = [[[UserInfoRequest alloc] init] autorelease];
    request.userid = userId;//;
    request.usertype = type;//;
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod info]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (void) requestRecordList:(NSString *)userId
{
    isLoading = YES;
    
    self.userID = userId;
    
    if (!self.request) {
        self.request  = [[[ListUserRecordRequest alloc] init] autorelease];
    }
    
    self.request.userid = userId;
    
    __block UserCenterView *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        isLoading = NO;
        [self dismissProgress];
        DEBUGLOG(@"content = %@", content);
        if ([blockSelf.request isFristPage]) {
            blockSelf.response = [[[ListUserRecordResponse alloc] initWithJsonString:content] autorelease];
            blockSelf.result = blockSelf.response.result;
            
            [blockSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            [blockSelf.response appendPaggingFromJsonString:content];
        }
        
        _decorate.didReachTheEnd = [_response reachTheEnd];
        [blockSelf.tableView reloadData];
        [blockSelf adjustViewContentSize];
        [[blockSelf decorate] tableViewDidFinishedLoading];
        
        //[_footerImageView setHidden:([_response count] == 0) ? NO : ![_response reachTheEnd]];
    };
    
    idBlock failedBlock = ^(id content)
    {
        isLoading = NO;
        [self dismissProgress];
        ERRLOG(@"error = %@", content);
        [[blockSelf decorate] tableViewDidFinishedLoading];
    };
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod recordsearch]
                                     body:[self.request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

#pragma mark - Setter and Getter

- (UIImageView *) headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -120, 320, 420)];
        [self frontCoverChanged:nil];
    }
    return _headerImageView;
}

/*- (UIView *) viewContent
{
    if (!_viewContent) {
        _viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 200)];
        _viewContent.backgroundColor = kClearColor;//
        
        self.userHeader = [[[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, kUserHeaderHeight)] autorelease];
        [self.userHeader addSubview:[self settingButton]];
        
        UIView *statusView = [[[UIView alloc] initWithFrame:CGRectMake(0, kUserHeaderHeight, 320, 960)] autorelease];
        statusView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackGroundImage]];
        UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(66, -2, 2, 960)] autorelease];
        lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_line_bg"]];
        lineView.tag = 101;
        lineView.hidden = YES;
        [statusView addSubview:lineView];
        [statusView addSubview:self.tableView];

        [_viewContent addSubview:self.userHeader];
        [_viewContent addSubview:statusView];
    }
    
    return _viewContent;
}*/

- (UIButton *) settingButton
{
    if (!_settingButton) {
        _settingButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _settingButton.frame = CGRectMake(270, 70, 44, 44);
        [_settingButton setNormalImage:kUserSettingBtnImage hilighted:nil selectedImage:nil];
        _settingButton.backgroundColor = kClearColor;
        [_settingButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _settingButton;
}

- (UserCountButton *) likeButton
{
    if (!_likeButton) {
        _likeButton = [[UserCountButton buttonWithType:UIButtonTypeCustom] retain];
        _likeButton.backgroundColor = kClearColor;
        _likeButton.frame = CGRectMake(58, 0, 58, 40);
        [_likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
        //[_likeButton setCount:@"250"];
//        [_likeButton setNormalImage:@"user_like_btn" hilighted:nil selectedImage:nil];
        //[_likeButton setBackgroundImage:kUserSettingBtnImage selectedImage:nil clickImage:nil];// ormalImage:kUserSettingBtnImage hilighted:nil selectedImage:nil];
        [_likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (UserCountButton *) shareButton
{
    if (!_shareButton) {
        _shareButton = [[UserCountButton buttonWithType:UIButtonTypeCustom] retain];
        _shareButton.backgroundColor = kClearColor;
        _shareButton.frame = CGRectMake(0, 0, 58, 40);
        [_shareButton setTitle:@"照片" forState:UIControlStateNormal];
        //[_shareButton setCount:@"50"];
//        [_shareButton setNormalImage:@"user_share_btn" hilighted:nil selectedImage:nil];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UIButton *) toTopButton
{
    if (!_toTopButton) {
        _toTopButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_toTopButton setNormalImage:@"backup_to_top" selectedImage:nil];
        [_toTopButton setFrame:CGRectMake(266, self.height - 70, 44, 44)];
        [_toTopButton addTarget:self action:@selector(gotoTop:) forControlEvents:UIControlEventTouchUpInside];
        [_toTopButton setHidden:YES];
    }
    return _toTopButton;
}

- (IBAction)gotoTop:(id)sender
{
    if (self.result.count != 0)
    {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        //[_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:kContentFrame
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = kClearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_tableView.scrollEnabled = NO;
        _decorate = [[WASScrollViewDecorate alloc] initWithFrame:_tableView.bounds with:_tableView type:eTypeFooter delegate:self];
        
        [_tableView addParallelViewWithUIView:self.headerImageView];
        
        _userHeader = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 90, 320, kUserHeaderHeight)];
        [_userHeader addSubview:[self settingButton]];
        [_tableView addSubview:_userHeader];

    }
    return _tableView;
}

- (UIView *) progressView
{
    if (!_progressView) {
        
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
        _progressView.backgroundColor = kClearColor;
        
        UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        activityView.center = CGPointMake(30, 20);
//        activityView.frame = CGRectMake(100, 0, 40, 40);
        activityView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [activityView startAnimating];
        [_progressView addSubview:activityView];
        
        UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 120, 40)] autorelease];
        textLabel.backgroundColor = kClearColor;
        textLabel.text = @"精彩载入中...";
        textLabel.font = SYSTEMFONT(kFontSize14);
        textLabel.textColor = kDarkGrayColor;
        [_progressView addSubview:textLabel];
    }
    return _progressView;
}

- (void) showProgress
{
    [self addSubview:self.progressView];
}

- (void) dismissProgress
{
    [self.progressView removeFromSuperview];
}

#pragma mark ==

- (void)tableViewDidStartRefreshing:(WASScrollViewDecorate *)tableView
{
    if (self.request && self.userID) {
        [self.request firstPage];
        [self requestRecordList:self.userID];
    } 
}

- (void)tableViewDidStartLoading:(WASScrollViewDecorate *)tableView
{
    if (self.response) {
        [self.request nextPage];
        [self requestRecordList:self.userID];
    }
}

#pragma mark - Actions

- (IBAction)settingAction:(id)sender
{
    Class class = NSClassFromString(@"SettingViewController"); 
    [self.controller.navigationController pushViewController:[[[class alloc] init] autorelease] animated:YES];
}

- (IBAction)likeAction:(id)sender
{
    if ([_likeButton.count intValue] <= 0) {
        return;
    }
    
    CustomShareViewController *likeController = [[[CustomShareViewController alloc] initWithType:(_isFromOtherUser) ? eOtherAccountLike : eCustomAccountLike
                                                                                        userName:self.userHeader.userNameLabel.text] autorelease];
    likeController.content = self.content;
    [self.controller.navigationController pushViewController:likeController animated:YES];
}

- (IBAction)shareAction:(id)sender
{
    if ([_shareButton.count intValue] <= 0) {
        return;
    }
    
    CustomShareViewController *shareController = [[[CustomShareViewController alloc] initWithType:(_isFromOtherUser) ? eOtherAccountShare : eCustomAccountShare
                                                                                         userName:self.userHeader.userNameLabel.text] autorelease];
    shareController.content = self.content;
    [self.controller.navigationController pushViewController:shareController animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y > kBoundsHeight) {
        [self.toTopButton setHidden:NO];
    } else {
        [self.toTopButton setHidden:YES];
    }
    
    [_decorate tableViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.result.count == 0)
        return kCellHeight;
    UserRecordItem *item = [self.result objectAtIndex:indexPath.row];
    return item.imageHeight + 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result.count > 0 ? self.result.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.result.count == 0) {
        static NSString *emptyIdentifier = @"emptyIdentifier";
        /*UserCenterEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:emptyIdentifier];
        if (!cell) {
            cell = [[[UserCenterEmptyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:emptyIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [_toTopButton setHidden:YES];*/
        
        UITableViewCell *emptycell = [tableView dequeueReusableCellWithIdentifier:emptyIdentifier];
        if (!emptycell) {
            emptycell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:emptyIdentifier] autorelease];
            emptycell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kShareBottomBGImage]] autorelease];
            imageView.frame = CGRectMake(37, 20, 60, 12);
            [emptycell addSubview:imageView];
            
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(66, 0, 2, 20)] autorelease];
            lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_line_bg"]];
            [emptycell addSubview:lineView];
        }

        return emptycell;
    }
    
    static NSString *normalIdentifier = @"normalIdentifier";
    UserCenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:normalIdentifier];
    if (!cell) {
        cell = [[[UserCenterTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.block = self.itemBlock;
    }
    
    [cell updateCellData:[self.result objectAtIndex:indexPath.row]];
    
    return cell;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kUserHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kUserHeaderHeight)] autorelease];
    view.backgroundColor = kClearColor;
    if (!_userHeader) {
        _userHeader = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, kUserHeaderHeight)];
    }
    //[view addSubview:_userHeader];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_tableView.contentOffset.y > kBoundsHeight) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    view.backgroundColor = kClearColor;
    if (!_footerImageView) {
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kShareBottomBGImage]] autorelease];
        imageView.frame = CGRectMake(37, 20, 60, 12);
        self.footerImageView = imageView;
    }
    [view addSubview:_footerImageView];
    
    UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(66, 0, 2, 20)] autorelease];
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_line_bg"]];
    [view addSubview:lineView];
    
    return view;
}*/

@end
