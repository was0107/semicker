//
//  TencentUtility.m
// sejieios
//
//  Created by Jarry on 13-2-19.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "TencentUtility.h"
#import "OpenAppKeyDefines.h"

@implementation TencentUtility

//@synthesize tencentOAuth    = _tencentOAuth;
@synthesize permissions     = _permissions;

@synthesize completeBlock   = _completeBlock;
@synthesize cancelBlock     = _cancelBlock;
@synthesize failedBlock     = _failedBlock;


+ (TencentUtility *) instance
{
    static dispatch_once_t  onceToken;
    static TencentUtility * instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[TencentUtility alloc] init];
    });
    
    return instance;
}

- (TencentUtility *)init
{
    if ((self = [super init])) {
        
//        _permissions = [[NSArray arrayWithObjects:
//                         kOPEN_PERMISSION_GET_USER_INFO,
//                         kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                         kOPEN_PERMISSION_ADD_IDOL,
//                         kOPEN_PERMISSION_ADD_ONE_BLOG,
//                         kOPEN_PERMISSION_ADD_PIC_T,
//                         kOPEN_PERMISSION_ADD_SHARE,
//                         kOPEN_PERMISSION_GET_INFO,
//                         kOPEN_PERMISSION_GET_OTHER_INFO,
//                         kOPEN_PERMISSION_GET_VIP_INFO,
//                         kOPEN_PERMISSION_GET_VIP_RICH_INFO,
//                         //kOPEN_PERMISSION_ADD_ALBUM,
//                         //kOPEN_PERMISSION_ADD_TOPIC,
//                         //kOPEN_PERMISSION_CHECK_PAGE_FANS,
//                         //kOPEN_PERMISSION_DEL_IDOL,
//                         //kOPEN_PERMISSION_DEL_T,
//                         //kOPEN_PERMISSION_GET_FANSLIST,
//                         //kOPEN_PERMISSION_GET_IDOLLIST,
//                         //kOPEN_PERMISSION_GET_REPOST_LIST,
//                         //kOPEN_PERMISSION_LIST_ALBUM,
//                         //kOPEN_PERMISSION_UPLOAD_PIC,
//                         //kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
//                         //kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
//                         nil] retain];
//
//        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQ_APPID
//                                                andDelegate:self];
//        
    }
    
    return self;
}

- (void) dealloc
{
//    TT_RELEASE_SAFELY(_tencentOAuth);
    TT_RELEASE_SAFELY(_permissions);
    TT_RELEASE_SAFELY(_completeBlock);
    TT_RELEASE_SAFELY(_cancelBlock);
    TT_RELEASE_SAFELY(_failedBlock);
    [super dealloc];
}

#pragma mark - Public methods

- (void) doLogin:(idRange3Block)completeBlock
          cancel:(idBlock)cancelBlock
          failed:(idBlock)failedBlock
{
    self.completeBlock = completeBlock;
    self.cancelBlock    = cancelBlock;
    self.failedBlock    = failedBlock;
    
//    [_tencentOAuth authorize:_permissions inSafari:NO];
}


#pragma mark - TencentSessionDelegate
/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin
{
//    if (_tencentOAuth.accessToken
//        && 0 != [_tencentOAuth.accessToken length])
//    {
//        // 登录成功 获取用户信息
//        [_tencentOAuth getUserInfo];
//
//    }
//    else
//    {
//        // 登陆不成功 没有获取accesstoken
//        if (self.failedBlock) {
//            self.failedBlock(nil);
//        }
//        //_labelAccessToken.text = @"登陆不成功 没有获取accesstoken";
//    }
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled){
		// "用户取消登录";
        if (self.cancelBlock) {
            self.cancelBlock(nil);
        }
	}
	else {
		// "登录失败";
        if (self.failedBlock) {
            self.failedBlock(nil);
        }
	}
	
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
	//_labelTitle.text=@"无网络连接，请设置网络";
}

/**
 * Called when the logout.
 */
-(void)tencentDidLogout
{

}

/**
 * Called when the get_user_info has response.
 */
//- (void)getUserInfoResponse:(APIResponse*) response
//{
//	if (response.retCode == URLREQUEST_SUCCEED)
//	{
//		/*NSMutableString *str=[NSMutableString stringWithFormat:@""];
//		for (id key in response.jsonResponse) {
//			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
//		}*/
//                
//        if (self.completeBlock) {
//            self.completeBlock(_tencentOAuth.openId, [response.jsonResponse objectForKey:@"nickname"], [response.jsonResponse objectForKey:@"figureurl_qq_2"]);
//        }
//	}
//	else
//    {
//        if (self.failedBlock) {
//            self.failedBlock(response.errorMsg);
//        }
//	}
//}


@end
