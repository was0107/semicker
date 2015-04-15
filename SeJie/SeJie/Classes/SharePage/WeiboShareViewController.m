//
//  WeiboShareViewController.m
// sejieios
//
//  Created by Jarry on 13-1-16.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "WeiboShareViewController.h"
#import "UIView+extend.h"
#import "SinaWeiboUtility.h"
#import "ShareRecordRequest.h"
#import "UserDefaultsManager.h"
#import "WeixinUtility.h"


@implementation WeiboShareViewController

@synthesize itemData    = _itemData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_SHARE_WEIBO;

    [[self titleLabel] setText:kTitleWeiboShareString];

}

- (void) reduceMemory
{
    [super reduceMemory];
}

- (NSString *) shareText
{
    NSString *text = self.contentTextView.text;
    if (!text || text.length==0) {
        text = kShareImageDefaultText;
    }
    return text;//[NSString stringWithFormat:@"%@%@", text,kShareImageEndText];
}

- (void) shareRequest
{
    //[[SinaWeiboUtility sharedInstance] shareImageWithText:self.shareImageView.image
    [[SinaWeiboUtility sharedInstance] shareImageWithUrl:self.itemData.soureImg
                                                    text:[self shareText]
                                                   block:^(id content1, id content2, id content3)
     {
         if (content1) { //未授权时 授权成功 重新发送分享
             [self shareRequest];
             return;
         }
         
         // 记录
         [self shareRecordRequest];
         [super enableButton];

         // 分享成功 返回
         [self.navigationController popViewControllerAnimated:YES];
         
     } cancel:^(id content) {
         
         [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
             self.shareView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
         }];
         
         [super enableButton];
         
     } failed:^(id content) {
         
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

@end
