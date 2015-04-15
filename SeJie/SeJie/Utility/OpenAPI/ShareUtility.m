//
//  ShareUtility.m
// sejieios
//
//  Created by Jarry on 13-2-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ShareUtility.h"
#import "SinaWeiboUtility.h"
#import "WeixinUtility.h"
#import "TencentUtility.h"
#import "UIImage+extend.h"

@implementation ShareUtility

@synthesize shareType   = _shareType;

+ (ShareUtility *) instance
{
    static dispatch_once_t  onceToken;
    static ShareUtility * instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[ShareUtility alloc] init];
    });
    return instance;
}

- (void) initInstance
{
//    [WXApi registerApp:kWeixin_APPID];
}

- (BOOL) handleOpenUrl:(NSURL *)url
{
    if (self.shareType == eSNSTypeWeibo) {
        return YES;//[[SinaWeiboUtility sharedInstance].sinaWeibo handleOpenURL:url];
    }
    else if (self.shareType == eSNSTypeWeixin) {
        return [[WeixinUtility instance] handleOpenUrl:url];
    }
    else if (self.shareType == eSNSTypeQQ) {
        return YES;//[TencentOAuth HandleOpenURL:url];
    }
    
    return YES;
}

- (void) shareImageWithSNS:(UIImage *)image
                       url:(NSString *)url
                      text:(NSString *)text
                     block:(idRange3Block)completeBlock
                    cancel:(idBlock)cancelBlock
                    failed:(idBlock)failedBlock
{
    if (self.shareType == eSNSTypeWeibo) {
        
        [SVProgressHUD showWithStatus:kTipShareImageLoading];
        [[SinaWeiboUtility sharedInstance] shareImageWithUrl:url
                                                        text:text
                                                       block:completeBlock
                                                      cancel:cancelBlock
                                                      failed:failedBlock];
    }
    else if (self.shareType == eSNSTypeWeixin) {
        
        UIImage *thumbImage = [image imageScaledToWidth:80];
        [[WeixinUtility instance] shareImageContent:thumbImage
                                               text:text
                                              block:completeBlock
                                             cancel:cancelBlock
                                             failed:failedBlock];
    }
}

@end
