//
//  FilterBottomView.m
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "FilterBottomView.h"
#import "UIColor+extend.h"
#import "UserDefaultsManager.h"
#import "UIButton+WebCache.h"
#import "UIButton+extend.h"
#import "UIImage+extend.h"

@implementation FilterBottomView

@synthesize voiceButton     = _voiceButton;
@synthesize infoButton      = _infoButton;
@synthesize manButton       = _manButton;
@synthesize womanButton     = _womanButton;
@synthesize downloadButton  = _downloadButton;
@synthesize searchView      = _searchView;
@synthesize block           = _block;
@synthesize segmentControl  = _segmentControl;
@synthesize accountButton   = _accountButton;
@synthesize accountTextBtn  = _accountTextBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        [self addSubview:self.searchView];
        [self addSubview:self.voiceButton];
        [self addSubview:self.infoButton];
        [self addSubview:self.accountButton];
        [self addSubview:self.accountTextBtn];
//        [self addSubview:self.downloadButton];
//        [self addSubview:self.manButton];
//        [self addSubview:self.womanButton];
        self.backgroundColor = [UIColor getColor:@"e6e6e6"];
        
//        NSUInteger type = [UserDefaultsManager userGender];
//        [(0 == type) ?_manButton : _womanButton doExchangeImage];
    }
    return self;
}

- (UIButton *) infoButton
{
    if (!_infoButton) {
        _infoButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _infoButton.frame = CGRectMake(kFilterViewWidth-46, 53, 44, 44);
        [_infoButton setNormalImage:kFilterAboutImage hilighted:kFilterAboutSelectImage selectedImage:kFilterAboutSelectImage];

        _infoButton.backgroundColor = kClearColor;
        [_infoButton addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _infoButton;
}

- (UIButton *) downloadButton
{
    if (!_downloadButton) {
        _downloadButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _downloadButton.frame = CGRectMake(0, 50, 44, 44);
        _downloadButton.hidden = YES;
    }
    return _downloadButton;
}

- (UIButton *) voiceButton
{
    if (!_voiceButton) {
        _voiceButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _voiceButton.frame = CGRectMake(kFilterViewWidth-46, 3, 44, 44);
        [_voiceButton setNormalImage:kFilterVoiceImage selectedImage:nil];
        _voiceButton.backgroundColor = kClearColor;
        [_voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (FilterTopViewItem *) searchView
{
    if (!_searchView) {
        _searchView = [[FilterTopViewItem alloc] initWithFrame:CGRectMake(0, 0, kFilterViewWidth, 50)];
        [_searchView setNormalImage:kFilterSearchImg hilighted:kFilterSearchHilighted selectedImage:kFilterSearchSelectedImg];
        [_searchView addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchView;
}

- (UIButton *) manButton
{
    if (!_manButton) {
        _manButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _manButton.frame = CGRectMake(kFilterViewWidth-90, 60, 40, 30);
        [_manButton setNormalImage:kMaleButtonNormalImage hilighted:kMaleButtonHilightedImage selectedImage:kMaleButtonSelectedImage];
        _manButton.backgroundColor = kClearColor;
        _manButton.tag = 1008;
        [_manButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _manButton;
}

- (UIButton *) womanButton
{
    if (!_womanButton) {
        _womanButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _womanButton.frame = CGRectMake(kFilterViewWidth-50, 60, 40, 30);
        [_womanButton setNormalImage:kFemaleButtonNormalImage hilighted:kFemaleButtonHilightedImage selectedImage:kFemaleButtonSelectedImage];
        _womanButton.backgroundColor = kClearColor;
        _womanButton.tag = 1009;
        [_womanButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _womanButton;
}


- (IBAction)sexButtonAction:(id)sender
{
    UIButton *button = (UIButton *) sender;
    NSUInteger type = [UserDefaultsManager userGender];
    
    if (type != (button.tag - 1008)) {
        [_manButton doExchangeImage];
        [_womanButton doExchangeImage];
        [UserDefaultsManager saveUserGender:(button.tag - 1008)];
        NSNumber *number = [NSNumber numberWithInt:(0 != (button.tag - 1008)) ? 1 : 0];
        [[NSNotificationCenter defaultCenter] postNotificationName:kSeJieSexTypeChangedNotification object:number];
        [SVProgressHUD showSuccessWithStatus:(0 == (button.tag - 1008)) ? kChangedToMaleString : kChangedToFemaleString];
    }
}

- (UIButton *) accountButton
{
    if (!_accountButton) {
        _accountButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _accountButton.frame = CGRectMake(10, 58, 34, 34);
        [_accountButton setNormalImage:kUserIconMaleImage hilighted:nil selectedImage:nil];
        _accountButton.backgroundColor = kClearColor;
        [_accountButton addTarget:self action:@selector(accountAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountButton;
}

- (UIButton *) accountTextBtn
{
    if (!_accountTextBtn) {
//        _accountLabel = [[[UILabel alloc] initWithFrame:CGRectMake(52, 53, 100, 44)] autorelease];
//        _accountLabel.backgroundColor = kClearColor;
//        _accountLabel.text = @"登录";
//        _accountLabel.textColor = kDarkGrayColor;
//        _accountLabel.font = TNRFontSIZEBIG(kFontSize16);
        _accountTextBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _accountTextBtn.frame = CGRectMake(52, 53, 100, 44);
        _accountTextBtn.backgroundColor = kClearColor;
        _accountTextBtn.titleLabel.font = TNRFontSIZEBIG(kFontSize15);
        [_accountTextBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_accountTextBtn setTitleColor:kOrangeColor forState:UIControlStateNormal];
        [_accountTextBtn addTarget:self action:@selector(accountAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountTextBtn;
}

- (IBAction)voiceAction:(id)sender
{
    if (self.block) {
        self.block(eSheJieVoice , nil);
    }
}

- (IBAction)infoAction:(id)sender
{
    if (self.block) {
        self.block(eSheJieAbout , nil);
    }
}

- (IBAction)accountAction:(id)sender
{
//    if (self.isLogout) {
//        [UserDefaultsManager clearUserId];
//        
//        if (self.block) {
//            self.block(eSheJieNormal , nil);
//        }
//        return;
//    }
    
    if (self.block) {
        self.block(eSheJieUserCenter , nil);
    }
}

- (IBAction)action:(id)sender
{
    if (self.block) {
        self.block(eSheJieSearch , nil);
    }
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_block);
    TT_RELEASE_SAFELY(_voiceButton);
    TT_RELEASE_SAFELY(_infoButton);
    TT_RELEASE_SAFELY(_downloadButton);
    TT_RELEASE_SAFELY(_searchView);
    TT_RELEASE_SAFELY(_segmentControl);
    TT_RELEASE_SAFELY(_accountButton);
    TT_RELEASE_SAFELY(_accountTextBtn);
    [super dealloc];
}

- (void) updateAccount
{
    NSString *userName = [UserDefaultsManager userName];
    NSString *userId = [UserDefaultsManager userId];
    if (userId.length > 0) {
        [_accountTextBtn setTitle:userName forState:UIControlStateNormal];
        [_accountTextBtn setTitleColor:kOrangeColor forState:UIControlStateNormal];
        [_accountTextBtn setTitleColor:kWhiteColor forState:UIControlStateHighlighted];
        
        NSInteger gender = [UserDefaultsManager userGender];
        NSString *placeIcon = (gender==eGenderFemale) ? kUserIconFemaleImage : kUserIconMaleImage;
         NSString *icon = [UserDefaultsManager userIcon];
        
        [_accountButton sd_setImageWithURL:[NSURL URLWithString:icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeIcon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                UIImage *theImage = [[image imageScaledToWidth:80] imageWithCornerRadius:10];
                [_accountButton setNormalImageEx:theImage selectedImageEx:theImage];
            }
        }];
//        [_accountButton setImageWithURL:[NSURL URLWithString:icon]
//                       placeholderImage:[UIImage imageNamed:placeIcon]
//                                success:^(UIImage *image)
//        {
//            UIImage *theImage = [[image imageScaledToWidth:80] imageWithCornerRadius:10];
//            [_accountButton setNormalImageEx:theImage selectedImageEx:theImage];
//        }
//                                failure:nil];
    }
    else {
        [_accountTextBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_accountTextBtn setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
        [_accountTextBtn setTitleColor:kOrangeColor forState:UIControlStateHighlighted];
        
        NSInteger gender = [UserDefaultsManager userGender];
        NSString *icon = (gender==eGenderFemale) ? kUserIconFemaleImage : kUserIconMaleImage;
        [_accountButton setNormalImage:icon hilighted:icon selectedImage:icon];
    }
}

@end
