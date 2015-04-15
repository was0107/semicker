//
//  WASWaterFlowTableView_private.h
//  micker
//
//  Created by allen.wang on 8/17/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASWaterFlowTableView.h"
#import "WASWaterFlowCell.h"
#import "WASWaterFlowCellInfo.h"
#import "WASWaterFlowPathInfo.h"

#pragma mark - Private static members

const static NSUInteger DEFAULT_NUMBER_OF_CELLS = 3;
const static CGFloat DEFAULT_CELL_RIGHT_MARGIN  = 5.0f;
const static CGFloat DEFAULT_RIGHT_MARGIN       = 5.0f;


#pragma mark  WASWaterFlowTableView()

@interface WASWaterFlowTableView()
{
    NSInteger   _numberOfColumns; 
    CGFloat     _paddingWidth ;
}

@property (nonatomic, retain) NSMutableArray        *cellColumnInfos; 
@property (nonatomic, retain) NSMutableArray        *visibleCells;
@property (nonatomic, retain) NSMutableDictionary   *reusableCells;

@end

#pragma mark  WASWaterFlowTableView(InternalMethods)

@interface WASWaterFlowTableView(InternalMethods)

/**
 *	@brief	reverse the array , it's public method
 *
 *	@param 	array 	the array
 */
+ (void) reverseArray:(NSMutableArray*)array;

/**
 *	@brief	get the shortest cell from the column cells array
 *
 *	@return	the shotest cell
 */
- (WASWaterFlowPathInfo*) infoOfShortestCell;

/**
 *	@brief	get the highest cell from the column cells array
 *
 *	@return	the highest cell
 */
- (WASWaterFlowPathInfo*) infoOfHighestCell;

/**
 *	@brief	get the data from delegate and init some array
 */
- (void) prepareParametersNeededForLayout;

/**
 *	@brief	reset the content of each cell
 */
- (void) resetContentSizeByAppendingCellViews;

/**
 *	@brief	empty all visible cell from the current view
 */
- (void) removeAllVisibleCellViews;

/**
 *	@brief	load the cell when scroll
 *
 *	@param 	pathInfo 	pathInfo description
 *	@param 	minY 	minY description
 *	@param 	maxY 	maxY description
 */
- (void) tileCellViewsOnPath:(WASWaterFlowPathInfo*)pathInfo minimumY:(CGFloat)minY maximumY:(CGFloat)maxY;

/**
 *	@brief	load the cell in appoint column
 *
 *	@param 	petalViewInfo 	petalViewInfo description
 *	@param 	cellViews 	cellViews description
 */
- (void) tileCellViewWithInfo:(WASWaterFlowCellInfo*)petalViewInfo cellViewList:(NSMutableArray*)cellViews column:(NSUInteger) column;

/**
 *	@brief	reload cell in columns
 *
 *	@param 	pathInfo 	pathInfo description
 *	@param 	cellViews 	cellViews description
 *	@param 	minY 	minY description
 *	@param 	maxY 	maxY description
 */
- (void) reloadCellViewsOnPath:(WASWaterFlowPathInfo*)pathInfo
                  cellViewList:(NSMutableArray*)cellViews
                      minimumY:(CGFloat)minY
                      maximumY:(CGFloat)maxY
;

/**
 *	@brief	caculate the first row below the appoint Y
 *
 *	@param 	y 	y description
 *	@param 	pathInfo 	pathInfo description
 *
 *	@return	return the row
 */
- (NSInteger) firstRowBelowY:(CGFloat)y inPath:(WASWaterFlowPathInfo*)pathInfo;

/**
 *	@brief	push cell view for reuse
 *
 *	@param 	petalView 	petalView 
 */
- (void) pushCellViewForReuse:(WASWaterFlowCell*)petalView;

/**
 *	@brief	pop the reusable cell with identifier
 *
 *	@param 	identifier 	identifier 
 *
 *	@return	return cell 
 */
- (WASWaterFlowCell*) popReusableCellViewWithIdentifier:(NSString*)identifier;

@end





