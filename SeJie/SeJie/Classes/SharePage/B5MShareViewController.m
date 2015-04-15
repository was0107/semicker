//
//  B5MShareViewController.m
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "B5MShareViewController.h"
#import "ListShareRequest.h"
#import "UserDefaultsManager.h"
#import "ListUploadImageResponse.h"
#import "SinaWeiboUtility.h"

@implementation B5MShareViewController

@synthesize weiboBtn    = _weiboBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.pageViewId = TD_PAGE_SHARE_PICTURE;
    
    [[self titleLabel] setText:kTitleB5MShareString];
    
    [((UILabel*)[self.shareView viewWithTag:105]) setText:@"同步："];
    [self.shareView addSubview:self.weiboBtn];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.shareView.layer.transform = CATransform3DMakeScale(1.0, 0.1, 1.0);
    self.shareView.alpha = 1.0f;
    [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
        self.shareView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    }];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_weiboBtn);
    [super reduceMemory];
}

- (UIButton *) weiboBtn
{
    if (!_weiboBtn) {
        _weiboBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _weiboBtn.frame = CGRectMake(60, 112, 22, 20);
        [_weiboBtn setNormalImage:@"sns_btn_weibo" selectedImage:@"sns_btn_weibo_select"];
        //[_weiboBtn setEnabled:NO];
        [_weiboBtn addTarget:self action:@selector(weiboAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[SinaWeiboUtility sharedInstance] isAuthValid]) {
            [_weiboBtn setSelected:YES];
        }
    }
    return _weiboBtn;
}

- (NSString *) shareText
{
    NSString *text = self.contentTextView.text;
    if (!text || text.length==0) {
        return kEmptyString;
    }
    return text;
}

- (void) shareRequest
{
    // 照片上传
    [[DataTracker sharedInstance] trackEvent:TD_EVENT_USER_UPLOAD_PV withLabel:self.shareText category:TD_EVENT_Category];

    __block B5MShareViewController *blockSelf = self;
    __block BOOL failed = YES;
    
    //上传图片
    idBlock uploadErrorblock = ^(id content) {
        DEBUGLOG(@"content = %@", content);
        [SVProgressHUD showErrorWithStatus:kTipShareImageFailed];
        [super enableButton];
    };
    
    //上传分享信息
    idBlock shareErrorblock = ^(id content) {
        
        if (failed) {
            failed = NO;
            [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
                blockSelf.shareView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
            }];
        }
        [SVProgressHUD showErrorWithStatus:kTipShareImageFailed];
        DEBUGLOG(@"content = %@", content);
        [super enableButton];

    };
    
    ListShareRequest *shareRequest = [[[ListShareRequest alloc] init] autorelease];
    shareRequest.username = [UserDefaultsManager userName];
    shareRequest.userID   = [UserDefaultsManager userId];
    shareRequest.userType = [UserDefaultsManager userType];
    shareRequest.comment  = [self shareText];
    [SVProgressHUD showWithStatus:kTipShareImageLoading];

    [WASBaseServiceFace serviceUploadMethod:[URLMethod uploadpic]
                                       data:UIImageJPEGRepresentation(self.shareImageView.image,0.3)
                                       body:kEmptyString
                                      onSuc:^(id content)
     {
         // 上传成功
         [[DataTracker sharedInstance] trackEvent:TD_EVENT_USER_UPLOAD_OK_PV withLabel:self.shareText category:TD_EVENT_Category];
         DEBUGLOG(@"content = %@", content);
         ListUploadImageResponse *imageResponse = [[[ListUploadImageResponse alloc] initWithJsonString:content] autorelease];
         [shareRequest setPic:imageResponse.pic];
         
         [WASBaseServiceFace serviceWithMethod:[URLMethod sharepic]
                                          body:[shareRequest toJsonString]
                                         onSuc:^(id content)
          {
              DEBUGLOG(@"content = %@", content);
              [SVProgressHUD showSuccessWithStatus:kTipShareImageSuccess];
              [[NSNotificationCenter defaultCenter] postNotificationName:kShareSuccessNotification object:nil];
              [super enableButton];
              [blockSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
          }
                                      onFailed:shareErrorblock
                                       onError:shareErrorblock];
         
         // 同步到微博
         if ([self.weiboBtn isSelected]) {
             NSString *shareText = self.shareText;
             if (shareText.length == 0) {
                 shareText = [NSString stringWithFormat:kShareImageUploadText, imageResponse.pic];
             }
             [[SinaWeiboUtility sharedInstance] shareImageWithUrl:imageResponse.pic
                                                             text:shareText
                                                            block:nil
                                                           cancel:shareErrorblock
                                                           failed:shareErrorblock];
         }
         
     }
                                   onFailed:uploadErrorblock
                                    onError:uploadErrorblock];
    
}

#pragma mark - Actions
- (IBAction)weiboAction:(id)sender
{
    BOOL isSelect = [self.weiboBtn isSelected];
    [self.weiboBtn setSelected:(!isSelect)];
    
    if (!isSelect && ![[SinaWeiboUtility sharedInstance] isAuthValid]) {
        
        [[SinaWeiboUtility sharedInstance] doLogin:^(id content1, id content2, id content3)
        {
            
            
        } cancel:nil failed:nil];
    }
}

@end
