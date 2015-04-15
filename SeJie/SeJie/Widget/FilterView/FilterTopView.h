//
//  FilterTopView.h
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTopViewItem.h"

@interface FilterTopView : UIView
@property (nonatomic, retain) FilterTopViewItem *itemSejie;
@property (nonatomic, retain) FilterTopViewItem *itemFind;
@property (nonatomic, copy)   intIdBlock     block;

@end
