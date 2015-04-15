//
//  BaseSwipeView.m
//  PrettyUtility
//
//  Created by allen.wang on 1/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseSwipeView.h"

@implementation BaseSwipeView
@synthesize contents = _contents;
@synthesize block    = _block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        
        self.delegate   = self;
        self.dataSource = self;
        self.backgroundColor = kClearColor;
        [self setClipsToBounds:YES];
        
        self.alignment = SwipeViewAlignmentCenter;
        self.pagingEnabled = YES;
        self.wrapEnabled = NO;
        self.itemsPerPage = 1;
        self.truncateFinalPage = NO;
    }
    return self;
}

- (void) dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
    TT_RELEASE_SAFELY(_block);
    TT_RELEASE_SAFELY(_contents);
    [super dealloc];
}

- (void) setContents:(NSMutableArray *)contents
{
    if (_contents != contents) {
        [_contents release];
        _contents = [contents retain];
        
        [self didSetContents];
    }
}

- (void) didSetContents
{
    
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return (self.contents) ? [self.contents count] : 0 ;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    return nil;
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self swipeViewDidEndDecelerating:swipeView];
    }
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    
}
@end
