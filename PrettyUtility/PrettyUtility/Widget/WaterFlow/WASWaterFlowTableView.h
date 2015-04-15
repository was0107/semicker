//
//  WASWaterFlowTableView.h
//  micker
//
//  Created by allen.wang on 8/15/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WASWaterFlowCell.h"


#define kContentSizeExtendHeight        20.0f

@protocol WaterflowViewDelegate,WaterflowViewDatasource;

@interface WASWaterFlowTableView : UIScrollView
{
@private
    id <WaterflowViewDatasource>    _waterFlowDatasource;
}


@property (nonatomic, assign)IBOutlet id <WaterflowViewDatasource> waterFlowDatasource;
@property (nonatomic, retain) UIView           *backgroundView;
@property (nonatomic, assign) CGFloat           headerHeight;
@property (nonatomic, assign) CGFloat           cellViewGap;
@property (nonatomic, assign) CGFloat           rightMargin;
@property (nonatomic, assign) NSUInteger        currentIndex;


/**
 *	@brief	scroll to the selected index with NO animation
 */
- (void) scrollToSelectedIndex;

/**
 *	@brief	reload data and fresh the UI
 */
- (void) reloadData;
/**
 *	@brief	append cells when there exist more data need to show
 */
- (void) appendCells;

/**
 *	@brief	reusable cell
 *
 *	@param 	identifier 	identifier
 *
 *	@return	the reusable cell or nil
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (NSUInteger) firstCellInVisble;

- (void) updateTileColumn:(NSUInteger) column row:(NSUInteger) row withOffsetY:(CGFloat) y animatin:(BOOL) flag;


@end


////DataSource and Delegate
@protocol WaterflowViewDatasource <NSObject>

@required
/**
 *	@brief	how many cells in the water flow view
 *
 *	@param 	waterfallView 	waterfallView description
 *
 *	@return	return number of columns 
 */
- (NSUInteger) numberOfCellsForWaterfallView:(WASWaterFlowTableView*)waterfallView;
/**
 *	@brief	how many columns in the water flow view, the default is 3
 *
 *	@param 	waterfallView 	waterfallView description
 *
 *	@return	return value description
 */
- (NSUInteger) numberOfColumnsForWaterfallView:(WASWaterFlowTableView*)waterfallView;


/**
 *	@brief	return the cell 
 *
 *	@param 	flowView 	flowView description
 *	@param 	indexPath 	index
 *
 *	@return	the cell
 */ 
- (WASWaterFlowCell *)waterFlowView:(WASWaterFlowTableView *)flowView cellForRowAtIndexPath:(NSUInteger)index;

@optional

/**
 *	@brief	normalized Height of cell at special index, It will be used for calculate the height of the view
 *          the view's height = value * width
 *
 *	@param 	waterfallView 	waterfallView description
 *	@param 	index 	index description
 *
 *	@return	return normalized Height of cell at special index 
 */
- (CGFloat) waterfallView:(WASWaterFlowTableView*)waterfallView normalizedHeightOfCellAtIndex:(NSUInteger)index;
- (CGFloat) waterfallView:(WASWaterFlowTableView*)waterfallView heightOfCellAtIndex:(NSUInteger)index;

/**
 *	@brief	Appoint the width of each width , If the protocol is not implement ,then ,the width is calculate by automaticlly
 *
 *	@param 	waterfallView 	waterfallView description
 *	@param 	column 	column description
 *
 *	@return	return value description
 */
- (CGFloat) waterfallView:(WASWaterFlowTableView*)waterfallView widthOfCellOnColumn:(NSUInteger)column;

@end