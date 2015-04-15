//
//  UserCenterTableCell.h
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import "UserRecordItem.h"


@interface UserCenterEmptyCell : UITableViewCell

@end

@interface UserCenterTableCell : UITableViewCell

@property   (nonatomic, retain)     UILabel         *timeLabel;
@property   (nonatomic, retain)     CustomLabel     *actionLabel;
@property   (nonatomic, retain)     UIImageView     *actionImageView;
@property   (nonatomic, retain)     UIView          *actionView;
@property   (nonatomic, retain)     CustomLabel     *commentLabel;
@property   (nonatomic, assign)     UserRecordItem  *recordItem;
@property   (nonatomic, retain)     UIImageView     *photoImage;

@property (nonatomic, copy)         idBlock         block;


- (void) updateCellData:(UserRecordItem *)item;


@end
