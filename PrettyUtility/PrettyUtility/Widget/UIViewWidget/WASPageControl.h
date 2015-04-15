//
//  WASPageControl.h
//  b5mUtility
//
//  Created by allen.wang on 12/17/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, WASPageControlAlignment) {
	PageControlAlignmentLeft = 1,
	PageControlAlignmentCenter,
	PageControlAlignmentRight
};

typedef NS_ENUM(NSUInteger, WASPageControlVerticalAlignment) {
	PageControlVerticalAlignmentTop = 1,
	PageControlVerticalAlignmentMiddle,
	PageControlVerticalAlignmentBottom
};


@interface WASPageControl : UIControl

@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) CGFloat indicatorMargin                               ; // deafult is 10
@property (nonatomic) CGFloat indicatorDiameter                             ; // deafult is 6
@property (nonatomic) WASPageControlAlignment alignment                     ; // deafult is Center
@property (nonatomic) WASPageControlVerticalAlignment verticalAlignment     ;	// deafult is Middle

@property (nonatomic, retain) UIImage *pageIndicatorImage                   ;
@property (nonatomic, retain) UIColor *pageIndicatorTintColor               ; // ignored if pageIndicatorImage is set
@property (nonatomic, retain) UIImage *currentPageIndicatorImage            ;
@property (nonatomic, retain) UIColor *currentPageIndicatorTintColor        ; // ignored if currentPageIndicatorImage is set

@property (nonatomic) BOOL hidesForSinglePage;			// hide the the indicator if there is only one page. default is NO
@property (nonatomic) BOOL defersCurrentPageDisplay;	// if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO

- (void)updateCurrentPageDisplay;						// update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately

- (CGRect)rectForPageIndicator:(NSInteger)pageIndex;
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

- (void)setImage:(UIImage *)image forPage:(NSInteger)pageIndex;
- (void)setCurrentImage:(UIImage *)image forPage:(NSInteger)pageIndex;
- (UIImage *)imageForPage:(NSInteger)pageIndex;
- (UIImage *)currentImageForPage:(NSInteger)pageIndex;

- (void)updatePageNumberForScrollView:(UIScrollView *)scrollView;
@end
