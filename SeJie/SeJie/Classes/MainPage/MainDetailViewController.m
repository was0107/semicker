//
//  MainDetailViewController.m
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "MainDetailViewController.h"
#import "MainDetailViewController_Private.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"
#import "CreateObject.h"
#import "WASBaseServiceFace.h"
#import "ListDetailRequest.h"
#import "ListCommentsRequest.h"
#import "ListCommentsResponse.h"
#import "DetailItemScrollView.h"


@implementation MainDetailViewController
@synthesize keyword       = _keyword;
@synthesize responseItem  = _responseItem;
@synthesize imageURLString= _imageURLString;
@synthesize contents      = _contents;
@synthesize scrollView    = _scrollView;
@synthesize adapter       = _adapter;
@synthesize enableClickUser= _enableClickUser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_DETAIL;
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.scrollView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(8, 8, 40, 38);
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setNormalImage:kDetailBackNormalImage hilighted:kDetailBackSelectImage selectedImage:kDetailBackSelectImage];
    [self.view addSubview:button];
    
    UIButton *buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSave.frame = CGRectMake(272, 8, 40, 38);
    [buttonSave setNormalImage:kDownloadNormalImage selectedImage:kDownloadHilightedImage];
    [buttonSave addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSave];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userShareNotification:) name:kUserShareInfoNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) reduceMemory
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_responseItem);
    TT_RELEASE_SAFELY(_imageURLString);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_contents);
    [super reduceMemory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) userShareNotification:(NSNotification *)notification
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setContents:(NSMutableArray *)contents
{
    if (_contents != contents) {
        [_contents release];
        _contents = [contents retain];
        
        self.scrollView.keyword  = self.keyword;
        self.scrollView.responseItem = self.responseItem;
        self.scrollView.contents = _contents;
    }
}

- (void) setEnableClickUser:(BOOL)enableClickUser
{
    _enableClickUser = enableClickUser;
    self.scrollView.enableClickUser = _enableClickUser;
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(id)sender
{
    [self.scrollView saveImage];
    
    // 图片保存 PV
    [[DataTracker sharedInstance] trackEvent:_adapter.imageSavePV
                                   withLabel:_responseItem.label
                                    category:TD_EVENT_Category];
}

- (DetailScrollView *) scrollView
{
    if (!_scrollView) {
        CGRect rect = self.view.bounds;
        rect.origin.x -= 322;
        rect.size.width = 964;
        _scrollView = [[DetailScrollView alloc] initWithFrame:rect];
        _scrollView.viewController = self;
    }
    return _scrollView;
}

- (void) setAdapter:(SheJieAdapterBase *)adapter
{
    _adapter = adapter;
    self.scrollView.adapter = adapter;
}

@end
