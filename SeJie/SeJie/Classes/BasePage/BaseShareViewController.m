//
//  BaseShareViewController.m
// sejieios
//
//  Created by Jarry on 13-1-16.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "BaseShareViewController.h"
#import "UIView+extend.h"
#import "UIImage+extend.h"

#define kContentTextLimit   140

@interface BaseShareViewController () < UITextViewDelegate, UIGestureRecognizerDelegate >

@property (nonatomic, retain)   UIButton            *button;

@end

@implementation BaseShareViewController

@synthesize shareImageView  = _shareImageView;
@synthesize scrollView      = _scrollView;
@synthesize shareView       = _shareView;
@synthesize contentTextView = _contentTextView;
@synthesize countButton     = _countButton;
@synthesize button          = _button;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titleView addSubview:self.leftButton];
    
    UIView *bgView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    bgView.backgroundColor = kBlackColor;
    
    _shareImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //[_shareImageView setExtendHeight:44];
    [_shareImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:bgView];
    [self.view addSubview:_shareImageView];
    [self.view sendSubviewToBack:_shareImageView];
    [self.view sendSubviewToBack:bgView];
    
    [self.view addSubview:self.scrollView];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_shareImageView);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_shareView);
    TT_RELEASE_SAFELY(_button);
    TT_RELEASE_SAFELY(_contentTextView);
    TT_RELEASE_SAFELY(_countButton);
    [super reduceMemory];
}

- (void) setShareImage:(UIImage *)image
{
    
    _shareImageView.image = image;//[image imageScaledToWidth:320];
    [_shareImageView setFrameHeight:image.size.height * 320 / image.size.width];
    _shareImageView.center = CGPointMake(160, kBoundsHeight/2 - 10);
    return;
    
    CGSize size = _shareImageView.bounds.size;
    CGFloat height  =  image.size.width * size.height / size.width;
    if (height < image.size.height)
    {
        _shareImageView.image = [image subImageAtRect:CGRectMake(0, 0, image.size.width, height)];
    }
    else
    {
        _shareImageView.image = image;
    }
}

#pragma mark - Setter and getter

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    return leftButton;
}

- (UIScrollView *) scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kScrollViewFrame];
        //[_scrollView setExtendHeight:44];
        
        _scrollView.contentSize = CGSizeMake(_scrollView.width, _scrollView.height+1);
        _scrollView.bounces = YES;
        
        [_scrollView addSubview:self.shareView];
    }
    return _scrollView;
}

- (UIView *) shareView
{
    if (!_shareView) {
        _shareView = [[UIView alloc] initWithFrame:kShareViewFrame];
        [_shareView addBackgroundStretchableImage:@"share_edit_bg" leftCapWidth:30 topCapHeight:50];
        _shareView.alpha = 0.0f;
        
        UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 104, 100, 40)] autorelease];
        textLabel.backgroundColor = kClearColor;
        textLabel.text = @"默认专题";
        textLabel.textColor = kDarkGrayColor;
        textLabel.font = TNRFontSIZEBIG(kFontSize14);
        textLabel.tag = 105;
        [_shareView addSubview:textLabel];
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(220, 104, 54, 40);
        [doneButton setNormalImage:@"share_btn_done" selectedImage:@"share_btn_done_hover"];
        [doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:doneButton];
        
        _contentTextView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(2, 2, kShareViewFrame.size.width-4, 90)];
        _contentTextView.backgroundColor = kClearColor;
        _contentTextView.placeholder = kShareImagePlaceholder;
        _contentTextView.font = SYSTEMFONT(kFontSize14);
        _contentTextView.returnKeyType = UIReturnKeyDone;
        _contentTextView.delegate = self;
        
        [_shareView addSubview:_contentTextView];
        
        [_shareView addSubview:self.countButton];
        
        self.button = doneButton;
    }
    return _shareView;
}

/*- (UILabel *) countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kShareViewFrame.size.width-30, 90, 20, 10)];
        _countLabel.backgroundColor = kClearColor;
        _countLabel.text = @"140";
        _countLabel.textColor = kGrayColor;
        _countLabel.font = TNRFontSIZEBIG(kFontSize11);
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}*/

- (UIButton *) countButton
{
    if (!_countButton) {
        _countButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _countButton.frame = CGRectMake(kShareViewFrame.size.width-44, 82, 39, 18);
        _countButton.titleLabel.font = SYSTEMFONT(kFontSize11);
        [_countButton setTitleColor:kGrayColor forState:UIControlStateNormal];
        [_countButton setTitle:[NSString stringWithFormat:@"%d  ", kContentTextLimit] forState:UIControlStateNormal];
        [_countButton setBackgroundImage:@"share_text_count_bg" selectedImage:nil clickImage:nil];
        [_countButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countButton;
}

#pragma mark - Actions

- (IBAction)leftButtonAction:(id)sender
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender
{
    if ([_contentTextView isFirstResponder]) {
        [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
            [self.shareView setExtendHeight:100];
        }];
        [_contentTextView resignFirstResponder];
    }
    self.button.enabled = NO;
    [self shareRequest];
}

- (IBAction)clearAction:(id)sender
{
    if (_contentTextView.text.length == 0) {
        return;
    }
    UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                 destructiveButtonTitle:@"清除文字"
                                      otherButtonTitles:nil] autorelease ];

    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [_contentTextView setText:@""] ;
        [_countButton setTitle:[NSString stringWithFormat:@"%d  ", kContentTextLimit] forState:UIControlStateNormal];
    }
}

- (void) shareRequest
{
    
}

- (void) enableButton
{
    self.button.enabled = YES;
}

- (NSString *) shareText
{
    NSString *text = self.contentTextView.text;
    if (!text || text.length==0) {
        text = kShareImageDefaultText;
    }
    return [NSString stringWithFormat:@"%@%@", text,kShareImageEndText];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
        [_shareView setExtendHeight:-100];
    }];
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger count = kContentTextLimit-string.length;
    if (count >= 0) {
        //self.countLabel.text = [NSString stringWithFormat:@"%d", count];
        //self.countLabel.textColor = (count==0) ? kRedColor : kGrayColor;
        [_countButton setTitle:[NSString stringWithFormat:@"%ld  ", count] forState:UIControlStateNormal];
        [_countButton setTitleColor:((count==0) ? kRedColor:kGrayColor) forState:UIControlStateNormal];
    }
    if ([string length] > kContentTextLimit)
    {
        textView.text = [string substringToIndex:kContentTextLimit];
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        
        [UIView animateWithDuration:AnimateTime.NORMAL animations:^{
            [_shareView setExtendHeight:100];
        }];
        
        [_contentTextView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - GestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)touchGestureUpdated:(UILongPressGestureRecognizer *)touchGesture
{
    if (touchGesture.state == UIGestureRecognizerStateBegan) {
        
    }
    else if (touchGesture.state == UIGestureRecognizerStateEnded) {
        [_contentTextView resignFirstResponder];
    }
}


@end
