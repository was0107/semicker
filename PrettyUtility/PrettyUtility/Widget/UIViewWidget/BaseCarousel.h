//
//  BaseCarousel.h
//  PrettyUtility
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "iCarousel.h"

@interface BaseCarousel : iCarousel<iCarouselDataSource, iCarouselDelegate>
@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, copy)   idBlock        block;


- (void) didSetContents;
@end
