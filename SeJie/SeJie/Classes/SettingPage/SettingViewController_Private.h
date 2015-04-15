//
//  SettingViewController_Private.h
// sejieios
//
//  Created by allen.wang on 1/23/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSUInteger _type;
}

@property (nonatomic, retain) UIView      *topView;
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *headerImageView;


@property (nonatomic, retain) UIImage     *pictureImage;
@property (nonatomic, copy)   NSString    *headerIcon;

@property (nonatomic, retain) UIButton    *femaleButton;
@property (nonatomic, retain) UIButton    *maleButton;
@property (nonatomic, retain) UIButton    *logoutButton;
@property (nonatomic, retain) UIButton    *setHeaderButton;
@property (nonatomic, retain) UIButton    *setBgButton;
@property (nonatomic, retain) UILabel     *nickLabel;


@property (nonatomic, copy)   voidBlock   block;

@end
