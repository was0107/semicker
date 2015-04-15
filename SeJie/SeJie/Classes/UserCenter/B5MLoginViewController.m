//
//  B5MLoginViewController.m
// sejieios
//
//  Created by Jarry on 13-1-16.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "B5MLoginViewController.h"
#import "UIView+extend.h"
#import "CustomAnimation.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "UserDefaultsManager.h"
#import "MainViewController.h"

#define kUserNameInputFrame       CGRectMake(13, 76, 294, 36)
#define kPassWordInputFrame       CGRectMake(13, 124, 294, 36)
#define kLoginButtonFrame         CGRectMake(13, 172, 294, 33)

@interface B5MLoginViewController () <UITextFieldDelegate>

@property (nonatomic, retain)   UITextField   *userNameField;
@property (nonatomic, retain)   UITextField   *passWordField;
@property (nonatomic, retain)   UIButton      *loginButton;

@end

@implementation B5MLoginViewController

@synthesize userNameField = _userNameField;
@synthesize passWordField = _passWordField;
@synthesize loginButton   = _loginButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_LOGIN_B5M;

    [self.titleView addSubview:self.leftButton];
    [[self titleLabel] setText:kTitleLoginB5MString];
    
    //
    UIImageView *bgImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kUserLoginBgImage]] autorelease];
    [self.view addFillSubView:bgImage];
    [self.view sendSubviewToBack:bgImage];
    
    UIView *userNameView = [[[UIView alloc] initWithFrame:kUserNameInputFrame] autorelease];
    [userNameView addBackgroundStretchableImage:kUserLoginInputBgImage leftCapWidth:0 topCapHeight:0];
    [userNameView addSubview:self.userNameField];
    [userNameView setTag:1];
    [self.view addSubview:userNameView];
    
    UIView *passWordView = [[[UIView alloc] initWithFrame:kPassWordInputFrame] autorelease];
    [passWordView addBackgroundStretchableImage:kUserLoginInputBgImage leftCapWidth:0 topCapHeight:0];
    [passWordView addSubview:self.passWordField];
    [passWordView setTag:2];
    [self.view addSubview:passWordView];
    
    [self.view addSubview:self.loginButton];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_userNameField);
    TT_RELEASE_SAFELY(_passWordField);
    TT_RELEASE_SAFELY(_loginButton);
    [super reduceMemory];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_userNameField becomeFirstResponder];
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


- (UITextField *) userNameField
{
    if (!_userNameField) {
        CGRect frame = CGRectMake(8, 0, kUserNameInputFrame.size.width-10, kUserNameInputFrame.size.height);
        _userNameField = [[UITextField alloc] initWithFrame:frame];
        _userNameField.placeholder = @"用户名/邮箱";
        _userNameField.borderStyle = UITextBorderStyleNone;
        _userNameField.autocorrectionType = UITextAutocorrectionTypeNo;
        _userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userNameField.font = SYSTEMFONT(kFontSize14);
        _userNameField.returnKeyType = UIReturnKeyNext;
        _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameField.backgroundColor = kClearColor;
        _userNameField.text = @"";
        _userNameField.delegate = self;
    }
    return _userNameField;
}

- (UITextField *) passWordField
{
    if (!_passWordField) {
        CGRect frame = CGRectMake(8, 0, kPassWordInputFrame.size.width-10, kPassWordInputFrame.size.height);
        _passWordField = [[UITextField alloc] initWithFrame:frame];
        _passWordField.placeholder = @"密 码";
        _passWordField.secureTextEntry = YES;
        _passWordField.borderStyle = UITextBorderStyleNone;
        _passWordField.autocorrectionType = UITextAutocorrectionTypeNo;
        _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passWordField.font = SYSTEMFONT(kFontSize14);
        _passWordField.returnKeyType = UIReturnKeyDone;
        _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordField.backgroundColor = kClearColor;
        _passWordField.text = @"";
        _passWordField.delegate = self;
    }
    return _passWordField;
}

- (UIButton *) loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _loginButton.frame = kLoginButtonFrame;
        [_loginButton setNormalImage:kUserLoginBtnImage hilighted:kUserLoginBtnHlImage selectedImage:kUserLoginBtnHlImage];
        [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (IBAction)loginAction:(id)sender
{
    _loginButton.enabled = NO;
    [self sendRequestToServer];
}

- (void) sendRequestToServer
{
    if (![self validateInput]) {
        return;
    }
    
    __block B5MLoginViewController *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        // 登录成功
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        DEBUGLOG(@"response = %@", response);

        [UserDefaultsManager saveUserId:response.userInfo.userid];
        [UserDefaultsManager saveUserName:response.userInfo.username];
        [UserDefaultsManager saveUserType:@"a"];

        UIViewController *popToController = nil;
        for (UIViewController *controller in [self.navigationController viewControllers]) {
            if ([controller isKindOfClass:[MainViewController class]]) {
                 popToController = controller;
            }
        }
        if (popToController) {
            [blockSelf.navigationController popToViewController:popToController animated:YES];
        } else {
            [blockSelf.navigationController popViewControllerAnimated:YES];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kCustomShareInfoNotification object:nil];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
        _loginButton.enabled = YES;
    };
    
    LoginRequest *request = [[[LoginRequest alloc] init] autorelease];
    request.username = _userNameField.text;
    request.password = _passWordField.text;
    [WASBaseServiceFace serviceWithMethod:[URLMethod login]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (BOOL) validateInput
{
    if (!_userNameField.text || _userNameField.text.length == 0) {
        [CustomAnimation shakeAnimation:[self.view viewWithTag:1] duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    if (!_passWordField.text || _passWordField.text.length == 0) {
        [CustomAnimation shakeAnimation:[self.view viewWithTag:2] duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameField) {
        [_passWordField becomeFirstResponder];
    }
    
    if (textField == _passWordField) {
        [self sendRequestToServer];
    }
    
    return YES;
}

@end
