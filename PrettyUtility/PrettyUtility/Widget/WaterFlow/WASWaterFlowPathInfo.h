//
//  WASWaterFlowPathInfo.h
//  micker
//
//  Created by allen.wang on 8/16/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WASWaterFlowCellInfo;


@interface WASWaterFlowPathInfo : NSObject

@property (nonatomic, assign) NSUInteger column;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

/**
 *	@brief   number of cells in the column
 *
 *	@return	cells count
 */
- (NSUInteger) numberOfCells;

/**
 *	@brief	waterFlowCellInfoForRow
 *
 *	@param 	row 	row description
 *
 *	@return	return WASWaterFlowCellInfo with the row in this column
 */
- (WASWaterFlowCellInfo*) waterFlowCellInfoForRow:(NSUInteger)row;

/**
 *	@brief	add waterFlow Cell info to the private Array
 *
 *	@param 	petalViewInfo 	petalViewInfo description
 */
- (void) addWaterFlowCellInfo:(WASWaterFlowCellInfo*)petalViewInfo;

- (void) changeWaterFlowCellFrame:(NSUInteger) row withOffsetY:(CGFloat) y animatin:(BOOL) flag;
@end
