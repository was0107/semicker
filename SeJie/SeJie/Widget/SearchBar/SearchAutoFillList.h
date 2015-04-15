//
//  B5MAutoFillList.h
//  micker
//
//  Created by Jarry on 12-11-21.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBlock)(NSString *keyword);

@interface SearchAutoFillList : UIView

@property (nonatomic, retain) NSMutableArray    *listData;
@property (nonatomic, copy)   SelectBlock       selectBlock;
@property (nonatomic, assign) BOOL              isHistory;

- (void) reloadData;

- (void) clearList;

- (void) loadHistoryData;

@end
