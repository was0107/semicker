//
//  GuangWaterFlowCell.h
//  micker
//
//  Created by allen.wang on 12/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASWaterFlowCell.h"
#import "ListGuangItem.h"

typedef void(^updateCellContent)(NSUInteger column,NSUInteger row, CGFloat y, BOOL flag);
@protocol GuangWaterFlowCellDelegate;

@interface GuangWaterFlowCell : WASWaterFlowCell
{
    CGFloat _cellWidth ;
}

@property (nonatomic, retain) ListGuangItem         *items;
@property (nonatomic, copy  ) NSString              *imageUrl;
@property (nonatomic, assign) CGFloat               contentsHeight;
@property (nonatomic, copy  ) updateCellContent     update;
@property (nonatomic, assign) id <GuangWaterFlowCellDelegate> waterFlowDelegate;
@property (nonatomic, assign) NSUInteger            columns;
@end

@protocol GuangWaterFlowCellDelegate <NSObject>

@optional
/**
 *	@brief	did select the row at indexPath
 *
 *	@param 	flowView 	flowView description
 *	@param 	index       index description
 */
- (void)waterFlowView:(GuangWaterFlowCell *)flowViewCell didSelectRowAtIndex:(NSUInteger) index;
@end