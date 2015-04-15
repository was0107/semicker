//
//  SearchData.m
//  micker
//
//  Created by Jarry on 12-11-24.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "SearchData.h"

@implementation SearchData

@synthesize keyword = _keyword;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_keyword);
    [super dealloc];
}

@end
