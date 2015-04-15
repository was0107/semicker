//
//  LoginViewController.m
// sejieios
//
//  Created by Jarry on 13-1-16.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "LoginViewController.h"
#import "B5MLoginViewController.h"
#import "SinaWeiboUtility.h"
#import "WeiboShareViewController.h"
#import "B5MShareViewController.h"
#import "UIView+extend.h"
#import "ThirdLoginRequest.h"
#import "LoginResponse.h"
#import "UserDefaultsManager.h"
#import "ShareUtility.h"
#import "TencentUtility.h"
#import "WASDataBase.h"
#import "UserObject.h"

#define kFirstLoginSinaURL  @"http://cdn.b5m.com/upload/sejie/weibosharead.png"
#define kFirstLoginWithSina @"墙裂推荐【iPhone上最好用的看图神器 [@精彩色界]，汇聚全网美图，每天实时更新；高富帅有看不尽的妹子图、内涵图；白富美有最时尚的潮流服饰、美妆大图；\
而且还可以直接搜索美图发微博，发微信，你们也赶快下载新版色界iPhone客户端吧】— 来自 >>http://app.b5m.com/s/ 分享自@精彩色界 iPhone版）"

@interface LoginViewController () 

@property (nonatomic, retain) UIButton      *weiboButton;
@property (nonatomic, retain) UIButton      *b5mButton;
@property (nonatomic, retain) UIButton      *qqButton;

@end

@implementation LoginViewController

@synthesize weiboButton = _weiboButton;
@synthesize b5mButton = _b5mButton;
@synthesize qqButton    = _qqButton;
@synthesize block = _block;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_LOGIN_MAIN;

    [self.titleView addSubview:self.leftButton];
    [[self titleLabel] setText:kTitleLoginString];
    
    //
    UIImageView *bgImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kUserLoginBgImage]] autorelease];
    [self.view addFillSubView:bgImage];
    [self.view sendSubviewToBack:bgImage];
    
    UIView *frameView = [[[UIView alloc] initWithFrame:CGRectMake(26, 46+kHeightIncrease/2, 268, 305)] autorelease];
    [frameView addBackgroundStretchableImage:kUserLoginFrameBgImage leftCapWidth:0 topCapHeight:50];
    //
    UIImageView *aboutImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAboutLogoImage]] autorelease];
    [aboutImage setFrame:CGRectMake(0, 0, 268, 140)];
    [aboutImage setContentMode:UIViewContentModeCenter];
    [frameView addSubview:aboutImage];
    
    [frameView addSubview:self.weiboButton];
    [frameView addSubview:self.qqButton];
    [frameView addSubview:self.b5mButton];
    
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    [scrollView setExtendHeight:44];
    scrollView.contentSize = CGSizeMake(scrollView.width, scrollView.height+1);
    scrollView.bounces = YES;
    [scrollView addSubview:frameView];
    [self.view addSubview:scrollView];
    
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_weiboButton);
    TT_RELEASE_SAFELY(_b5mButton);
    TT_RELEASE_SAFELY(_qqButton);
//    TT_RELEASE_SAFELY(pickerController);
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

- (UIButton *) weiboButton
{
    if (!_weiboButton) {
        _weiboButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _weiboButton.frame = CGRectMake(34, 130, 200, 36);
        _weiboButton.backgroundColor = kClearColor;
        //[_weiboButton setTitle:kTitleLoginWeiboString forState:UIControlStateNormal];
        [_weiboButton setNormalImage:kUserLoginSinaBtnImage hilighted:kUserLoginSinaBtnHlImage selectedImage:kUserLoginSinaBtnHlImage];
        [_weiboButton addTarget:self action:@selector(weiboAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboButton;
}

- (UIButton *) qqButton
{
    if (!_qqButton) {
        _qqButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _qqButton.frame = CGRectMake(34, 185, 200, 36);
        _qqButton.backgroundColor = kClearColor;
        [_qqButton setNormalImage:kUserLoginQqBtnImage hilighted:kUserLoginQqBtnHlImage selectedImage:kUserLoginQqBtnHlImage];
        [_qqButton addTarget:self action:@selector(qqAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqButton;
}

- (UIButton *) b5mButton
{
    if (!_b5mButton) {
        _b5mButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _b5mButton.frame = CGRectMake(34, 240, 200, 36);
        _b5mButton.backgroundColor = kClearColor;
        //[_b5mButton setTitle:kTitleLoginB5MString forState:UIControlStateNormal];
        [_b5mButton setNormalImage:kUserLoginB5mBtnImage hilighted:kUserLoginB5mBtnHlImage selectedImage:kUserLoginB5mBtnHlImage];
        [_b5mButton addTarget:self action:@selector(b5mAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b5mButton;
}

- (IBAction)weiboAction:(id)sender
{
    __block LoginViewController *blockSelf = self;
    [[ShareUtility instance] setShareType:eSNSTypeWeibo];
    [[SinaWeiboUtility sharedInstance] doLogin:^(id content1, id content2, id content3)
    {
 //        [SVProgressHUD showSuccessWithStatus:@"登录成功 ！"];
        
        // 授权成功  发登陆请求
        [blockSelf sendThirdLoginRequest:content1 type:@"weibo" name:content2 icon:content3];
        
        //发首次登录微博的请求
        [[WASDataBase sharedDBHelpter] setTableName:@"USER_HISTORY"];
        if (![[WASDataBase sharedDBHelpter] isExistKey:@"userID" value:content1]) {
            UserObject *sinaUser = [[[UserObject alloc] init] autorelease];
            sinaUser.userID = content1;
            sinaUser.userName = content2;
            sinaUser.userHeader = content3;
            [[WASDataBase sharedDBHelpter] insertItem:sinaUser with:@"userID" value:content1];
            
            //wait for confirm image's URL
            [[SinaWeiboUtility sharedInstance] shareImageWithUrl:kFirstLoginSinaURL
                                                            text:kFirstLoginWithSina
                                                           block:nil
                                                          cancel:nil
                                                          failed:nil];
        }
        
        
    } cancel:^(id content) {
        
    } failed:^(id content) {
        
    }];
}

- (IBAction)qqAction:(id)sender
{
    __block LoginViewController *blockSelf = self;
    [[ShareUtility instance] setShareType:eSNSTypeQQ];
    [[TencentUtility instance] doLogin:^(id content1, id content2, id content3)
    {
        DEBUGLOG(@"qqAction login ---- %@ -- %@ -- %@ ", content1, content2, content3);
        
        // 授权成功  发登陆请求
        [blockSelf sendThirdLoginRequest:content1 type:@"qq" name:content2 icon:content3];
        
        
    } cancel:^(id content) {
        
    } failed:^(id content) {
        
    }];
}

- (void) sendThirdLoginRequest:(NSString *)uid type:(NSString *)type name:(NSString *)name icon:(NSString *)icon
{
    __block LoginViewController *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        // 登录成功
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        
        // 保存用户信息
        [UserDefaultsManager saveUserId:response.userInfo.userid];
        //[UserDefaultsManager saveUserName:response.userInfo.username];
        [UserDefaultsManager saveUserType:@"b"];
        [UserDefaultsManager saveUserName:name];
        [UserDefaultsManager saveUserIcon:icon];

        [blockSelf.navigationController popViewControllerAnimated:YES];

        if (blockSelf.block) {
            blockSelf.block(nil);
        }
        
//        //
//        pickerController = [[CustomPickerViewController alloc] init];
//        [pickerController setCustomImagePickerDelegate:self];
//        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
        SBJSON *json = [[[SBJSON alloc]init] autorelease];
        NSDictionary *errDic = [json fragmentWithString:content error:nil];
        [SVProgressHUD showErrorWithStatus:[errDic objectForKey:@"msg"]];
    };
    
    ThirdLoginRequest *request = [[[ThirdLoginRequest alloc] init] autorelease];
    request.uid = uid;
    request.type = type;
    [WASBaseServiceFace serviceWithMethod:[URLMethod loginthird]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (IBAction)b5mAction:(id)sender
{
    B5MLoginViewController *controller = [[[B5MLoginViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ==
#pragma mark == UIImagePickerControllerDelegate

- (void)customImagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    DEBUGLOG(@"didFinishPickingImage  image = %@",image);
    B5MShareViewController *share = [[[B5MShareViewController alloc] init] autorelease];
    [share setShareImage:image];
    [picker pushViewController:share animated:YES];
    
}

- (void) rebackFromPhoto:(UIImagePickerController *)picker
{
//    [self.navigationController presentViewController:pickerController animated:YES completion:nil];
}


@end
