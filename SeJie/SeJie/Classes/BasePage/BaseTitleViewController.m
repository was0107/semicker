//
//  BaseTitleViewController.m
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "SeJieGlobal.h"
#import "CreateObject.h"


@implementation BaseTitleViewController

@synthesize titleView  = _titleView;
@synthesize imageView  = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize leftButton = _leftButton;
@synthesize rightButton= _rightButton;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_titleView);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_leftButton);
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_imageView);
    [super reduceMemory];
}

- (UIView *) titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:kHeaderFrame];
        self.imageView = [CreateObject imageView:kMainHeaderGroundImgage];
        _imageView.frame = CGRectMake(0, 0, 320, 44);
        //    _imageView.alpha = 0.6f;
        [_titleView addSubview:_imageView];
        
        [_titleView addSubview:[self titleLabel]];
    }
    return _titleView;
}

- (UIImageLabel *) titleLabel
{
    if (!_titleLabel) {
        _titleLabel  = [[UIImageLabel alloc] init];
        _titleLabel.frame = kHeaderTitleFrame;
        _titleLabel.font = TNRFontSIZEBIG(kFontSize18);
        _titleLabel.backgroundColor = kClearColor;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.text = self.title;
        
        UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleDidTapped:)] autorelease];
        [_titleLabel addGestureRecognizer:gesture];
    }
    return _titleLabel;
}

- (UIButton *) leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _leftButton.frame = kHeaderLeftFrame;
        [_leftButton setImage:[UIImage imageNamed:kMainLeftIconImage] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:kMainLeftIconHoverImage] forState:UIControlStateHighlighted];
        [_leftButton setImage:[UIImage imageNamed:kMainLeftIconImage] forState:UIControlStateSelected];
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *) rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _rightButton.frame = kHeaderRightFrame;
        [_rightButton setImage:[UIImage imageNamed:kMainSearchIconImage] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:kMainSearchIconHlImage] forState:UIControlStateHighlighted];
        [_rightButton setImage:[UIImage imageNamed:kMainSearchIconSelImage] forState:UIControlStateSelected];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (IBAction)leftButtonAction:(id)sender
{

}

- (IBAction)rightButtonAction:(id)sender
{
    
}

- (void) titleDidTapped:(UIGestureRecognizer *)gesture
{
    
}

@end
