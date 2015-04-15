//
//  BaseWebViewController.h
// sejieios
//
//  Created by allen.wang on 1/14/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseTitleViewController.h"

@interface BaseWebViewController : BaseTitleViewController
@property (nonatomic, retain, readonly) UIWebView       *mainWebView;
@property (nonatomic, retain, readonly) UIActivityIndicatorView  *activityView;
@property (nonatomic, copy) NSString *requestURL;

- (void) webViewDidStartLoad:(UIWebView *)webView;
- (void) webViewDidFinishLoad:(UIWebView *)webView;
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end


#pragma mark --
#pragma mark - BaseWebToolViewController

@interface BaseWebToolViewController : BaseWebViewController
@property (nonatomic, retain, readonly) UIToolbar       *toolBar;
@property (nonatomic, retain, readonly) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, retain, readonly) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, retain, readonly) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, retain, readonly) UIBarButtonItem *stopBarButtonItem;
//@property (nonatomic, retain, readonly) UIBarButtonItem *actionBarButtonItem;
@property (nonatomic, readwrite) eWebActions availableActions;

- (void) enableButtonItems;

- (void) updateToolbarItems;

- (void) goBackClicked:(UIBarButtonItem *)sender;

- (void) goForwardClicked:(UIBarButtonItem *)sender;

- (void) reloadClicked:(UIBarButtonItem *)sender;

- (void) stopClicked:(UIBarButtonItem *)sender;

- (void) actionButtonClicked:(id)sender;

@end