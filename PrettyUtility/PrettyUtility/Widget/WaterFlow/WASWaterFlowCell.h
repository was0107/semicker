//
//  WASWaterFlowCell.h
//  micker
//
//  Created by allen.wang on 8/15/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *WASWaterFlowCellIsSelected;

#define     CELL_VIEW_COLUMN__      @"__CELL_VIEW_COLUMN__"
#define     CELL_VIEW_ROW_KEY       @"__CELL_VIEW_ROW__"
#define     CELL_VIEW_INDEX_KEY     @"CELL_VIEW_INDEX_KEY"

@interface WASWaterFlowCell : UIView
@property (nonatomic, retain) NSIndexPath   *indexPath;
@property (nonatomic, retain) NSString      *reuseIdentifier;
@property (nonatomic, retain) UIImageView   *imageView;
@property (nonatomic, retain) UIView        *borderView;


/**
 *	@brief	init with reuse identifier
 *
 *	@param 	reuseIdentifier 	reuseIdentifier description
 *
 *	@return	return value description
 */
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void) prepareForReuse;
@end
