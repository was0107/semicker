
//
//  DetailScrollView.m
// sejieios
//
//  Created by allen.wang on 1/15/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "DetailScrollView.h"
#import "DetailItemScrollView.h"
#import "SDWebImagePrefetcher.h"
#import "UIView+extend.h"

@implementation DetailScrollView
@synthesize keyword        = _keyword;
@synthesize responseItem   = _responseItem;
@synthesize viewController = _viewController;
@synthesize adapter        = _adapter;
@synthesize enableClickUser= _enableClickUser;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        self.decelerationRate = 0.84;
        self.bounces = YES;
        didReachTheEnd = NO;
        self.clipsToBounds = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveData:) name:kDidReceiveDataFromServerNotification object:nil];

    }
    return self;
}

- (void) dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(load) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preLoad) object:nil];
    [[SDWebImagePrefetcher sharedImagePrefetcher] cancelPrefetching];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_responseItem);
    [super dealloc];
}


- (void) saveImage
{
    DetailItemScrollView *item = (DetailItemScrollView *)self.currentItemView;
    if (item) {
        [item.topView saveImage];
    }
}

- (NSMutableArray *) getLattestImageArray
{
    NSInteger start = [self.contents count] - 10;
    if (start < 0) {
        start = 0;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (NSUInteger index = start; index < [self.contents count]; index++) {
        ListSeiJieItem *item = [self.contents objectAtIndex:index];
        if (item && item.img) {
            [array addObject:[[item.img copy] autorelease]];
        }
    }
    return array;
}

- (NSMutableArray *) getLeftAndRight:(NSInteger) index
{
    NSInteger start = index - 10;
    NSInteger end   = index + 10;
    if (start < 0) {
        start = 0;
    }
    if (end > [self.contents count]) {
        end = [self.contents count];
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (NSUInteger index = start; index < end; index++) {
        ListSeiJieItem *item = [self.contents objectAtIndex:index];
        if (item && item.img) {
            [array addObject:[[item.img copy] autorelease]];
        }
    }
    return array;
}

#pragma mark -
#pragma mark - override

- (void) didSetContents
{
    [self reloadData];
    if ([[self contents] count] < 5) {
        didReachTheEnd = YES;
    }
    NSUInteger index = [self.contents indexOfObject:self.responseItem];
    [self scrollToItemAtIndex:index duration:0];
    indexDidChanged = YES;
    [self swipeViewDidEndScrollingAnimation:self];
    
//    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:[self getLattestImageArray]];
    [self performSelector:@selector(loadNeastImage) withObject:nil afterDelay:0.1];

}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    DetailItemScrollView *contentView = (DetailItemScrollView *) view;
    if (!contentView) {
        contentView = [[[DetailItemScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kBoundsHeight - 20)] autorelease];
        contentView.viewController = self.viewController;
        contentView.enableClickUser = self.enableClickUser;
        contentView.commentsView.animateBlock = ^(id content, BOOL flag) {
            self.scrollEnabled = !flag;
            [contentView.contentView setFrameY:flag ? - 216 : 0 ];
        };
    }
    contentView.adapter = self.adapter;
    [contentView resetData];
    
    ListSeiJieItem *responseItem = [[self contents] objectAtIndex:index];
    contentView.keyword = self.keyword;
    contentView.imageURLString = responseItem.img;
    contentView.responseItem = responseItem;

    return contentView;
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preLoad) object:nil];
}
- (void) swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    [self swipeViewDidEndScrollingAnimation:swipeView];
}

- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView
{
    if (!indexDidChanged)
        return;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(load) object:nil];
    [self performSelector:@selector(load) withObject:nil afterDelay:0];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    indexDidChanged = YES;
}

- (void) preLoad
{
    for (NSNumber *number in [self indexesForVisibleItems])
    {
        if ([number integerValue] != self.currentItemIndex)
        {
            [self loadAtIndexEx:number];
        }
    }
        
}

- (void) loadAtIndexEx:(NSNumber *) index
{
    [self loadAtIndex:[index integerValue]];
}

- (void) loadAtIndex:(NSUInteger) index
{
    if (index < [[self contents] count]) {
        DetailItemScrollView *contentView = (DetailItemScrollView *)[self itemViewAtIndex:index];
        if (![contentView sendRequestToServerEx]) {
            if (self.currentItemIndex == index)
                [contentView sendRequestToServer];
        }
        if (![contentView sendCommentsToServerEx]) {
            if (self.currentItemIndex == index)
                [contentView sendCommentsToServer];
        }
    }
}

- (void) addVisitCount:(NSUInteger) index
{
    DetailItemScrollView *contentView = (DetailItemScrollView *)[self itemViewAtIndex:index];
    if (contentView) {
        //[contentView.topView sendRequestToServer:0];
    }
}

- (void) loadNeastImage
{
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:[self getLeftAndRight:self.currentItemIndex]];
}

- (void) load
{
    [self loadAtIndex:self.currentItemIndex];
    [self addVisitCount:self.currentItemIndex];
    indexDidChanged = NO;
    
    if (!didReachTheEnd && self.currentItemIndex == ([self.contents count] - 1 ))
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSendRequestToLoadMoreNotification object:nil];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preLoad) object:nil];
    [self performSelector:@selector(preLoad) withObject:nil afterDelay:0];
}

- (void) didReceiveData:(NSNotification *) notification
{
    didReachTheEnd = [notification.object boolValue];
    [self layoutSubviews];
    [self loadAtIndex:self.currentItemIndex];
    [self performSelector:@selector(preLoad) withObject:nil afterDelay:0];
}
@end
