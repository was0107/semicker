//
//  TopFilterTableView.h
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "B5MTableViewBase.h"

@interface TopFilterTableView : B5MTableViewBase

@property (nonatomic, copy) idBlock block;
@property (nonatomic, assign) NSMutableArray  *cellContents;

@end
