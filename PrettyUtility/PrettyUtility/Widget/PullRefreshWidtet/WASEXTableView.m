//
//  WASEXTableView.m
//  micker
//
//  Created by allen.wang on 7/12/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASEXTableView.h"

#pragma mark -- WASEXTableView

@interface WASEXTableView() 
@property (nonatomic, retain) WASScrollViewDecorate *decoreate;
@end

@implementation WASEXTableView
@synthesize didReachTheEnd          = _didReachTheEnd;
@synthesize decoreate               = _decoreate;
@synthesize exDelegate              = _exDelegate;

- (id)initWithFrame:(CGRect)frame
{
    [NSException raise:@"Incomplete initializer" 
                format:@"WASEXTableView must be initialized with a delegate and a eViewType.\
                         Use the initWithFrame:style:type:delegate: method."];
    return nil;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id) theDelegate
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) 
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.decoreate = [[[WASScrollViewDecorate alloc] initWithFrame:frame with:self type:theType delegate:theDelegate] autorelease];        
    }
    return self;
}

- (void)dealloc 
{
    [_decoreate release],   _decoreate   = nil;
    [super dealloc];
}

#pragma mark -- scrollDelegate

- (void) tableViewDidEndDragging:(UIScrollView *)scrollView
{
    [_decoreate tableViewDidEndDragging:scrollView];
}

- (void) tableViewDidScroll:(UIScrollView *)scrollView {
    
    [_decoreate tableViewDidScroll:scrollView];
}

- (void) launchRefreshing 
{
    [_decoreate launchRefreshing];
}

- (void)prepareRefreshing:(voidBlock)block
{
    [_decoreate prepareRefreshing:block];
}

- (void)tableViewDidFinishedLoading 
{
    [_decoreate tableViewDidFinishedLoading];
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg
{
    [_decoreate tableViewDidFinishedLoadingWithMessage:msg];
}

- (void)setDidReachTheEnd:(BOOL)theDidReachTheEnd
{
    _didReachTheEnd = theDidReachTheEnd;
    _decoreate.didReachTheEnd = theDidReachTheEnd;
}
@end
