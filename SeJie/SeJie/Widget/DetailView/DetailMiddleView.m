//
//  DetailMiddleView.m
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "DetailMiddleView.h"
#import "UIView+extend.h"
#import "DetailMiddleItem.h"

@implementation DetailMiddleView

@synthesize contents    = _contents;
@synthesize contentView = _contentView;
@synthesize pageControl = _pageControl;
@synthesize itemBlock   = _itemBlock;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        [self addSubview:self.contentView];
        [self addSubview:self.pageControl];
        
        [self.pageControl addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (WASPageControl *) pageControl
{
    if (!_pageControl) {
        _pageControl = [[WASPageControl alloc] initWithFrame:CGRectMake(5, kMiddleGoodsHeight - 20, 310, 14)];
        [_pageControl setHidesForSinglePage:YES];
        [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"pagecontrol_dot_focus"]];
        [_pageControl setPageIndicatorImage:[UIImage imageNamed:@"pagecontrol_dot"]];
        _pageControl.backgroundColor = kClearColor;
    }
    return _pageControl;
}

- (UIScrollView *) contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kMiddleGoodsHeight)];
        _contentView.delegate = self;
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

- (void) setContents:(NSMutableArray *)contents
{
    if (_contents != contents) {
        [_contents release];
        _contents = [contents retain];
        [self didSetContents];
    }
}

- (void) dealloc
{
    [self.pageControl removeObserver:self forKeyPath:@"currentPage"];
    TT_RELEASE_SAFELY(_pageControl);
    TT_RELEASE_SAFELY(_itemBlock);
    TT_RELEASE_SAFELY(_contentView);
    TT_RELEASE_SAFELY(_contents);
    [super dealloc];
}

- (void)valueChanged:(id)sender
{
    DetailMiddleItem *contentView = (DetailMiddleItem *)[self.contentView viewWithTag:(1998 + self.pageControl.currentPage)];
    [contentView downloadImage];
}

- (void) didSetContents
{
    [self.contentView emptySubviews];
    for (NSUInteger index = 0 , total = [self.contents count]; index < total; index++) {
        DetailMiddleItem *contentView = [[[DetailMiddleItem alloc] initWithFrame:CGRectMake(320*index, 0, 320, kMiddleGoodsHeight)] autorelease];
        contentView.backgroundColor = kClearColor;
        contentView.content = [[self contents] objectAtIndex:index];
        contentView.itemBlock = self.itemBlock;
        contentView.tag = 1998 + index;
        [self.contentView addSubview:contentView];
    }
    [self.contentView setContentSize:CGSizeMake(320 * [self.contents count], kMiddleGoodsHeight)];
    [self.contentView setContentOffset:CGPointZero animated:YES];
    if ([self.contents count] == 0) {
        [self setFrameHeight:0];
    } else {
        [[self pageControl] setNumberOfPages:[self.contents count]];
        [[self pageControl] setCurrentPage:0];
        [self valueChanged:nil];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint pt = scrollView.contentOffset;
    int index = (int) (pt.x / 320.0 + 0.5);
    [[self pageControl] setCurrentPage:index];
}


#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self valueChanged:nil];
}

@end
