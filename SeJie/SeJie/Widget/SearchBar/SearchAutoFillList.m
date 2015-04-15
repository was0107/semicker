//
//  B5MAutoFillList.m
//  micker
//
//  Created by Jarry on 12-11-21.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "SearchAutoFillList.h"
#import "AutofillCell.h"
#import "AutofillListData.h"
#import "SearchData.h"
#import "WASDataBase.h"

#define kListItemHeight     40.0

@interface SearchAutoFillList () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView       *tableView;

@end

@implementation SearchAutoFillList

@synthesize tableView = _tableView;
@synthesize listData = _listData;
@synthesize selectBlock = _selectBlock;
@synthesize isHistory = _isHistory;

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    //_tableView.layer.cornerRadius = 8;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    
    _listData = [[NSMutableArray alloc] init];
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_listData);
    TT_RELEASE_SAFELY(_selectBlock);
    [super dealloc];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
//    NSInteger maxNum = 9;
//    if (iPhone5) {
//        maxNum = 11;
//    }
    _tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);// kListItemHeight * maxNum
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void) clearList
{
    [self.listData removeAllObjects];
    [self reloadData];
}

- (void)loadHistoryData
{
    [self.listData removeAllObjects];
    
    self.isHistory = YES;
    [self readHistoryData];
    [self reloadData];
}

- (void)readHistoryData
{
    [[WASDataBase sharedDBHelpter] setTableName:NSStringFromClass([SearchData class])];
    NSMutableArray *data = [[WASDataBase sharedDBHelpter] getAllData];
    for (NSDictionary *dic in data) {
        //SearchData *item = [[[SearchData alloc] init] autorelease];
        //item.keyword = [dic objectForKey:@"keyword"];
        [self.listData addObject:[dic objectForKey:@"keyword"]];
    }
}

#pragma mark - UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = self.listData.count;
    return num;
}

- (CGFloat)itemHeight
{
    return [self tableView:self.tableView heightForRowAtIndexPath:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kListItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView *backImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        [backImageView setImage:[[UIImage imageNamed:kSearchAutofillCellImg] stretchableImageWithLeftCapWidth:0.0f topCapHeight:0.0f]];
        cell.backgroundView = backImageView;
        
        UIImageView *selectedView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        [selectedView setImage:[[UIImage imageNamed:kSearchAutofillSelImage] stretchableImageWithLeftCapWidth:0.0f topCapHeight:0.0f]];
        cell.selectedBackgroundView = selectedView;
        
        
        AutofillCell *cellView = [[[AutofillCell alloc] initWithFrame:
                                   CGRectMake(5, 0, tableView.frame.size.width-10, [self itemHeight])] autorelease];
        cellView.nameLabel.textColor = kBlackColor;
        cellView.countLabel.textColor = kDarkGrayColor;
        cellView.tag = 101;
        [cell addSubview:cellView];
        
	}
    
    AutofillCell *cellView = (AutofillCell*)[cell viewWithTag:101];
    
    if (self.isHistory) {
        cellView.nameLabel.text = [self.listData objectAtIndex:indexPath.row];
        cellView.countLabel.text = @"";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;

    if (indexPath.row < self.listData.count) {
        AutofillDataItem *item = [self.listData objectAtIndex:indexPath.row];
        cellView.nameLabel.text = item.name;
        cellView.countLabel.text = [NSString stringWithFormat:@"约%ld个结果", item.count];
    }
    else {
        cellView.nameLabel.text = @"";
        cellView.countLabel.text = @"";
    }
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!self.isHistory) {
        return 0;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{    
    UIView * footerView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    footerView.backgroundColor = kClearColor;
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"search_list_btn_clear"]
                              forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearButtonAction)
             forControlEvents:UIControlEventTouchUpInside];
    [clearButton setFrame:CGRectMake(13, 15, 294, 36)];
    [footerView addSubview:clearButton];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.row < self.listData.count) {
        
        if (!self.isHistory) {
            AutofillDataItem *item = [self.listData objectAtIndex:indexPath.row];
            if (self.selectBlock) {
                self.selectBlock(item.name);
            }
        }
        else {
            if (self.selectBlock) {
                self.selectBlock([self.listData objectAtIndex:indexPath.row]);
            }
        }
    }
}

#pragma mark - clearButtonAction
- (void)clearButtonAction
{
    [[WASDataBase sharedDBHelpter] setTableName:NSStringFromClass([SearchData class])];
    [[WASDataBase sharedDBHelpter] deleteAll:nil];

    [_listData removeAllObjects];
    [self reloadData];
}

@end
