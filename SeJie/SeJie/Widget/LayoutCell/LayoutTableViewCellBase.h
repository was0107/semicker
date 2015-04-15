//
//  LayoutTableViewCellBase.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutCellModel.h"
#import "UITableViewBaseCell.h"
#import "ListImageItem.h"

@interface CellImageView : UIImageView
@property (nonatomic, assign) ListImageItem  *item;
@end

@interface LayoutTableViewCellBase : UITableViewBaseCell
{
    UIImage *_defaultImage, *_defaultImage1;
    UIColor *_bgColor;
}
@property (nonatomic, retain) LayoutCellModelBase *layoutType;
@property (nonatomic, copy)   idBlock block;

- (void) configureCellContent;

@end


@interface LayoutNormalCell : LayoutTableViewCellBase

@end