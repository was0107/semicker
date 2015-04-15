//
//  B5MNormalTableView.m
//  PrettyUtility
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "B5MNormalTableView.h"

@implementation B5MNormalTableView
@synthesize contentArray = _contentArray;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style 
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void) setupContentView
{
    self.dataSource = self;
    self.delegate = self;
    self.backgroundColor = kClearColor;
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_contentArray);
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.contentArray ? [self.contentArray count] : 0) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
