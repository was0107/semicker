//
//  TopFilterTableView.m
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "TopFilterTableView.h"
#import "TopFilterTableViewCell.h"
#import "LabelsManager.h"

@implementation TopFilterTableView
@synthesize block       = _block;
@synthesize cellContents = _cellContents;

- (void) setupContentView
{
    [super setupContentView];

    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackGroundImage]];
    self.rowHeight = kTopCellHeight;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (void) didMoveToSuperview
{
    if (self.superview) {
        [self setContentOffset:CGPointZero animated:NO];
        [self flashScrollIndicators];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.contentArray ? [self.contentArray count] : 0) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"_CELL";
    TopFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[TopFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    cell.block = self.block;
    
    if (self.cellContents) {
        cell.contentData = nil;
        cell.keywordLabel.hidden = NO;
        LabelItem *labelItem = [self.contentArray objectAtIndex:indexPath.row];
        
        if (![cell.keywordLabel.text isEqualToString:labelItem.labelName]) {
            cell.keywordLabel.text = labelItem.labelName;
        }
        cell.contents = self.cellContents;
    }
    else {
        cell.keywordLabel.hidden = YES;
        //3级子标签
        LabelItem *labelItem = [self.contentArray objectAtIndex:indexPath.row];
        DEBUGLOG(@"=== labelItem = %@ %@=", labelItem,labelItem.labelName);
        cell.contentData = labelItem;
    }
    
    return cell;
}


@end
