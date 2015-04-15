//
//  SettingViewController.m
// sejieios
//
//  Created by allen.wang on 1/23/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewController_Private.h"
#import "UIButton+extend.h"
#import "UIImage+extend.h"
#import "UserDefaultsManager.h"
#import "ListUploadImageResponse.h"
#import "ListModifyRequest.h"
#import "UIImageView+(ASI).h"
#import "FrontCoverViewController.h"
#import "FrontCoverImages.h"
#import "SinaWeiboUtility.h"


@implementation SettingViewController
@synthesize topView         = _topView;
@synthesize bgImageView     = _bgImageView;
@synthesize headerImageView = _headerImageView;
@synthesize femaleButton    = _femaleButton;
@synthesize maleButton      = _maleButton;
@synthesize logoutButton    = _logoutButton;
@synthesize setHeaderButton = _setHeaderButton;
@synthesize setBgButton     = _setBgButton;
@synthesize nickLabel       = _nickLabel;
@synthesize pictureImage    = _pictureImage;
@synthesize headerIcon      = _headerIcon;
@synthesize block           = _block;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:kSettingPageString show:NO];
    [self.titleView addSubview:[self leftButton]];
    [self setupContent];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frontCoverChanged:) name:kFontCoverImageDidChangedNotification object:nil];
}

- (void) reduceMemory
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_topView);
    TT_RELEASE_SAFELY(_bgImageView);
    TT_RELEASE_SAFELY(_headerImageView);
    TT_RELEASE_SAFELY(_femaleButton);
    TT_RELEASE_SAFELY(_maleButton);
    TT_RELEASE_SAFELY(_logoutButton);
    TT_RELEASE_SAFELY(_setHeaderButton);
    TT_RELEASE_SAFELY(_setBgButton);
    TT_RELEASE_SAFELY(_nickLabel);
    TT_RELEASE_SAFELY(_pictureImage);
    TT_RELEASE_SAFELY(_headerIcon);
    TT_RELEASE_SAFELY(_block);
    [super reduceMemory];
}

#pragma mark ==
#pragma mark == action

- (void) frontCoverChanged:(NSNotification *)notification
{
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[UserDefaultsManager userCoverIcon]]
                    placeholderImage:[[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:4]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if (!error) {
                                     _bgImageView.image = [image imageWithCornerRadius:4];
                                 }
                             }];
    
}

- (void) configureData
{
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[[FrontCoverImages instance] stringURL]]
                    placeholderImage:[[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:4]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               if (!error) {
                                   _bgImageView.image = [image imageWithCornerRadius:4];
                               }
                           }];
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[UserDefaultsManager userIcon]]
                    placeholderImage:[[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:40]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               if (!error) {
                                   _headerImageView.image = [image imageWithCornerRadius:40];
                               }
                           }];
    _nickLabel.text = [UserDefaultsManager userName];
}

- (void) setupContent
{
    [[self topView] addSubview:[self bgImageView]];
    [[self topView] addSubview:[self headerImageView]];
    [[self topView] addSubview:[self setHeaderButton]];
    [[self topView] addSubview:[self setBgButton]];
    
    [[self topView] addSubview:[self nickLabel]];
    [[self topView] addSubview:[self femaleButton]];
    [[self topView] addSubview:[self maleButton]];
    
    [self.view addSubview:[self topView]];
    [self.view addSubview:[self logoutButton]];
    
    [(0 == [UserDefaultsManager userGender]) ?_maleButton : _femaleButton doExchangeImage];
    
    [self configureData];
}

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) headerTapAction:(UIGestureRecognizer *) recognize
{
    [self headerAction:nil];
}

- (void) backgroundTapAction:(UIGestureRecognizer *) recognize
{
    [self backgroundAction:nil];
}

- (IBAction)headerAction:(id)sender
{
    _type = 1;
    [self showActionSheet];
}

- (IBAction)backgroundAction:(id)sender
{
    _type = 0;
    //    [self showActionSheet];
    
    FrontCoverViewController *controller = [[[FrontCoverViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)sexAction:(id)sender
{
    UIButton *button = (UIButton *) sender;
    NSUInteger type = [UserDefaultsManager userGender];
    
    if (type != (button.tag - 1008)) {
        
        _topView.userInteractionEnabled = NO;
        
        self.block = ^{
            [_maleButton doExchangeImage];
            [_femaleButton doExchangeImage];
            [UserDefaultsManager saveUserGender:(button.tag - 1008)];
            NSNumber *number = [NSNumber numberWithInt:(0 != (button.tag - 1008)) ? 1 : 0];
            [[NSNotificationCenter defaultCenter] postNotificationName:kSeJieSexTypeChangedNotification object:number];
        };
        
        [self modifyInfo];
    }
    
}

- (IBAction)logoutAction:(id)sender
{
    [UserDefaultsManager clearUserId];
    [[SinaWeiboUtility sharedInstance] logOut];
    NSArray *array = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[array objectAtIndex:[array count] - 2] animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutToNormalNotification object:nil];
}

- (void) showActionSheet
{
    UIActionSheet *actionSheet = nil;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[[UIActionSheet alloc] initWithTitle:kChooseFromString
                                                   delegate:self
                                          cancelButtonTitle:kCancelString
                                     destructiveButtonTitle:kChooseFromAlbumsString
                                          otherButtonTitles:nil] autorelease ];
    }
    else
    {
        actionSheet = [[[UIActionSheet alloc] initWithTitle:kChooseFromString
                                                   delegate:self
                                          cancelButtonTitle:kCancelString
                                     destructiveButtonTitle:kChooseFromAlbumsString
                                          otherButtonTitles:kChooseFromCameraString, nil] autorelease ];
    }
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *controller = [[[UIImagePickerController alloc] init] autorelease];
            controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            controller.delegate = self;
            controller.allowsEditing = YES;
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *controller = [[[UIImagePickerController alloc] init] autorelease];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                controller.delegate = self;
                controller.allowsEditing = YES;
                [self presentViewController:controller animated:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

- (void) dealwithImage:(UIImage *) image
{
    if (0 == _type) {
        _bgImageView.image = [image imageWithCornerRadius:4];
    } else {
        [SVProgressHUD showWithStatus:kTipModifyInfoImageLoading];
        [self shareRequest];
    }
}

- (void) modifyInfo
{
    __block SettingViewController *blockSelf = self;
    
    //上传个人信息
    idBlock shareErrorblock = ^(id content) {
        [SVProgressHUD showErrorWithStatus:kTipModifyInfoFailed];
        DEBUGLOG(@"modify info failed  = %@", content);
        _topView.userInteractionEnabled = YES;
    };
    
    ListModifyRequest *modifyRequest = [[[ListModifyRequest alloc] init] autorelease];
    modifyRequest.name      = [UserDefaultsManager userName];
    modifyRequest.userid    = [UserDefaultsManager userId];
    modifyRequest.gender    = kIntToString([UserDefaultsManager userGender]);
    modifyRequest.icon      = (blockSelf.headerIcon) ? (blockSelf.headerIcon) : [UserDefaultsManager userIcon];
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod modifyinfo]
                                     body:[modifyRequest toJsonString]
                                    onSuc:^(id content)
     {
         DEBUGLOG(@"modify info success = %@", content);
         if (blockSelf.block) {
             blockSelf.block();
         }
         [SVProgressHUD showSuccessWithStatus:kTipModifyInfoSuccess];
         _topView.userInteractionEnabled = YES;
     }
                                 onFailed:shareErrorblock
                                  onError:shareErrorblock];
}

- (void) shareRequest
{
    _topView.userInteractionEnabled = NO;
    __block SettingViewController *blockSelf = self;
    //上传图片
    idBlock uploadErrorblock = ^(id content) {
        DEBUGLOG(@"uploadErrorblock = %@", content);
        [SVProgressHUD showErrorWithStatus:kTipModifyInfoFailed];
        _topView.userInteractionEnabled = YES;
    };
    
    [WASBaseServiceFace serviceUploadMethod:[URLMethod uploadpic]
                                       data:UIImageJPEGRepresentation(self.pictureImage,0.3)
                                       body:kEmptyString
                                      onSuc:^(id content)
     {
         DEBUGLOG(@"upload Image success = %@", content);
         ListUploadImageResponse *imageResponse = [[[ListUploadImageResponse alloc] initWithJsonString:content] autorelease];
         blockSelf.headerIcon = imageResponse.pic;
         
         blockSelf.block = ^{
             _headerImageView.image = [_pictureImage imageWithCornerRadius:4];
             [UserDefaultsManager saveUserIcon:blockSelf.headerIcon];
             [[NSNotificationCenter defaultCenter] postNotificationName:kSeJieUserIconChangedNotification object:nil];

         };
         
//         [RecordUtility recordToSelfTarget:imageResponse.pic label:kEmptyString action:eRecordActionIcon];
         [blockSelf modifyInfo];
         
     }
                                   onFailed:uploadErrorblock
                                    onError:uploadErrorblock];
    
}


#pragma mark ==
#pragma mark == image picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    self.pictureImage = image;
    [self performSelector:@selector(dealwithImage:) withObject:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ==
#pragma mark == setter and getter


- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    return leftButton;
}

- (UIView *) topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:kSettingTopViewFrame];
        _topView.backgroundColor = kWhiteColor;
        _topView.layer.borderWidth = 1.0f;
        _topView.layer.cornerRadius = 4.0f;
        _topView.layer.masksToBounds = YES;
        _topView.layer.borderColor = [kWhiteColor CGColor];
    }
    return _topView;
}

- (UIImageView *) bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:kSettingBgFrame];
        _bgImageView.backgroundColor = kClearColor;
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.borderWidth = 1.0f;
        _bgImageView.layer.cornerRadius = 4.0f;
        _bgImageView.layer.borderColor = [kWhiteColor CGColor];
        UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapAction:)] autorelease];
        [_bgImageView addGestureRecognizer:recognizer];
    }
    return _bgImageView;
}

- (UIImageView *) headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:kSettingHeaderFrame];
        _headerImageView.backgroundColor = kWhiteColor;
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.borderWidth = 2.0f;
        _headerImageView.layer.cornerRadius = 40.0f;
        _headerImageView.layer.borderColor = [kWhiteColor CGColor];
        UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapAction:)] autorelease];
        [_headerImageView addGestureRecognizer:recognizer];
    }
    return _headerImageView;
}

- (UIButton *) femaleButton
{
    if (!_femaleButton) {
        _femaleButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _femaleButton.frame = kSettingFemaleFrame;
        _femaleButton.tag = 1009;
        [_femaleButton addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
        [_femaleButton setNormalImage:kSetFemaleImage selectedImage:kSetFemaleSelectImage];
        
    }
    return _femaleButton;
}

- (UIButton *) maleButton
{
    if (!_maleButton) {
        _maleButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _maleButton.frame = kSettingMaleFrame;
        _maleButton.tag = 1008;
        [_maleButton addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
        [_maleButton setNormalImage:kSetMaleImage selectedImage:kSetMaleSelectImage];
    }
    return _maleButton;
}

- (UIButton *) setHeaderButton
{
    if (!_setHeaderButton) {
        _setHeaderButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _setHeaderButton.frame = kSettingSetHeaderFrame;
        [_setHeaderButton addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
        [_setHeaderButton setNormalImage:kSetHeaderImage selectedImage:nil];
    }
    return _setHeaderButton;
}

- (UIButton *) setBgButton
{
    if (!_setBgButton) {
        _setBgButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _setBgButton.frame = kSettingSetBGFrame;
        [_setBgButton addTarget:self action:@selector(backgroundAction:) forControlEvents:UIControlEventTouchUpInside];
        [_setBgButton setNormalImage:kSetCoverImage selectedImage:nil];
    }
    return _setBgButton;
}

- (UIButton *) logoutButton
{
    if (!_logoutButton) {
        _logoutButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _logoutButton.frame = kSettingLogoutFrame;
        [_logoutButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
        [_logoutButton setNormalImage:kSetLogoutImage selectedImage:nil];
    }
    return _logoutButton;
}

- (UILabel *) nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:kSettingNickFrame];
        _nickLabel.backgroundColor = kClearColor;
        _nickLabel.font = TNRFONTSIZE(kFontSize14);
    }
    return _nickLabel;
}

@end
