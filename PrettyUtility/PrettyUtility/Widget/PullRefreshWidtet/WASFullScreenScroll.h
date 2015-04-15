//
//  WASFullScreenScroll.h
//  micker
//
//  Created by allen.wang on 7/13/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WASFullScreenScrollDelegate <NSObject>

- (void)scrollView:(UIScrollView*)scrollView deltaY:(CGFloat)deltaY;

@end

@interface WASFullScreenScroll : NSObject<UIScrollViewDelegate>
{
    CGFloat _prevContentOffsetY;
    BOOL    _isScrollingTop;
}
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL shouldShowUIBarsOnScrollUp;
@property (nonatomic, assign) UIView *contentView;
@property (nonatomic, assign) id<WASFullScreenScrollDelegate> delegate;

- (id)initWithView:(UIView*)theContentView;

@end
