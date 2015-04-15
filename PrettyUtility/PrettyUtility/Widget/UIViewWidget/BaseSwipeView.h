//
//  BaseSwipeView.h
//  PrettyUtility
//
//  Created by allen.wang on 1/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SwipeView.h"

@interface BaseSwipeView : SwipeView<SwipeViewDelegate, SwipeViewDataSource>

@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, copy)   idBlock        block;


- (void) didSetContents;
@end
