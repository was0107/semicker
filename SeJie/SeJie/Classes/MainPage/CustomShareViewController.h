//
//  CustomShareViewController.h
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "BaseWithRequestViewController.h"

@interface CustomShareViewController : BaseWithRequestViewController

@property (nonatomic, assign) int shareType;
@property (nonatomic, assign) id content;

- (id) initWithType:(int) type userName:(NSString *) name;

@end
