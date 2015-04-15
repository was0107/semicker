//
//  LayoutCellModel.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLayoutCellItemtHeight          100
#define kLayoutCellItemWidth            100
#define kCellLeftGap                    4
#define kCellBetweenGap                 4
#define kBigWidth                       (320 - kCellLeftGap - 8)

#define kLeftX1  kCellLeftGap
#define kLeftX2  (kCellLeftGap + kLayoutCellItemWidth + kCellBetweenGap)
#define kLeftX3  (kLeftX2 + kLayoutCellItemWidth + kCellBetweenGap)
#define kWidth1  kLayoutCellItemWidth
#define kWidth2  196
#define kWidth3  kBigWidth


#define kLeftExX1 kCellLeftGap
#define kLeftExX2 113
#define kLeftExX3 212

#define kWidthEx1 kLayoutCellItemWidth
#define kWidthEx2 204


////////////////////////////////item base//////////////////////////////////////////////
@interface LayoutItemBase : NSObject
@property (nonatomic, assign) NSUInteger itemHeight;
@property (nonatomic, assign) NSUInteger itemWidth;
@property (nonatomic, assign) NSUInteger itemDefault;
@property (nonatomic, assign) CGRect     itemRect;
@property (nonatomic, retain) id         content;

+(id) itemWidht:(NSUInteger)width height:(NSUInteger)height rect:(CGRect) rect defalut:(NSUInteger) defalut;

@end

/////////////////////////////////items base/////////////////////////////////////////////
@interface LayoutCellModelBase : NSObject
{
    NSMutableArray *_items;
}
@property (nonatomic, assign) NSUInteger itemsHeight;

- (NSUInteger) count;

- (NSMutableArray *) items;

@end

///////////////////////////////////one column///////////////////////////////////////////
@interface LayoutCellModelOneColumn : LayoutCellModelBase

@end

@interface LayoutCellModelOneColumn1 : LayoutCellModelOneColumn

@end

@interface LayoutCellModelOneColumn2 : LayoutCellModelOneColumn

@end

@interface LayoutCellModelOneColumn3 : LayoutCellModelOneColumn

@end

@interface LayoutCellModelOneColumn4 : LayoutCellModelOneColumn

@end


@interface LayoutCellModelOneColumn5 : LayoutCellModelOneColumn

@end

///////////////////////////////////two columns///////////////////////////////////////////

@interface LayoutCellModelTwoColumns : LayoutCellModelBase

@end

@interface LayoutCellModelTwoColumns1 : LayoutCellModelTwoColumns

@end
@interface LayoutCellModelTwoColumns2 : LayoutCellModelTwoColumns

@end
@interface LayoutCellModelTwoColumns3 : LayoutCellModelTwoColumns

@end

///////////////////////////////////manager columns base ///////////////////////////////////////////

@interface LayoutCellModel : NSObject
{
    NSUInteger index ;
}
@property (nonatomic, assign) NSUInteger     currentIndex;
@property (nonatomic, retain) NSMutableArray *contentArray;
@property (nonatomic, retain) NSMutableArray *typeArray;

- (void) computePosition;

- (void) resetData;

@end

///////////////////////////////////manager shejie columns///////////////////////////////////////////

@interface LayoutCellShejieModel : LayoutCellModel

@end

///////////////////////////////////manager explorer columns///////////////////////////////////////////

@interface LayoutCellExploreModel : LayoutCellModel

@end
