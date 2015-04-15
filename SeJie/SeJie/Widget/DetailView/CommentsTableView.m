//
//  CommentsTableView.m
// sejieios
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "CommentsTableView.h"
#import "CommentsTableViewCell.h" 

@implementation CommentsTableView
@synthesize block = _block;
@synthesize firstCellHeight = _firstCellHeight;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (void) didSetContentArray
{
    [self reloadData];
    
    if (self.totalCount == 0) {
        [self setFrameHeight:0];
    } else if (self.contentSize.height < kBoundsHeight - 20) {
        [self setFrameHeight:self.contentSize.height];
    } else {
        [self setFrameHeight:kBoundsHeight - 20];
    }
    
    self.block ? self.block(nil) : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 26;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 26)] autorelease];
    label.text = @"  用户评论";
    label.font = TNRFontSIZEBIG(kFontSize14);
    label.textColor = kDarkGrayColor;
    label.backgroundColor = kClearColor;
    return label;
}


- (int) computeHeight:(NSString *) content
{
    CGSize size = CGSizeMake(250, 2000);
    CGSize titleSize = [content sizeWithFont:TNRFONTSIZE(kFontSize13)
                          constrainedToSize:size
                              lineBreakMode:NSLineBreakByTruncatingTail];
    
    return MAX(60, titleSize.height + 30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.totalCount == 0) {
        return 34;
    }
    
    ListCommentItem *commentItem = [self.contentArray objectAtIndex:indexPath.row];
    return [self computeHeight:commentItem.text];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.totalCount == 0 ) ?  1 : self.totalCount ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalIdentifier = @"normalIdentifier";
    static NSString *emptyIdentifier  = @"emptyIdentifier";
    if (self.totalCount == 0 ) {
        CommentsTableViewEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:emptyIdentifier];
        if (!cell)
        {
            cell = [[[CommentsTableViewEmptyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:emptyIdentifier] autorelease];
        }
        return cell;
    }
    else
    {
        CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalIdentifier];
        if (!cell){
            cell = [[[CommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalIdentifier] autorelease];
        }
        cell.commentItem = [self.contentArray objectAtIndex:indexPath.row];
        return cell;
    }
}


@end
