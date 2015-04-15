//
//  TopFilterTableViewCell.m
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "TopFilterTableViewCell.h"
#import "UIButton+extend.h"
#import "LabelItem.h"
#import "LabelsManager.h"

@interface FilterButton : UIButton

@property (nonatomic, assign) id            content;
@property (nonatomic, assign) NSUInteger    index;

@end

@implementation FilterButton

@synthesize content = _content;
@synthesize index = _index;

@end

@interface TopFilterTableViewCell()
@property (nonatomic, retain) WASContainer *container;
@end

@implementation TopFilterTableViewCell
@synthesize contents    = _contents;
@synthesize container   = _container;
@synthesize contentData = _contentData;
@synthesize block       = _block;
@synthesize keywordLabel = _keywordLabel;

- (void) setupContentView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.container = [[[WASContainer alloc] initWithFrame:CGRectMake(118, 2, 190, 100)] autorelease];
    WASFlowLayout *flowLayout = (WASFlowLayout *) self.container.layoutManager;
    flowLayout.newAlign = WASFlowLayout.LEFT;
    
    [self.contentView addSubview:self.container];
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesutre = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTaped:)] autorelease];
    [self.imageView addGestureRecognizer:tapGesutre];
    
    //
    _keywordLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 68, 44, 20)];
    _keywordLabel.backgroundColor = kClearColor;
    _keywordLabel.text = @"";
    _keywordLabel.textColor = kWhiteColor;
    _keywordLabel.font = TNRFontSIZEBIG(kFontSize13);
    _keywordLabel.textAlignment = NSTextAlignmentCenter;
    _keywordLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_keywordLabel];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_contents);
    TT_RELEASE_SAFELY(_container);
    TT_RELEASE_SAFELY(_block);
    TT_RELEASE_SAFELY(_keywordLabel);
    [super reduceMemory];
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIImage *imgae = [UIImage imageNamed:kTopFilterCellBgImge];
    [imgae drawAsPatternInRect:CGRectMake(0, 0, 320, kTopCellHeight)];
}

- (void) prepareForReuse
{
    [super prepareForReuse];
//    [self.imageView cancelDownloadImage];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(5, 3, 110, 98)];
}

- (void) setContentData:(id)contentData
{
    _contentData = contentData;
    if (!_contentData) {
        self.imageView.image = [UIImage imageNamed:@"search_filter_tag_bg"];
        return;
    }
    LabelItem *labelItem = _contentData;
    
    __block typeof(self) weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:labelItem.imageUrl]
                      placeholderImage:[UIImage imageNamed:@"search_filter_tag_bg"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if (!error) {
                                     weakSelf.imageView.image = image;//[image imageScaledToSize:CGSizeMake(220, 100)];
                                 }
    }];
    
    [self.imageView emptySubviews];
    
    if (labelItem.isSelected) {
        UIImageView *tipImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(87, 70, 16, 16)] autorelease];
        tipImageView.image = [UIImage imageNamed:kTopFilterImageSelectImage];
        [self.imageView addSubview:tipImageView];
    }
    
    
    self.contents = [[LabelsManager sharedInstance] getSubLabelList:2 title:labelItem.labelName];
}

- (void) setContents:(NSMutableArray *)contents
{
    if (_contents != contents) {
        [_contents release];
        _contents = [contents retain];
    }
    [self.container removeAll];
    CGRect rect = CGRectMake(0, 0, 58, 27);
    
    for (NSUInteger i = 0,total = [_contents count];  i < total && i < 9; i++) {
        
        LabelItem *labelItem = (LabelItem*)[_contents objectAtIndex:i];
        NSString *text = [labelItem labelName];
        
        FilterButton *button = [FilterButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        [button setTitle:text forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.font = TNRFONTSIZE(kFontSize12);
        
        [button setTitleColor:(labelItem.isSelected ? kOrangeColor:kDarkGrayColor) forState:UIControlStateNormal];
        [button setTitleColor:kOrangeColor forState:UIControlStateSelected];
        [button setTitleColor:kOrangeColor forState:UIControlStateHighlighted];
        [button setBackgroundImage:(labelItem.isSelected ? kTopFilterCellSelected:kTopFilterCellBtn) selectedImage:kTopFilterCellSelected clickImage:kTopFilterCellSelected];
        button.index = i;
        button.content = text;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.container add:button];
    }

}

- (IBAction)buttonAction:(id)sender
{
    FilterButton *button = (FilterButton *)sender;
    
    LabelItem *subItem = (LabelItem*)[_contents objectAtIndex:button.index];
    subItem.isSelected = YES;
    if (self.block) {
        if (!self.contentData) {    //search
            self.block(button.content);
            return;
        }
        
        [[LabelsManager sharedInstance].currentItem resetState];
        [LabelsManager sharedInstance].currentItem = subItem;
        LabelItem *labelItem = _contentData;
        NSString *label = [NSString stringWithFormat:@"%@>%@",labelItem.labelName, button.content];
        self.block(label);
        // 三级标签查看 PV
        [[DataTracker sharedInstance] trackEvent:TD_EVENT_EXPLORE_CLASS3_PV withLabel:label category:TD_EVENT_Category];        
    }
}

- (void) didTaped:(UIGestureRecognizer *)gesture
{
    if (self.block) {
        if (!self.contentData) {    //search
            self.block(nil);
            return;
        }
        
        LabelItem *labelItem = _contentData;
        labelItem.isSelected = YES;
        [[LabelsManager sharedInstance].currentItem resetState];
        [LabelsManager sharedInstance].currentItem = labelItem;
        self.block(labelItem.labelName);
        // 二级标签查看 PV
        [[DataTracker sharedInstance] trackEvent:TD_EVENT_EXPLORE_CLASS2_PV withLabel:labelItem.labelName category:TD_EVENT_Category];
    }
}
@end
