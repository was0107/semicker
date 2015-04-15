//
//  SearchViewController.h
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import "BaseTitleViewController.h"

@interface SearchViewController : BaseTitleViewController

@property (nonatomic, copy) NSString    *keyword;
@property (nonatomic, copy) idBlock     completeBlock;
@property (nonatomic, copy) voidBlock   cancelBlock;


@end
