//
//  BaseCarousel.m
//  PrettyUtility
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseCarousel.h"
#import "UIView+extend.h"

@implementation BaseCarousel
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
        self.decelerationRate = 0.91;
        [self setClipsToBounds:YES];
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

#pragma mark -
#pragma mark iCarousel delegate

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self carouselDidEndDecelerating:carousel];
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)carousel:(iCarousel *)carousel didEndSelectItemAtIndex:(NSInteger)index
{
    self.block ? self.block([self.contents objectAtIndex:index]) : nil;
}

#pragma mark -
#pragma mark - need to override

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 320;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return (self.contents) ? [self.contents count] : 0 ;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    return nil;
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel
{
    
}

@end
