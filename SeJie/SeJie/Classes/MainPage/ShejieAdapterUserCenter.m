//
//  ShejieAdapterUserCenter.m
// sejieios
//
//  Created by Jarry on 13-1-22.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ShejieAdapterUserCenter.h"

@implementation ShejieAdapterUserCenter

@synthesize userCenterView = _userCenterView;

- (void) setContentData
{
    [super setContentData];
    
    self.pageViewId     = TD_PAGE_USERCENTER;
    self.title          = kTitleMySejieString;
    self.headerBlock    = nil;
    self.rightButtonHidden = NO;
}

- (UIView *) contentView
{
    return self.userCenterView;
}

- (void) removeTopButton
{
    [self.userCenterView.toTopButton setHidden:YES];
}

- (void) sendRequestToServer
{
    [self.userCenterView clearData];
    [self.userCenterView updateMyAccount];
}

@end
