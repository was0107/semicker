//
//  DetailMiddleView.h
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCarousel.h"
#import "WASPageControl.h"


#pragma mark -
#pragma mark - DetailMiddleView

@interface DetailMiddleView : UIView<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView   *contentView;
@property (nonatomic, retain) WASPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, copy)   idBlock         itemBlock;


@end
