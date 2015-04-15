//
//  MainViewController.h
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "BaseWithRequestViewController.h"
#import "UserCenterView.h"

@interface MainViewController : BaseWithRequestViewController
@property (nonatomic, retain) UserCenterView            *userCenterView;


- (BOOL) isUserCenterView;

@end
