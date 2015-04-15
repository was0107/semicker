//
//  SplashViewController.m
// sejieios
//
//  Created by allen.wang on 1/10/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SplashViewController.h"
#import "UIButton+extend.h"
#import "UserDefaultsManager.h"
#import "CreateObject.h"


//sex_choose_top@2x.png
//sex_choose_top_drop@2x.png
//sex_choose_bot@2x.png
//sex_choose_mid@2x.png
//sex_choose_selected_female@2x.png
//sex_choose_female@2x.png
//sex_choose_selected_male@2x.png
//sex_choose_male@2x.png

@implementation SplashViewController
@synthesize block = _block;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (UILabel *) bottomLabel
{
    UILabel *label = [CreateObject titleLabel];
    
    
    return label;
}

- (void) setUpContent
{
    UIImageView *imageViewTop = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sex_choose_top"]] autorelease ];
    UIImageView *imageViewMid = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sex_choose_mid"]] autorelease ];
    UIImageView *imageViewBot = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sex_choose_bot"]] autorelease ];
    
    UILabel *headerLabel      = [CreateObject titleLabel];
    headerLabel.font          = TNRFontSIZEBIG(kFontSize18);
    headerLabel.textColor     = kWhiteColor;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text          = @"选择您的身份，看不一样的色界";
    headerLabel.frame         = CGRectMake(0, 110+kHeightIncrease/2, 320, 50);
    
    UILabel *maleLabel        = [self bottomLabel];
    maleLabel.textColor       = kDarkGrayColor;
    maleLabel.textAlignment   = NSTextAlignmentCenter;
    maleLabel.frame           = CGRectMake(50, 268+kHeightIncrease/2, 100, 30);
    maleLabel.text            = @"高帅富戳此";
    UILabel *femaleLabel      = [self bottomLabel];
    femaleLabel.textColor     = kDarkGrayColor;
    femaleLabel.textAlignment = NSTextAlignmentCenter;
    femaleLabel.frame         = CGRectMake(170, 268+kHeightIncrease/2, 100, 30);
    femaleLabel.text          = @"白富美点这";
    
    UIButton *buttonMale      = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *buttonFemale    = [UIButton buttonWithType:UIButtonTypeCustom];
    
    imageViewTop.frame = CGRectMake(0, 0, 320, 204+kHeightIncrease/2);
    imageViewMid.frame = CGRectMake(0, 184+kHeightIncrease/2, 320, 120);
    imageViewBot.frame = CGRectMake(0, 304+kHeightIncrease/2, 320, 176+kHeightIncrease/2);
    buttonMale.frame   = CGRectMake(70, 205+kHeightIncrease/2, 60, 60);
    buttonFemale.frame = CGRectMake(190, 205+kHeightIncrease/2, 60, 60);
    
    [buttonMale setNormalImage:@"sex_choose_male"  selectedImage:@"sex_choose_selected_male"];
    [buttonFemale setNormalImage:@"sex_choose_female"  selectedImage:@"sex_choose_selected_female"];
    
    [self.view addSubview:imageViewBot];
    [self.view addSubview:imageViewMid];
    [self.view addSubview:imageViewTop];
    [self.view addSubview:buttonMale];
    [self.view addSubview:buttonFemale];
    
    [self.view addSubview:headerLabel];
    [self.view addSubview:maleLabel];
    [self.view addSubview:femaleLabel];
    
    [buttonMale addTarget:self action:@selector(maleAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonFemale addTarget:self action:@selector(femaleAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) lunch:(int) type
{
    [UserDefaultsManager saveUserGender:type];
    if (self.block) {
        self.block();
    } else {
        NSNumber *number = [NSNumber numberWithInt:(0 != type) ? 1 : 0];
        [[NSNotificationCenter defaultCenter] postNotificationName:kSeJieSexTypeChangedNotification object:number];
    }
}

- (IBAction)maleAction:(id)sender
{
    [self lunch:0];
}

- (IBAction)femaleAction:(id)sender
{
    [self lunch:1];
}

@end
