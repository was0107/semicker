//
//  CommodityDetailViewController.m
// sejieios
//
//  Created by allen.wang on 1/14/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "CommodityDetailViewController_Private.h"
#import "NSURL+Extend.h"
#import "NSString+URLEncoding.h"

@implementation CommodityDetailViewController
@synthesize docID       = _docID;
@synthesize brandName   = _brandName;
@synthesize type        = _type;
@synthesize goodItem    = _goodItem;
@synthesize cpsEvent    = _cpsEvent;

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_docID);
    TT_RELEASE_SAFELY(_brandName);
    TT_RELEASE_SAFELY(_goodItem);
    TT_RELEASE_SAFELY(_cpsEvent);
    [super reduceMemory];
}

- (id) initWithDocID:(NSString *) theDocID
{
    return [self initWithDocID:theDocID withType:eContentCommodityType];
}

- (id) initWithDocID:(NSString *) theDocID withType:(int) theType
{
    self = [super init];
    if (self) {
        self.type  = theType;
        self.docID = theDocID;
    }
    return self;
}

- (id) initWithGoodsItem:(ListGoodsItem *)item
{
    self = [super init];
    if (self) {
        self.goodItem = item;
        self.type  = [item.type isEqualToString:@"tuan"] ? 1 : 0;
        self.docID = item.docid;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewId = TD_PAGE_DETAIL_COMMODITY;

    self.titleLabel.text = kGoodsDetailTitleString;
    self.availableActions = eWebActionsWeiBo;
}

#pragma mark --
#pragma mark setter and getter

- (void) setDocID:(NSString *)docID
{
    if (_docID != docID) {
        [_docID release];
        _docID = [docID copy];
        
        if (_docID && _docID.length) {
            self.requestURL = (eContentCommodityType == self.type) ? kGoodsWapURL(_docID) : kTuanWapURL(_docID);
            DEBUGLOG(@"url = %@", self.requestURL);
        }
        [self updateToolbarItems];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (!self.brandName)
    {
        NSString *title = [[request.URL valueWithKey:kWapParameterSupplier] URLDecodedString];
        if (title.length) {
            self.brandName =  title;
        }
    }
    
    NSString *b5mGa = [[request.URL valueWithKey:@"b5mga"] URLDecodedString];
    if (b5mGa.length > 0) {
        //
        [[DataTracker sharedInstance] trackEvent:self.cpsEvent
                                       withLabel:[NSString stringWithFormat:@"%@:%@",_goodItem.source, _goodItem.title]
                                        category:TD_EVENT_Category];
    }
    
    return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void) enableButtonItems
{
    [super enableButtonItems];
    self.titleLabel.text = (!self.backBarButtonItem.enabled && self.forwardBarButtonItem.enabled) ?
    kGoodsDetailTitleString : (self.brandName ? self.brandName : kGoodsDetailTitleString);
}
@end
