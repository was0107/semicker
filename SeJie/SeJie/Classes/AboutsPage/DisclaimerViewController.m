//
//  DisclaimerViewController.m
// sejieios
//
//  Created by Jarry on 13-1-21.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "DisclaimRequest.h"
#import "UIView+extend.h"
#import "SBJSON.h"

@interface DisclaimerViewController ()

@property   (nonatomic, retain)     UITextView  *contentTextView;

@end

@implementation DisclaimerViewController

@synthesize contentTextView     = _contentTextView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pageViewId = TD_PAGE_DISCLAIMER;
    
    [[self titleLabel] setText:kTitleDisclaimerString];
    [self.titleView addSubview:[self leftButton]];
    
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    [scrollView setExtendHeight:64];
    scrollView.contentSize = CGSizeMake(scrollView.width, scrollView.height+1);
    scrollView.bounces = YES;
    [scrollView addSubview:self.contentTextView];
    [self.view addSubview:scrollView];
    
    [self sendRequestToServer];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_contentTextView);
    [super reduceMemory];
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

#pragma mark - Actions

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITextView *) contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
        //[_contentTextView setFrameHeight:self.view.height-44];
        _contentTextView.backgroundColor = kClearColor;
        _contentTextView.editable = NO;
        _contentTextView.font = SYSTEMFONT(kFontSize14);
        _contentTextView.text = @"免责声明\n\n总则\n\n用户在接受色界（sejie.b5m.com）服务之前，请务必仔细阅读本声明，用户直接或通过各类方式直接或间接使用色界服务和数据的行为，都将被视作已无条件接受本声明所涉全部内容；若用户对本声明的任何条款有异议，请停止使用色界所提供的全部服务。";
    }
    return _contentTextView;
}

- (void) sendRequestToServer
{
    idBlock successedBlock = ^(id content)
    {
        //DEBUGLOG(@"content = %@", content);
        //
        SBJSON *json = [[[SBJSON alloc]init] autorelease];
        NSDictionary *dictionary = [json fragmentWithString:content error:nil];
        self.contentTextView.text = [dictionary objectForKey:@"disclaim"];
        
    };
    
    idBlock failedBlock = ^(id content)
    {
        //[SVProgressHUD showErrorWithStatus:kTipFeedbackFaildString];
    };
    
    DisclaimRequest *request = [[[DisclaimRequest alloc] init] autorelease];
    [WASBaseServiceFace serviceWithMethod:[URLMethod disclaim]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}


@end
