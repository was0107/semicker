//
//  FilterView.m
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "FilterView.h"
#import "WASBorderLayout.h"
#import "UIView+Shadow.h"
#import "LabelsManager.h"

@interface FilterListTableViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *tipLabel;

@end

@implementation FilterListTableViewCell
@synthesize tipLabel = _tipLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kFilterLevelTwoSelImage]] autorelease];
        //self.selectedTextColor = kBlackColor;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 160, 36)];
        _tipLabel.font = TNRFontSIZEBIG(kFontSize14);
        _tipLabel.backgroundColor = kClearColor;
        _tipLabel.textColor = kDarkGrayColor;
        [self.contentView addSubview:_tipLabel];

    }
    return self;
}
- (void) dealloc
{
    TT_RELEASE_SAFELY(_tipLabel);
    [super dealloc];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    self.textLabel.textColor = kBlackColor;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(50, 0, 160, 36);
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];    
    UIImage *imgae = [UIImage imageNamed:kFilterLineImage];
    [imgae drawInRect:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
//    [imgae drawAsPatternInRect:CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 2)];
}


@end

@interface FilterView()<UITableViewDataSource, UITableViewDelegate>
{
    int oldType, newType;
}

@end

@implementation FilterView
@synthesize topView = _topView;
@synthesize tableView = _tableView;
@synthesize bottomView = _bottomView;
@synthesize block           = _block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        WASBorderLayout *borderLayout = [[[WASBorderLayout alloc] init] autorelease];
        
        [self setLayoutManager:borderLayout];
        [self add:WASBorderLayout.NORTH  withComponet:self.topView];
        [self add:WASBorderLayout.SOURTH withComponet:self.bottomView];
        [self add:WASBorderLayout.CENTER withComponet:self.tableView];
 
        [self addBottomShadow];

        
        [[LabelsManager sharedInstance] getMainLabelList];
        oldType = newType = eSheJieNormal;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotifiCation:) name:kSejieUpdateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(typeChanged:) name:kSeJieTypeChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexTypeChanged:) name:kSeJieSexTypeChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTheData:) name:kExplorerTwoReloadNotification object:nil];
    }
    return self;
}

- (FilterTopView *) topView
{
    if (!_topView) {
        _topView = [[FilterTopView alloc] initWithFrame:CGRectMake(0, 0, kFilterViewWidth, 100)];
        [_topView.itemSejie doExchangeImage];
        
    }
    return _topView;
}

- (FilterBottomView *) bottomView
{
    if (!_bottomView) {
        _bottomView = [[FilterBottomView alloc] initWithFrame:CGRectMake(0, 0, kFilterViewWidth, 100)];
    }
    return _bottomView;
}

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = 36.0f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kClearColor;
        
        _tableView.backgroundView = [[[UIImageView alloc] initWithImage:[[UIImage imageNamed:kFilterLevelTwoCellImg]
                                                                         stretchableImageWithLeftCapWidth:40
                                                                         topCapHeight:4]] autorelease];
        _tableView.separatorColor = kClearColor;
    }
    return _tableView;
}
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_topView);
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (void) setBlock:(intIdBlock)block
{
    if (_block != block) {
        [_block release];
        _block = [block copy];
        _topView.block = _block;
        _bottomView.block = _block;
    }
}

- (FilterTopViewItem *) itemAt:(const int) type
{
    switch (type)
    {
        case eSheJieNormal:
            return _topView.itemSejie;
        case eSheJieExplorFirst:
            return _topView.itemFind;
        case eSheJieExplorSecond:
            return _topView.itemFind;
        case eSheJieSearch:
            return _bottomView.searchView;
        case eSheJieUserCenter:
            return nil;
        default:
            return _topView.itemSejie;
    }
}

- (void) doChange
{
    if (newType != oldType) {
        FilterTopViewItem *newItem = [self itemAt:newType];
        FilterTopViewItem *oldItem = [self itemAt:oldType];
        if (newItem) {
            [newItem doExchangeImage];
        }
        if (oldItem) {
            [oldItem doExchangeImage];
        }
        oldType  = newType;
        //[self showUpdateTipView:(newType != eSheJieNormal)];
    }
}

- (void)typeChanged:(NSNotification *)notification
{
    newType = [notification.object intValue];
    [self doChange];
}

- (void) showUpdateTipView:(BOOL)show
{
    if (show) {
        [self.topView.itemSejie.tipImageView showViewAnimated];
    }
    else {
        self.topView.itemSejie.tipImageView.alpha = 0.0f;
    }
}

- (void) updateNotifiCation:(NSNotification *)notification
{    
    if (!notification.object) {
        [self showUpdateTipView:NO];
        [self.topView.itemSejie.tipImageView setUpdateText:kEmptyString];
        return;
    }
    [self.topView.itemSejie.tipImageView setUpdateText:notification.object];
    [self showUpdateTipView:(newType != eSheJieNormal)];
}

- (void) sexTypeChanged:(NSNotification *)notification
{
    NSNumber *number = notification.object;
    [[LabelsManager sharedInstance] resetData:number.integerValue];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void) reloadTheData:(NSNotification *) notification
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


#pragma mark ==
#pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LabelsManager sharedInstance] getMainLabelList].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"_CELL";
    FilterListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[FilterListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    NSArray *labelList = [[LabelsManager sharedInstance] getMainLabelList];
    cell.tipLabel.text = [[labelList objectAtIndex:indexPath.row] labelName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LabelItem *itemData = [[[LabelsManager sharedInstance] getMainLabelList] objectAtIndex:indexPath.row];
    [LabelsManager sharedInstance].currentItem = itemData;
    // 一级标签查看 PV
    [[DataTracker sharedInstance] trackEvent:TD_EVENT_NAVI_CLASS1_PV withLabel:itemData.labelName category:TD_EVENT_Category];
    
    if (self.block) {
        self.block(eSheJieExplorSecond, itemData.labelName);
    }
}


@end
