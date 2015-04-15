//
//  TopFilterTableViewCell.h
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UITableViewBaseCell.h"

@interface TopFilterTableViewCell : UITableViewBaseCell

@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, assign) id contentData;
@property (nonatomic, copy) idBlock block;

@property (nonatomic, retain)   UILabel     *keywordLabel;


@end
