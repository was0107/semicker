//
//  ExplorerTableView.m
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "ExplorerTableView.h"
#import "LayoutExplorerCell.h"
#import "LabelsManager.h"
#import "ListSeiJieItem.h"
#import "UserDefaultsManager.h"

@implementation ExplorerTableView

- (void) setupContentView
{
    [super setupContentView];
    self.allowTopButton = NO;

    self.rowHeight = kLayoutCellItemtHeight + 10;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexTypeChanged:) name:kSeJieSexTypeChangedNotification object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void) sexTypeChanged:(NSNotification *)notification
{
    NSNumber *number = notification.object;
    [[LabelsManager sharedInstance] resetData:number.integerValue];
    [self getSourceData];
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void) getSourceData
{
    NSMutableArray *labelList = [[LabelsManager sharedInstance] getMainLabelList];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSUInteger i = 0 ; i < labelList.count; i++) {
        
        LabelItem *labelItem = [labelList objectAtIndex:i];
        ListSeiJieItemBase *item = [[[ListSeiJieItemBase alloc] init] autorelease];
        item.img = labelItem.imageUrl;//labelItem.labelName;//kIntToString(i%11+1);
        item.title = labelItem.labelName;
        [imageArray addObject:item];
    }
    
    Class model = NSClassFromString(self.adapterBase.modelClass);
    self.cellModel = [[[model alloc] init] autorelease];
    self.cellModel.contentArray = imageArray;
    [self.cellModel computePosition];
    self.contentArray = self.cellModel.typeArray;

}

- (void) doSendRequest:(BOOL)flag
{
    [self getSourceData];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.contentArray ? [self.contentArray count] : 0) ;//5;//
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"_CELL";
    LayoutExplorerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[LayoutExplorerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    cell.layoutType = [self.contentArray objectAtIndex:indexPath.row];
    cell.block = self.adapterBase.cellBlock;
    return cell;
}

@end
