//
//  SinaWeiboUtility.m
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SinaWeiboUtility.h"
#import "OpenAppKeyDefines.h"

@implementation SinaWeiboUtility

//@synthesize sinaWeibo = _sinaWeibo;

@synthesize completeBlock   = _completeBlock;
@synthesize cancelBlock     = _cancelBlock;
@synthesize failedBlock     = _failedBlock;

+ (SinaWeiboUtility *) sharedInstance
{
    static SinaWeiboUtility *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[SinaWeiboUtility alloc] init];
    }
    return sharedInstance;
}

- (SinaWeiboUtility *)init
{
    if ((self = [super init])) {

//        _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kSinaAppKey appSecret:kSinaAppSecret appRedirectURI:kSinaAppRedirectURI andDelegate:self];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
//        if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
//        {
//            _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
//            _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
//            _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
//        }
    }
    
    return self;
}

- (void) dealloc
{
//    TT_RELEASE_SAFELY(_sinaWeibo);
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
    
//    [_sinaWeibo logIn];
}

- (void) shareImageWithText:(UIImage *)image
                       text:(NSString *)text
                      block:(idRange3Block)completeBlock
                     cancel:(idBlock)cancelBlock
                     failed:(idBlock)failedBlock
{
    self.completeBlock  = completeBlock;
    self.cancelBlock    = cancelBlock;
    self.failedBlock    = failedBlock;
    
//    if (![_sinaWeibo isAuthValid]) {
//        [_sinaWeibo logIn];
//        return;
//    }
    
    [self shareImageWithText:image text:text];
}

- (void) shareImageWithUrl:(NSString *)url
                      text:(NSString *)text
                     block:(idRange3Block)completeBlock
                    cancel:(idBlock)cancelBlock
                    failed:(idBlock)failedBlock
{
    self.completeBlock  = completeBlock;
    self.cancelBlock    = cancelBlock;
    self.failedBlock    = failedBlock;
    
//    if (![_sinaWeibo isAuthValid]) {
//        [_sinaWeibo logIn];
//        return;
//    }
    
    [self shareImageWithUrl:url text:text];
}

- (BOOL) isAuthValid
{
    return NO;
//    return [_sinaWeibo isAuthValid];
}

#pragma mark - Private methods

- (void) shareImageWithText:(UIImage *)image
                       text:(NSString *)text
{
    //[SVProgressHUD showWithStatus:kTipShareImageLoading];
    
    // post image status
//    [_sinaWeibo requestWithURL:@"statuses/upload.json"
//                        params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                text, @"status",
//                                image, @"pic", nil]
//                    httpMethod:@"POST"
//                      delegate:self];
}

- (void) shareImageWithUrl:(NSString *)url
                      text:(NSString *)text
{
    //[SVProgressHUD showWithStatus:kTipShareImageLoading];
    
    // post image status
//    [_sinaWeibo requestWithURL:@"statuses/upload_url_text.json"
//                        params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                text, @"status",
//                                url, @"url", nil]
//                    httpMethod:@"POST"
//                      delegate:self];
}

- (void)storeAuthData
{
//    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
//                              _sinaWeibo.accessToken, @"AccessTokenKey",
//                              _sinaWeibo.expirationDate, @"ExpirationDateKey",
//                              _sinaWeibo.userID, @"UserIDKey",
//                              _sinaWeibo.refreshToken, @"refresh_token", nil];
//    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) logOut
{
//    [_sinaWeibo logOut];
}


#pragma mark - SinaWeibo Delegate
/*
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    DEBUGLOG(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
        
    //[self resetButtons];
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    DEBUGLOG(@"sinaweiboDidLogOut");
    //[self removeAuthData];
    //[self resetButtons];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    DEBUGLOG(@"sinaweiboLogInDidCancel");
    
    if (self.cancelBlock) {
        self.cancelBlock(nil);
    }
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    ERRLOG(@"sinaweibo logInDidFailWithError %@", error);
    
    if (self.failedBlock) {
        self.failedBlock(nil);
    }
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    ERRLOG(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    //[self removeAuthData];
    //[self resetButtons];

    if (self.failedBlock) {
        self.failedBlock(nil);
    }

}
 

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        //[userInfo release], userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        //[statuses release], statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"Post image status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload_url_text.json"])
    {
        NSLog(@"Post image status failed with error : %@", error);
    }
    
    if (self.failedBlock) {
        self.failedBlock(nil);
    }
    
    //[self resetButtons];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSDictionary *userInfo = result;
        DEBUGLOG(@"%@", [userInfo objectForKey:@"name"]);
        DEBUGLOG(@"%@", [userInfo objectForKey:@"avatar_large"]);
        if (self.completeBlock) {
            self.completeBlock(_sinaWeibo.userID, [userInfo objectForKey:@"name"], [userInfo objectForKey:@"avatar_large"]);
        }
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        //[statuses release];
        //statuses = [[result objectForKey:@"statuses"] retain];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        //[postStatusText release], postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        //[SVProgressHUD showSuccessWithStatus:kTipShareImageSuccess];

        if (self.completeBlock) {
            self.completeBlock(nil, nil, nil);
        }
    }
    else if ([request.url hasSuffix:@"statuses/upload_url_text.json"])
    {
        //[SVProgressHUD showSuccessWithStatus:kTipShareImageSuccess];
        
        if (self.completeBlock) {
            self.completeBlock(nil, nil, nil);
        }
    }
    
}

*/
@end
