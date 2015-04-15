//
//  WASScrollViewDecorate.m
//  TestTableView
//
//  Created by allen.wang on 9/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASScrollViewDecorate.h"

#pragma mark -- WASScrollViewDecorate

@interface WASScrollViewDecorate() 
{
    BOOL            _isFooterInAction;
    BOOL            _waitUntilEndDragging;
    CGRect          headerFrame;
    CGRect          footerFrame;
    UILabel         *_msgLabel;
}
@property (nonatomic, retain) WASRefreshTableHeader *headerView;
@property (nonatomic, retain) WASRefreshTableHeader *footerView;

- (void)flashMessage:(NSString *)msg;

@end

@implementation WASScrollViewDecorate
@synthesize headerView  = _headerView;
@synthesize footerView  = _footerView;
@synthesize exDelegate  = _exDelegate;
@synthesize scrollContentView       = _scrollContentView;
@synthesize waitUntilEndDragging    = _waitUntilEndDragging;
@synthesize didReachTheEnd          = _didReachTheEnd;
@synthesize autoScrollToNextPage    = _autoScrollToNextPage;

- (id)initWithFrame:(CGRect)frame
{
    [NSException raise:@"Incomplete initializer" 
                format:@"WASEXTableView must be initialized with a delegate and a eViewType.\
     Use the initWithFrame:style:type:delegate: method."];
    return nil;
}

- (id)initWithFrame:(CGRect)frame with:(UIScrollView *) scrollView type:(eViewType)theType delegate:(id) theDelegate
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) 
    {
        // Initialization code
        self.exDelegate = theDelegate;
        self.scrollContentView = scrollView;
    
        CGRect rect = CGRectZero;
        
        /*if the theType contains eTypeHeader , then create it*/
        if (eTypeHeader == (theType & eTypeHeader)) {
            rect = CGRectMake(0, - frame.size.height, frame.size.width, frame.size.height);
            _headerView = [[WASRefreshTableHeader alloc] initWithFrame:rect type:eTypeHeader];
            [self.scrollContentView addSubview:_headerView];
            headerFrame = _headerView.frame;            
        }
        else if(eTypeHeaderImage == (theType & eTypeHeaderImage)){
            rect = CGRectMake(0, - frame.size.height, frame.size.width, frame.size.height);
            _headerView = [[WASRefreshTableHeader alloc] initWithFrame:rect type:eTypeHeaderImage];
            [self.scrollContentView addSubview:_headerView];
            headerFrame = _headerView.frame;
        }
        
        /*if the theType contains eTypeFooter , then create it*/
        if (eTypeFooter == (theType & eTypeFooter)) {
            rect = CGRectMake(0, frame.size.height + kContentSizeHeightDecorate, frame.size.width, frame.size.height);
            _footerView = [[WASRefreshTableHeader alloc] initWithFrame:rect type:eTypeFooter];
            _footerView.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [self.scrollContentView addSubview:_footerView];
            footerFrame = rect;
        }
        else if (eTypeFooter == (theType & eTypeFooterImage))
        {
            rect = CGRectMake(0, frame.size.height + kContentSizeHeightDecorate, frame.size.width, frame.size.height);
            _footerView = [[WASRefreshTableHeader alloc] initWithFrame:rect type:eTypeFooterImage];
            [self.scrollContentView addSubview:_footerView];
            footerFrame = rect;
        }
        
        [self.scrollContentView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];        

    }
    return self;
}

- (void)dealloc 
{
    [self.scrollContentView removeObserver:self forKeyPath:@"contentSize"];
	[_headerView release ], _headerView  = nil;
	[_footerView release ], _footerView  = nil;
    [_msgLabel release],    _msgLabel    = nil;
    _exDelegate = nil;
    [super dealloc];
}


#pragma mark -- scrollDelegate

- (void)scrollToNextPage 
{
    float h = self.scrollContentView.frame.size.height;
    float y = self.scrollContentView.contentOffset.y + h;
    y = y > self.scrollContentView.contentSize.height ? self.scrollContentView.contentSize.height : y;
    
    [UIView animateWithDuration:.7f 
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut 
                     animations:^{
                         self.scrollContentView.contentOffset = CGPointMake(0, y);  
                     }
                     completion:^(BOOL bl){
                     }];
}

- (void) refreshData
{
    if (_exDelegate && [_exDelegate respondsToSelector:@selector(tableViewDidStartRefreshing:)]) {
        [_exDelegate tableViewDidStartRefreshing:self];
    }
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView
{
    _waitUntilEndDragging = NO;
    if ((_headerView && _headerView.state == eHeaderRefreshLoading) || 
        (_footerView && _footerView.state == eFooterReloadLoading)) 
        return;
    
    if (_headerView && _headerView.state == eHeaderRefreshPulling) {
        
        _isFooterInAction = NO;
        _headerView.state = eHeaderRefreshLoading;
        
        [UIView animateWithDuration:kRefreshAnimationDuration animations:^{
            self.scrollContentView.contentInset = UIEdgeInsetsMake(kRefreshOffsetY, 0, 0, 0);
            
        } completion:^(BOOL finished) {
            [self performSelector:@selector(refreshData) withObject:nil afterDelay:.1];
        }];
    } 
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset      = scrollView.contentOffset;
    CGSize size         = scrollView.frame.size;
    CGSize contentSize  = scrollView.contentSize;
    
    float yMargin = offset.y + size.height - contentSize.height /*+ kContentSizeHeightDecorate*/;
    
    if (_headerView && offset.y < -kRefreshOffsetY )                        //header totally appeard
    {
        CGRect rect = headerFrame;
        rect.origin.y =  headerFrame.origin.y +  (offset.y + kRefreshOffsetY)/2;
        _headerView.frame = rect;
        if (_headerView.state != eHeaderRefreshLoading) {
            _headerView.state = eHeaderRefreshPulling;
        }
    } 
    else if (_headerView && offset.y > -kRefreshOffsetY && offset.y < 0)   //header part appeared
    {
        if (_headerView.state != eHeaderRefreshLoading) {
            _headerView.state = eHeaderRefreshNormal;
        }
    } 
    else if (_footerView && yMargin > kReloadOffsetY)                     //footer totally appeared
    {  
        CGRect rect     = footerFrame;  //no
        rect.origin.y   =  footerFrame.origin.y  + (yMargin - kReloadOffsetY )/2 ;
        _footerView.frame = rect;
        
        if (_footerView.state == eFooterReloadLoading) {
            return;
        }
        else if (_footerView.state != eFooterReloadReachEnd) {            
            if (self.didReachTheEnd || _waitUntilEndDragging) 
                return;
            
            _isFooterInAction = YES;
            _footerView.state = eFooterReloadLoading;
            if (_footerView.viewType == eTypeFooterImage) {
                _footerView.spinner.progress = 100.0f;
            }
            [UIView animateWithDuration:kRefreshAnimationDuration animations:^{
                _footerView.frame = footerFrame;
            }];
            if (_exDelegate && [_exDelegate respondsToSelector:@selector(tableViewDidStartLoading:)]) {
                [_exDelegate tableViewDidStartLoading:self];
            }
            
        }
    }
    else if (_footerView && yMargin < kReloadOffsetY && yMargin > 0)      //footer part appeared
    {
        if (_footerView.viewType == eTypeFooterImage) {
            _footerView.spinner.progress = yMargin/kReloadOffsetY * 100.0f;
        }
        if (self.didReachTheEnd || _waitUntilEndDragging) 
            return;
        if (_footerView.state == eFooterReloadLoading) {
            return;
        }
        else if (_footerView.state != eFooterReloadReachEnd) {
            _footerView.state = eFooterReloadNormal;
        }
    }
}


- (void)flashMessage:(NSString *)msg
{
    __block CGRect rect = CGRectMake(0, self.scrollContentView.contentOffset.y - 20, self.scrollContentView.bounds.size.width, 20);
    
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.font = [UIFont systemFontOfSize:14.f];
        _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _msgLabel.backgroundColor = [UIColor orangeColor];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
    }
    else  {
        _msgLabel.frame = rect;
        _msgLabel.text = msg;
        [self addSubview:_msgLabel];    
    }
    rect.origin.y += 20;
    
    [UIView animateWithDuration:kRefreshAnimationDuration 
                     animations:^ {
                         _msgLabel.frame = rect;
                     } 
                     completion:^(BOOL finished) {
                         rect.origin.y -= 20;
                         [UIView animateWithDuration:kRefreshAnimationDuration 
                                               delay:1.0f 
                                             options:UIViewAnimationOptionCurveLinear 
                                          animations:^ {
                                              _msgLabel.frame = rect;
                                          } 
                                          completion:^(BOOL finished) {
                                              [_msgLabel removeFromSuperview];
                                          }];
                     }];
}

- (void)launchRefreshing 
{
    [self.scrollContentView setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:kRefreshAnimationDuration
                     animations:^ {
                         self.scrollContentView.contentOffset = CGPointMake(0, -kRefreshOffsetY-4);
//                         self.scrollContentView.contentOffset = CGPointMake(0, -kRefreshOffsetY-1);
                     } 
                     completion:^(BOOL bl) {
                         [self tableViewDidEndDragging:self.scrollContentView];
                     }];
}

- (void)prepareRefreshing:(voidBlock)block
{
    [self.scrollContentView setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:kRefreshAnimationDuration
                     animations:^ {
                         self.scrollContentView.contentOffset = CGPointMake(0, -kRefreshOffsetY-4);
                     }
                     completion:^(BOOL bl) {
                         _isFooterInAction = NO;
                         _headerView.state = eHeaderRefreshLoading;
                         [UIView animateWithDuration:kRefreshAnimationDuration animations:^{
                             self.scrollContentView.contentInset = UIEdgeInsetsMake(kRefreshOffsetY, 0, 0, 0);
                             
                         }];
                         if (block) {
                            block();
                         }
                     }];
}

- (void)tableViewDidFinishedLoading 
{
    [self tableViewDidFinishedLoadingWithMessage:nil];  
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg
{
    if (_headerView && _headerView.state == eHeaderRefreshLoading) {
        [_headerView setState:eHeaderRefreshNormal];
        [_headerView setCurrentDate];
        
        [UIView animateWithDuration:kRefreshAnimationDuration 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^ {
                             self.scrollContentView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                         } 
                         completion:^(BOOL bl) {
                             if (msg && ![msg isEqualToString:@""]) {
                                 [self flashMessage:msg];
                             }
                         }];
    }
    
    if (_footerView && _footerView.state == eFooterReloadLoading) {
        [_footerView setState:eFooterReloadNormal];
        [_footerView setCurrentDate];
        
        return;

        [UIView animateWithDuration:kRefreshAnimationDuration    //no
                         animations:^ {
                             self.scrollContentView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                         } 
                         completion:^(BOOL bl) {
                             if (msg && ![msg isEqualToString:@""]) {
                                 [self flashMessage:msg];
                             }
                         }];
    }
}

- (void)setDidReachTheEnd:(BOOL)theDidReachTheEnd
{
    _didReachTheEnd = theDidReachTheEnd;
    if (_didReachTheEnd) {
        if (_footerView)  {
            _footerView.state = eFooterReloadReachEnd;
        }
        if (_footerView.superview) {      //no
            [_footerView removeFromSuperview];
        }
    }
    else {
        if (_footerView) {
            _footerView.state = eFooterReloadNormal;
        }
        if (!_footerView.superview) {     //no
            [self.scrollContentView addSubview:_footerView];
            [self.scrollContentView bringSubviewToFront:_footerView];

        }
    }
}

#pragma mark - 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
    CGRect frame = _footerView.frame;
    CGSize contentSize = self.scrollContentView.contentSize;
    frame.origin.y = (contentSize.height < self.frame.size.height) ? self.frame.size.height : (contentSize.height + kContentSizeHeightDecorate);
    _footerView.frame = frame;
    footerFrame = frame;
}

@end
