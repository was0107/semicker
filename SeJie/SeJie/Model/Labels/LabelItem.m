//
//  LabelItem.m
// sejieios
//
//  Created by Jarry on 13-1-7.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "LabelItem.h"

@implementation LabelItem

@synthesize labelName = _labelName;
@synthesize imageUrl = _imageUrl;
@synthesize superLabel = _superLabel;
@synthesize level   = _level;
@synthesize urlName = _urlName;
@synthesize isSelected = _isSelected;

- (void) resetState
{
    self.isSelected = NO;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_labelName);
    TT_RELEASE_SAFELY(_imageUrl);
    TT_RELEASE_SAFELY(_urlName);
    TT_RELEASE_SAFELY(_superLabel);
    [super dealloc];
}

@end
