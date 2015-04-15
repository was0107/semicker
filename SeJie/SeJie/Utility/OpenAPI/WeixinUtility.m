//
//  WeixinUtility.m
// sejieios
//
//  Created by Jarry on 13-2-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "WeixinUtility.h"

#define BUFFER_SIZE 1024

@implementation WeixinUtility

@synthesize completeBlock   = _completeBlock;
@synthesize cancelBlock     = _cancelBlock;
@synthesize failedBlock     = _failedBlock;


+ (WeixinUtility *) instance
{
    static dispatch_once_t  onceToken;
    static WeixinUtility * instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[WeixinUtility alloc] init];
    });
    return instance;
}

- (WeixinUtility *)init
{
    if ((self = [super init])) {
        //向微信注册
        //[WXApi registerApp:kWeixin_APPID];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_completeBlock);
    TT_RELEASE_SAFELY(_cancelBlock);
    TT_RELEASE_SAFELY(_failedBlock);
    [super dealloc];
}

#pragma mark - Public methods

- (BOOL) handleOpenUrl:(NSURL *)url
{
    return  YES;//[WXApi handleOpenURL:url delegate:self];
}

- (void) doAuth:(idRange3Block)completeBlock
         cancel:(idBlock)cancelBlock
         failed:(idBlock)failedBlock
{
    self.completeBlock = completeBlock;
    self.cancelBlock    = cancelBlock;
    self.failedBlock    = failedBlock;
    
    
}

- (void) shareImageWithUrl:(NSString *)url
                      text:(NSString *)text
{
//    WXMediaMessage *message = [WXMediaMessage message];
//    //[message setThumbImage:[UIImage imageNamed:"res2.jpg"]];
//    message.title = text;
//    message.description = text;
//    
//    WXImageObject *ext = [WXImageObject object];
//    ext.imageUrl = url;
//    message.mediaObject = ext;
//        
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = NO;
//    req.message = message;
//    //req.scene = WXSceneTimeline;  //选择发送到朋友圈，默认值为WXSceneSession，发送到会话
//    
//    [WXApi sendReq:req];
}

- (void) shareImageContent:(UIImage *)image
                      text:(NSString *)text
                     block:(idRange3Block)completeBlock
                    cancel:(idBlock)cancelBlock
                    failed:(idBlock)failedBlock
{
    self.completeBlock = completeBlock;
    self.cancelBlock   = cancelBlock;
    self.failedBlock   = failedBlock;
    
    // 发送内容给微信
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = @"色界－精彩美图，发现兴趣，享受购物";
//    message.description = text;
//    [message setThumbImage:image];
//    
//    WXAppExtendObject *ext = [WXAppExtendObject object];
//    ext.extInfo = @"<xml>test</xml>";
//    ext.url = @"https://itunes.apple.com/cn/app/se-jie-jing-cai-mei-tu-fa/id595252508?ls=1&mt=8";
//    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
//    memset(pBuffer, 0, BUFFER_SIZE);
//    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
//    free(pBuffer);
//    ext.fileData = data;
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init] autorelease];
//    req.bText = NO;
//    req.message = message;
//    //req.scene = _scene;
//    
//    [WXApi sendReq:req];
}

- (void) sendTextContent:(NSString*)nsText
{
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init] autorelease];
//    req.bText = YES;
//    req.text = nsText;
//    //req.scene = _scene;
//    
//    [WXApi sendReq:req];
}

- (BOOL) checkInstalled
{
    BOOL isInstall = NO;//[WXApi isWXAppInstalled];
    if (!isInstall) {
        
        
    }
    
    return isInstall;
}

#pragma mark - WXApiDelegate

//-(void) onReq:(BaseReq*)req
//{
//    if([req isKindOfClass:[GetMessageFromWXReq class]])
//    {
//        //[self onRequestAppMessage];
//    }
//    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
//    {
//        //ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
//        //[self onShowMediaMessage:temp.message];
//    }
//}
//
//-(void) onResp:(BaseResp*)resp
//{
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        if (resp.errCode == 0) {
//
//            if (self.completeBlock) {
//                self.completeBlock(nil, nil, nil);
//            }
//        }
//        else {
//            if (self.failedBlock) {
//                self.failedBlock(nil);
//            }
//        }
//        
//        /*NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d %@", resp.errCode, resp.errStr];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];*/
//    }
//    else if([resp isKindOfClass:[SendAuthResp class]])
//    {
//        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
//}


@end
