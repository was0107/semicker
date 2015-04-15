//
//  CommentsTableViewCell.h
// sejieios
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UITableViewBaseCell.h"
#import "ListCommentItem.h"


@interface CommentsTableViewEmptyCell : UITableViewBaseCell

@end


@interface CommentsTableViewCell : UITableViewBaseCell

@property (nonatomic, retain ) UILabel *titleLabel;
@property (nonatomic, retain ) UILabel *contentLabel;
@property (nonatomic, retain ) UILabel *timeLabel;
@property (nonatomic, retain ) ListCommentItem *commentItem;
@end
