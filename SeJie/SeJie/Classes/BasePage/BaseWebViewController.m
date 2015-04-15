//
//  BaseWebViewController.m
// sejieios
//
//  Created by allen.wang on 1/14/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseWebViewController.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"

@interface BaseWebViewController(private)<UIWebViewDelegate ,UIActionSheetDelegate>
@end


@implementation BaseWebViewController
@synthesize mainWebView = _mainWebView;
@synthesize activityView= _activityView;
@synthesize requestURL  = _requestURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleView addSubview:self.leftButton];
    [self.view addSubview:self.mainWebView];
    [self.view addSubview:self.activityView];
    [self.view sendSubviewToBack:self.mainWebView];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mainWebView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) reduceMemory
{
    _mainWebView.delegate = nil;
    [_activityView stopAnimating];
    TT_RELEASE_SAFELY(_mainWebView);
    TT_RELEASE_SAFELY(_activityView);
    TT_RELEASE_SAFELY(_requestURL);
    [super reduceMemory];
}

- (void) setRequestURL:(NSString *)requestURL
{
    if (_requestURL != requestURL) {
        [_requestURL release];
        _requestURL = [requestURL copy];
        if (_requestURL) {
            [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_requestURL]]];
        }
    }
}

- (CGRect) webViewFrame
{
    return CGRectMake(0,44,320,kContentBoundsHeight + 20);
}

- (UIWebView *) mainWebView
{
    if (!_mainWebView) {
        _mainWebView = [[UIWebView alloc] initWithFrame:[self webViewFrame]];
        _mainWebView.backgroundColor = [UIColor clearColor];
        _mainWebView.scalesPageToFit = YES;
        _mainWebView.delegate = self;
        _mainWebView.opaque = NO;
    }
    return _mainWebView;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.center = self.mainWebView.center;
        _activityView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    }
    return _activityView;
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

#pragma mark -- 
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.activityView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.activityView stopAnimating];
}

@end



#pragma mark --
#pragma mark - BaseWebToolViewController

@implementation BaseWebToolViewController
@synthesize toolBar             = _toolBar;
@synthesize backBarButtonItem   = _backBarButtonItem;
@synthesize forwardBarButtonItem= _forwardBarButtonItem;
@synthesize refreshBarButtonItem= _refreshBarButtonItem;
@synthesize stopBarButtonItem   = _stopBarButtonItem;
//@synthesize actionBarButtonItem = _actionBarButtonItem;
@synthesize availableActions    = _availableActions;

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_toolBar);
    TT_RELEASE_SAFELY(_backBarButtonItem);
    TT_RELEASE_SAFELY(_forwardBarButtonItem);
    TT_RELEASE_SAFELY(_refreshBarButtonItem);
    TT_RELEASE_SAFELY(_stopBarButtonItem);
//    TT_RELEASE_SAFELY(_actionBarButtonItem);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.toolBar];
    [self updateToolbarItems];
}

- (CGRect) webViewFrame
{
    CGRect rect = kContentWithBarFrame;
    rect.size.height -= 38;
    return rect;
}

#pragma mark --
#pragma mark - setters and getters

- (UIToolbar *) toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:kToolBarFrame];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
            UIImage *toolBarIMG = [UIImage imageNamed:kDefaultTopbarImage];
            if ([_toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
                [_toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
            }
        }
        else {
            [_toolBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:kDefaultTopbarImage]] autorelease] atIndex:0];
        }
    }
    return _toolBar;
}

- (UIBarButtonItem *)backBarButtonItem {
    
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-back"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(goBackClicked:)];
        _backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		_backBarButtonItem.width = 25.0f;
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!_forwardBarButtonItem) {
        _forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-pre"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(goForwardClicked:)];
        _forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		_forwardBarButtonItem.width = 25.0f;
    }
    return _forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!_refreshBarButtonItem) {
        _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-refresh"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(reloadClicked:)];
        _refreshBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
        _refreshBarButtonItem.width = 25.0f;
    }
    return _refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    
    if (!_stopBarButtonItem) {
        _stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                           target:self
                                                                           action:@selector(stopClicked:)];
    }
    return _stopBarButtonItem;
}

/*
- (UIBarButtonItem *)actionBarButtonItem {
    
    if (!_actionBarButtonItem) {
        _actionBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-share"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(actionButtonClicked:)];
    }
    return _actionBarButtonItem;
}*/

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark --
#pragma mark -- actions

- (void)goBackClicked:(UIBarButtonItem *)sender {
    if ([self.mainWebView canGoBack]) {
        [self.mainWebView goBack];
    }
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    if ([self.mainWebView canGoForward]) {
        [self.mainWebView goForward];
    }
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [self.mainWebView reload];
}

- (void)stopClicked:(UIBarButtonItem *)sender {
    
    [self.mainWebView stopLoading];
	[self updateToolbarItems];
}

- (void)actionButtonClicked:(id)sender
{
    UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                  initWithTitle:@"分享"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil] autorelease];
    [actionSheet showInView:self.view];
}

- (void) enableButtonItems
{
    self.backBarButtonItem.enabled      = self.mainWebView.canGoBack;
    self.forwardBarButtonItem.enabled   = self.mainWebView.canGoForward;
//    self.actionBarButtonItem.enabled    = NO;//eWepActionsNone != self.availableActions;
}

- (void)updateToolbarItems
{
    [self enableButtonItems];
    
    UIBarButtonItem *refreshStopBarButtonItem = self.mainWebView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                 target:nil
                                                                                 action:nil] autorelease];
    fixedSpace.width = 50.0f;
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil] autorelease];
    
    if(eWepActionsNone == self.availableActions)
    {
        self.toolBar.items = [NSArray arrayWithObjects:
                              flexibleSpace,
                              self.backBarButtonItem,
                              flexibleSpace,
                              self.forwardBarButtonItem,
                              flexibleSpace,
                              refreshStopBarButtonItem,
                              flexibleSpace,
                              nil];
    }
    else
    {
        self.toolBar.items = [NSArray arrayWithObjects:
                              fixedSpace,
                              self.backBarButtonItem,
                              fixedSpace,
                              self.forwardBarButtonItem,
                              fixedSpace,
                              refreshStopBarButtonItem,
                              fixedSpace,
                              nil];
    }
    [self.view bringSubviewToFront:self.toolBar];
}

#pragma mark --
#pragma mark -- reconstructs

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [super webViewDidStartLoad:webView];
    [self updateToolbarItems];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self updateToolbarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
    [self updateToolbarItems];
}



@end