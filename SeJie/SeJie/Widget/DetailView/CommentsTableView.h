//
//  CommentsTableView.h
// sejieios
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "B5MTableViewBase.h"

@interface CommentsTableView : B5MTableViewBase
@property (nonatomic, copy) idBlock block;

@property (nonatomic, assign) int firstCellHeight;

- (int) computeHeight:(NSString *) content;

@end
