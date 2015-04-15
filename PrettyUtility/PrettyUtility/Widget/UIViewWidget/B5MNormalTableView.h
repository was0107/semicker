//
//  B5MNormalTableView.h
//  PrettyUtility
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface B5MNormalTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray    *contentArray;


- (void) setupContentView;

@end
