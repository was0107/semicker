//
//  UserHomeViewController.h
// sejieios
//
//  Created by Jarry on 13-1-22.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "UserCenterOthers.h"
#import "ListSeiJieItem.h"

@interface UserHomeViewController : BaseTitleViewController

@property (nonatomic, retain) UserCenterOthers    *userCenterView;


- (void) updateWithItem:(ListSeiJieItem *)item;

@end
