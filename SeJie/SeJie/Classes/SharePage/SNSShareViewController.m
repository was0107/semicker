//
//  SNSShareViewController.m
// sejieios
//
//  Created by Jarry on 13-2-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SNSShareViewController.h"
#import "UIView+extend.h"
#import "SinaWeiboUtility.h"
#import "ShareRecordRequest.h"
#import "UserDefaultsManager.h"
#import "ShareUtility.h"
#import "ThirdLoginRequest.h"
#import "LoginResponse.h"

@implementation SNSShareViewController

@synthesize itemData    = _itemData;
@synthesize selectView  = _selectView;
@synthesize shareType   = _shareType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_SHARE_WEIBO;
    
    self.shareType = eSNSTypeWeibo;
    [((UILabel*)[self.shareView viewWithTag:105]) setText:@"分享："];
    
    [[self titleLabel] setText:kTitleImageShareString];
    
    //
    [self.shareView addSubview:self.weiboBtn];
    [self.shareView addSubview:self.weixinBtn];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_selectView);
    TT_RELEASE_SAFELY(_weiboBtn);
    TT_RELEASE_SAFELY(_weixinBtn);
    [super reduceMemory];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollView addSubview:self.selectView];
    
    self.selectView.layer.transform = CATransform3DMakeScale(1.0, 0.1, 1.0);
    self.selectView.alpha = 0.9f;
    [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
        self.selectView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    }];
}

- (UIButton *) weiboBtn
{
    if (!_weiboBtn) {
        _weiboBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _weiboBtn.frame = CGRectMake(60, 112, 22, 20);
        [_weiboBtn setNormalImage:@"sns_btn_weibo" selectedImage:@"sns_btn_weibo_select"];
        [_weiboBtn setEnabled:NO];
        //[weiboButton addTarget:self action:@selector(weiboAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboBtn;
}

- (UIButton *) weixinBtn
{
    if (!_weixinBtn) {
        _weixinBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _weixinBtn.frame = CGRectMake(100, 112, 22, 20);
        [_weixinBtn setNormalImage:@"sns_btn_weixin" selectedImage:@"sns_btn_weixin_select"];
        [_weixinBtn setEnabled:NO];
        //[_weixinBtn addTarget:self action:@selector(weiboAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinBtn;
}

- (UIView *) selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 125, 280, 124)];
        _selectView.backgroundColor = kWhiteColor;
        _selectView.layer.cornerRadius = 8.0;
        _selectView.layer.borderColor = [kGrayColor CGColor];
        _selectView.layer.borderWidth = 0.8f;
        _selectView.alpha = 0.0f;
        
        UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
        weiboButton.frame = CGRectMake(50, 20, 64, 64);
        [weiboButton setNormalImage:@"sns_icon_weibo" selectedImage:nil];
        [weiboButton addTarget:self action:@selector(weiboAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectView addSubview:weiboButton];
        
        UILabel *weiboLabel = [[[UILabel alloc] initWithFrame:CGRectMake(50, 90, 64, 20)] autorelease];
        weiboLabel.backgroundColor = kClearColor;
        weiboLabel.text = @"新浪微博";
        weiboLabel.textColor = kDarkGrayColor;
        weiboLabel.textAlignment = NSTextAlignmentCenter;
        weiboLabel.font = TNRFontSIZEBIG(kFontSize14);
        [_selectView addSubview:weiboLabel];
        
        UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        weixinButton.frame = CGRectMake(165, 20, 64, 64);
        [weixinButton setNormalImage:@"sns_icon_weixin" selectedImage:nil];
        [weixinButton addTarget:self action:@selector(weixinAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectView addSubview:weixinButton];
        
        UILabel *weixinLabel = [[[UILabel alloc] initWithFrame:CGRectMake(165, 90, 64, 20)] autorelease];
        weixinLabel.backgroundColor = kClearColor;
        weixinLabel.text = @"微 信";
        weixinLabel.textColor = kDarkGrayColor;
        weixinLabel.textAlignment = NSTextAlignmentCenter;
        weixinLabel.font = TNRFontSIZEBIG(kFontSize14);
        [_selectView addSubview:weixinLabel];
    }
    return _selectView;
}

- (IBAction)weixinAction:(id)sender
{
    self.shareType = eSNSTypeWeixin;
    //[self.weixinBtn setSelected:YES];
    [self.weixinBtn setNormalImage:@"sns_btn_weixin_select" selectedImage:nil];
    [self selectTypeAction];
}

- (IBAction)weiboAction:(id)sender
{
    self.shareType = eSNSTypeWeibo;
    //[self.weiboBtn setSelected:YES];
    [self.weiboBtn setNormalImage:@"sns_btn_weibo_select" selectedImage:nil];
    [self selectTypeAction];
}

- (void) selectTypeAction
{
    [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
        
        self.selectView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self.selectView removeFromSuperview];
        
        self.shareView.layer.transform = CATransform3DMakeScale(1.0, 0.1, 1.0);
        self.shareView.alpha = 1.0f;
        [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
            self.shareView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        }];
    }];
}

- (NSString *) shareText
{
    NSString *text = self.contentTextView.text;
    if (!text || text.length==0) {
        text = [NSString stringWithFormat:kShareImageDefaultText, self.itemData.soureImg];
    }
    return text;//[NSString stringWithFormat:@"%@%@", text,kShareImageEndText];
}

- (void) shareRequest
{
    [[ShareUtility instance] setShareType:self.shareType];
    [[ShareUtility instance] shareImageWithSNS:self.shareImageView.image
                                           url:self.itemData.soureImg
                                          text:[self shareText]
                                         block:^(id content1, id content2, id content3)
     {
         if (content1) { //未授权时 授权成功 重新发送分享 (新浪微博)
             // 未登录
             NSString *userID = [UserDefaultsManager userId];
             if (!userID || userID.length == 0) {
                 [UserDefaultsManager saveUserName:content2];
                 [UserDefaultsManager saveUserIcon:content3];
                 // 授权成功  发登陆请求
                 [self sendThirdLoginRequest:content1 type:@"weibo"];
             }
             //
             [self shareRequest];
             return;
         }
         
         [SVProgressHUD showSuccessWithStatus:kTipShareImageSuccess];

         // 记录
         [self shareRecordRequest];
         [super enableButton];
         
         // 分享成功 返回
         [self.navigationController popViewControllerAnimated:YES];
         
     } cancel:^(id content) {
         
         [SVProgressHUD showErrorWithStatus:kTipShareImageFailed];
         
         [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
             self.shareView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
         }];
         
         [super enableButton];
         
     } failed:^(id content) {
         
         [SVProgressHUD showErrorWithStatus:kTipShareImageFailed];
         
         [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
             self.shareView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
         }];
         [super enableButton];
     }];
}

- (void) shareRecordRequest
{
    [RecordUtility recored:self.itemData target:self.itemData.soureImg label:self.itemData.label action:eRecordActionShare];
}

- (void) sendThirdLoginRequest:(NSString *)uid type:(NSString *)type
{
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        // 登录成功
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        // 保存用户信息
        [UserDefaultsManager saveUserId:response.userInfo.userid];
        //[UserDefaultsManager saveUserName:response.userInfo.username];
        [UserDefaultsManager saveUserType:@"b"];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
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

@end
