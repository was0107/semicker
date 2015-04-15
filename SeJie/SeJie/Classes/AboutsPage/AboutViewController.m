//
//  AboutViewController.m
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import "AboutViewController.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"
#import "FeedbackViewController.h"
#import "DisclaimerViewController.h"
#import "SplashViewController.h"
#import "BaseWebViewController.h"
#import "UserDefaultsManager.h"
#import "MainViewController.h"
#import "iRate/iRate.h"


#define B5M_SINA_WEIBO  @"http://m.weibo.cn/u/3147618932"  


@interface AboutViewController () < UITableViewDelegate, UITableViewDataSource >

@property (nonatomic, retain) UITableView   *tableView;
@property (nonatomic, retain) UILabel       *versionLabel;
@property (nonatomic, retain) UILabel       *qqGroupLabel;
@property (nonatomic, retain) UILabel       *debugLabel;

@end

@implementation AboutViewController

@synthesize tableView = _tableView;
@synthesize versionLabel = _versionLabel;
@synthesize qqGroupLabel = _qqGroupLabel;
@synthesize debugLabel = _debugLabel;

#pragma mark - base

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pageViewId = TD_PAGE_ABOUT;

    [[self titleLabel] setText:kTitleAboutString];
    [self.titleView addSubview:[self leftButton]];
    
    //
    UIImageView *aboutImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAboutLogoImage]] autorelease];
    [aboutImage setFrame:kAboutLogoFrame];
    [aboutImage setContentMode:UIViewContentModeCenter];
    [self.view addSubview:aboutImage];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.qqGroupLabel];
    
#ifdef kUseSimulateData
    [self.view addSubview:self.debugLabel];
#endif

}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_versionLabel);
    TT_RELEASE_SAFELY(_qqGroupLabel);
    TT_RELEASE_SAFELY(_debugLabel);
    [super reduceMemory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
//        [leftButton setImage:[UIImage imageNamed:kMainBackIconImage] forState:UIControlStateNormal];
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];

//        [leftButton setImage:nil forState:UIControlStateHighlighted];
//        [leftButton setImage:nil forState:UIControlStateSelected];
    }
    
    return leftButton;
}

#pragma mark - Actions

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:kAboutTableFrame style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UILabel *) versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:kAboutVersionFrame];
        [_versionLabel setBackgroundColor:kClearColor];
        [_versionLabel setTextColor:kDarkGrayColor];
        [_versionLabel setFont:TNRFontSIZEBIG(kFontSize13)];
        [_versionLabel setTextAlignment:NSTextAlignmentCenter];
        [_versionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,
                             [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
        [_versionLabel setText:version];
    }
    return _versionLabel;
}

- (UILabel *) qqGroupLabel
{
    if (!_qqGroupLabel) {
        _qqGroupLabel = [[UILabel alloc] initWithFrame:kAboutQQGroupFrame];
        [_qqGroupLabel setBackgroundColor:kClearColor];
        [_qqGroupLabel setText:kAboutItemStringQQGroup];
        [_qqGroupLabel setTextColor:kDarkGrayColor];
        [_qqGroupLabel setFont:TNRFontSIZEBIG(kFontSize13)];
        [_qqGroupLabel setTextAlignment:NSTextAlignmentCenter];
        [_qqGroupLabel setLineBreakMode:NSLineBreakByWordWrapping];
    }
    return _qqGroupLabel;
}

- (UILabel *) debugLabel
{
    if (!_debugLabel) {
        _debugLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 440+kHeightIncrease, 320, 15)];
        [_debugLabel setBackgroundColor:kClearColor];
        [_debugLabel setText:kHostDomain];
        [_debugLabel setTextColor:kRedColor];
        [_debugLabel setFont:TNRFontSIZEBIG(kFontSize13)];
        [_debugLabel setTextAlignment:NSTextAlignmentCenter];
        [_debugLabel setLineBreakMode:NSLineBreakByWordWrapping];
    }
    return _debugLabel;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = TNRFontSIZEBIG(kFontSize15);
        cell.textLabel.textColor = kDarkGrayColor;
    }

    switch (indexPath.row) {
        case eTableViewRowIndex01:  //官方微博
        {
            cell.textLabel.text = kAboutItemStringWeibo;
        }
            break;
            
        case eTableViewRowIndex00:  //评价
        {
            NSInteger gender = [UserDefaultsManager userGender];
            NSString *text = [NSString stringWithFormat:kAboutItemStringComment, (gender==eGenderFemale) ? @"女神":@"帅锅"];
            cell.textLabel.text = text;
        }
            break;
//        case eTableViewRowIndex01:  //性别切换
//        {
//            NSInteger gender = [UserDefaultsManager userGender];
//            NSString *text = [NSString stringWithFormat:kAboutItemStringGender, (gender==eGenderFemale) ? @"白富美":@"高富帅"];
//            cell.textLabel.text = text;
//        }
//            break;
            
        case eTableViewRowIndex02:  //意见反馈
        {
            cell.textLabel.text = kAboutItemStringFeedback;
        }
            break;
 
        case eTableViewRowIndex03:  //免责声明
        {
            cell.textLabel.text = kTitleDisclaimerString;
        }
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case eTableViewRowIndex01:  //官方微博
        {
            BaseWebViewController *weiboController = [[[BaseWebViewController alloc] init] autorelease];
            weiboController.pageViewId = TD_PAGE_SEJIE_WEIBO;
            weiboController.requestURL = B5M_SINA_WEIBO;
            weiboController.titleLabel.text = kAboutItemStringWeibo;
            [self.navigationController pushViewController:weiboController animated:YES];
        }
            break;
            
        case eTableViewRowIndex00:  //评价
        {
            [[iRate sharedInstance] openRatingsPageInAppStore];
        }
            break;
            
//        case eTableViewRowIndex01:  //性别切换
//        {
//            SplashViewController *controller = [[[SplashViewController alloc] init] autorelease];
//            controller.block = ^{
//                UIViewController *popToController = nil;
//                for (UIViewController *controller in [self.navigationController viewControllers]) {
//                    if ([controller isKindOfClass:[MainViewController class]]) {
//                        popToController = controller;
//                    }
//                }
//                if (popToController) {
//                    [self.navigationController popToViewController:popToController animated:YES];
//                } else {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//            };
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
            
        case eTableViewRowIndex02:  //意见反馈
        {
            FeedbackViewController *controller = [[[FeedbackViewController alloc] init] autorelease];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case eTableViewRowIndex03:  //免责声明
        {
            DisclaimerViewController *controller = [[[DisclaimerViewController alloc] init] autorelease];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;

    }
}

@end
