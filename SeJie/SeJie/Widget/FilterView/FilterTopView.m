//
//  FilterTopView.m
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "FilterTopView.h"

@implementation FilterTopView
@synthesize itemSejie = _itemSejie;
@synthesize itemFind  = _itemFind;
@synthesize block     = _block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        [self addSubview:self.itemSejie];
        [self addSubview:self.itemFind];
    }
    return self;
}

- (FilterTopViewItem *) itemSejie
{
    if (!_itemSejie) {
        _itemSejie = [[FilterTopViewItem alloc] initWithFrame:CGRectMake(0, 0, kFilterViewWidth, 50)];
        _itemSejie.textLabel.text = kTitleSejieString;
        _itemSejie.detailLabel.text = kTitleSejieStringEx;
        [_itemSejie addSubview:_itemSejie.tipImageView];
        [_itemSejie setNormalImage:kFilterNormalImg hilighted:kFilterNormalHilighted selectedImage:kFilterNormalSelectedImg];
        [_itemSejie addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemSejie;
}

- (FilterTopViewItem *) itemFind
{
    if (!_itemFind) {
        _itemFind = [[FilterTopViewItem alloc] initWithFrame:CGRectMake(0, 50, kFilterViewWidth, 50)];
        _itemFind.textLabel.text = kTitleDiscoveryString;
        _itemFind.detailLabel.text = kTitleDiscoveryStringEx;
        _itemFind.leftImageView.image = [UIImage imageNamed:@"main_left_icon"];

        [_itemFind setNormalImage:kFilterExplorerImg hilighted:kFilterExplorerHilighted selectedImage:kFilterExplorerSelectedImg];
        [_itemFind addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _itemFind;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_itemSejie);
    TT_RELEASE_SAFELY(_itemFind);
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (IBAction)action:(id)sender
{
    FilterTopViewItem *item = (FilterTopViewItem *) sender;
    if (self.block) {
        self.block((item == _itemSejie) ? eSheJieNormal : eSheJieExplorFirst , nil);
    }
}

@end
