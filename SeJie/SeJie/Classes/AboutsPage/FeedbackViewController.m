//
//  FeedbackViewController.m
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "FeedbackViewController.h"
#import "PlaceHolderTextView.h"
#import "FeedbackRequest.h"
#import "UIButton+extend.h"
#import "UIView+extend.h"
#import "CustomAnimation.h"

#define kFeedbackContentFrame       CGRectMake(8, 75, 304, 100)
#define kFeedbackContactFrame       CGRectMake(8, 185, 304, 35)


@interface FeedbackViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, retain) PlaceHolderTextView   *contentTextView;
@property (nonatomic, retain) UITextField           *contactField;

@end

@implementation FeedbackViewController

@synthesize contentTextView = _contentTextView;
@synthesize contactField = _contactField;

#pragma mark - base

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pageViewId = TD_PAGE_FEEDBACK;

    [[self titleLabel] setText:kTitleFeedbackString];
    [self.titleView addSubview:[self leftButton]];
    [self.titleView addSubview:[self rightButton]];
    
    [self.view addSubview:self.contentTextView];
    
    UIView *contactView = [[[UIView alloc] initWithFrame:kFeedbackContactFrame] autorelease];
    [contactView addBackgroundStretchableImage:kFeedbackContactBgImage leftCapWidth:0 topCapHeight:0];
    [contactView addSubview:self.contactField];
    [self.view addSubview:contactView];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_contentTextView);
    TT_RELEASE_SAFELY(_contactField);
    [super reduceMemory];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_contentTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    
    return leftButton;
}

- (UIButton *) rightButton
{
    UIButton *rightButton = [super rightButton];
    if (rightButton) {
        [rightButton setFrame:kHeaderDoneFrame];
        [rightButton setNormalImage:kMainDoneIconImage selectedImage:kMainDoneSelIconImage];
    }
    
    return rightButton;
}

#pragma mark - Actions

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightButtonAction:(id)sender
{
    [self sendRequestToServer];
}

- (void) sendRequestToServer
{
    if (![self validateInput]) {
        return;
    }
    
    idBlock successedBlock = ^(id content)
    {
        // 提交成功
        [SVProgressHUD showSuccessWithStatus:kTipFeedbackCommitSuccString];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    idBlock failedBlock = ^(id content)
    {
        [SVProgressHUD showErrorWithStatus:kTipFeedbackFaildString];
    };
    
    FeedbackRequest *request = [[[FeedbackRequest alloc] init] autorelease];
    request.comment = _contentTextView.text;
    request.contact = _contactField.text;
    [WASBaseServiceFace serviceWithMethod:[URLMethod feedback]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
    
}

- (BOOL) validateInput
{
    if (!self.contentTextView.text || self.contentTextView.text.length == 0) {
        [CustomAnimation shakeAnimation:self.contentTextView duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    return YES;
}

#pragma mark - init

- (PlaceHolderTextView *) contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[PlaceHolderTextView alloc] initWithFrame:kFeedbackContentFrame];
        _contentTextView.placeholder = kFeedbackStringPlaceholder;
        _contentTextView.font = SYSTEMFONT(kFontSize13);
        _contentTextView.returnKeyType = UIReturnKeyNext;
        _contentTextView.layer.borderColor = kLightGrayColor.CGColor;
        _contentTextView.layer.borderWidth = 1.0;
        _contentTextView.layer.cornerRadius = 5.0;
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}

- (UITextField *) contactField
{
    if (!_contactField) {
        CGRect frame = CGRectMake(8, 0, kFeedbackContactFrame.size.width-10, kFeedbackContactFrame.size.height);
        _contactField = [[UITextField alloc] initWithFrame:frame];
        _contactField.placeholder = kFeedbackStringContact;
        _contactField.borderStyle = UITextBorderStyleNone;
        _contactField.autocorrectionType = UITextAutocorrectionTypeNo;
        _contactField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _contactField.font = SYSTEMFONT(kFontSize13);
        _contactField.returnKeyType = UIReturnKeyDone;
        _contactField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _contactField.backgroundColor = kClearColor;
        _contactField.text = @"";
        _contactField.delegate = self;
    }
    return _contactField;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendRequestToServer];
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_contactField becomeFirstResponder];
        return NO;
    }
    return YES; 
}

@end
