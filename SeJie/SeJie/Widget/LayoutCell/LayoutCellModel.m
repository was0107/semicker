//
//  LayoutCellModel.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "LayoutCellModel.h"

#define kContent1X(x)          (kLayoutCellItemWidth * (x) + kCellLeftGap + kCellBetweenGap * (x))


@implementation LayoutItemBase
@synthesize itemHeight = _itemHeight;
@synthesize itemWidth  = _itemWidth;
@synthesize itemDefault= _itemDefault;
@synthesize itemRect   = _itemRect;
@synthesize content    = _content;

+(id) itemWidht:(NSUInteger)width height:(NSUInteger)height rect:(CGRect) rect  defalut:(NSUInteger) defalut
{
    LayoutItemBase *base = [[[LayoutItemBase alloc] init] autorelease];
    base.itemWidth = width;
    base.itemHeight= height;
    base.itemRect  = rect;
    base.itemDefault = defalut;
    return base;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_content);
    [super dealloc];
}
@end;

@implementation LayoutCellModelBase
@synthesize itemsHeight = _itemsHeight;

- (NSMutableArray *) items
{
    return nil;
}

- (NSUInteger) count
{
    return 0;
}
- (void) dealloc
{
    TT_RELEASE_SAFELY(_items);
    [super dealloc];
}
@end;


///////////////////////////////////one column///////////////////////////////////////////

@implementation LayoutCellModelOneColumn

- (NSUInteger) itemsHeight
{
    return 1;
}

- (NSUInteger) count
{
    return 1;
}



@end
@implementation LayoutCellModelOneColumn1

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray arrayWithObject:[LayoutItemBase itemWidht:3 height:1 rect:CGRectMake(kLeftX1, kCellBetweenGap, kBigWidth, kLayoutCellItemtHeight)  defalut:1]] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 1;
}

@end

@implementation LayoutCellModelOneColumn2
- (NSMutableArray *)items
{
    
    if (!_items) {
        _items =  [[NSMutableArray arrayWithObjects:
                    [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftX1, kCellBetweenGap, kWidth1, kLayoutCellItemtHeight)  defalut:1],
                    [LayoutItemBase itemWidht:2 height:1 rect:CGRectMake(kLeftX2, kCellBetweenGap, 198, kLayoutCellItemtHeight)  defalut:2],
                    nil] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 2;
}
@end

@implementation LayoutCellModelOneColumn3
- (NSMutableArray *)items
{
    
    if (!_items) {
        _items =  [[NSMutableArray arrayWithObjects:
                    [LayoutItemBase itemWidht:2 height:1 rect:CGRectMake(kLeftX1, kCellBetweenGap, 198, kLayoutCellItemtHeight)  defalut:2],
                    [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(198 + kCellBetweenGap + kLeftX1, kCellBetweenGap, kWidth1, kLayoutCellItemtHeight) defalut:1],
                    nil] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 2;
}

@end

@implementation LayoutCellModelOneColumn4
- (NSMutableArray *)items
{
    if (!_items) {
        _items =  [[NSMutableArray arrayWithObjects:
                    [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftX1, kCellBetweenGap, kWidth1, kLayoutCellItemtHeight)  defalut:1],
                    [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftX2, kCellBetweenGap, kWidth1, kLayoutCellItemtHeight)  defalut:1],
                    [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftX3, kCellBetweenGap, kWidth1, kLayoutCellItemtHeight)  defalut:1],
                    nil] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 3;
}

@end

@implementation LayoutCellModelOneColumn5

- (NSMutableArray *)items
{
    
    if (!_items) {
        _items = [[NSMutableArray arrayWithObjects:
                   [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(10,  5, 145, 94)  defalut:1],
                   [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(165, 5, 145, 94)  defalut:1],
                   nil] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 2;
}

@end

///////////////////////////////////two columns///////////////////////////////////////////

@implementation LayoutCellModelTwoColumns

- (NSUInteger) itemsHeight
{
    return 2;
}

- (NSUInteger) count
{
    return 1;
}

@end



@implementation LayoutCellModelTwoColumns1 
- (NSMutableArray *)items
{
    if (!_items) {
        _items =  [[NSMutableArray arrayWithObjects:
                   [LayoutItemBase itemWidht:2 height:2 rect:CGRectMake(kLeftX1, kCellBetweenGap, kBigWidth, 3 * kLayoutCellItemtHeight )  defalut:3],
                    nil] retain];
    }
    return _items;
}

- (NSUInteger) itemsHeight
{
    return 3;
}

- (NSUInteger) count
{
    return 1;
}

@end

@implementation LayoutCellModelTwoColumns2 
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray arrayWithObjects:
                   [LayoutItemBase itemWidht:2 height:2 rect:CGRectMake(kLeftExX1, kCellBetweenGap, kWidthEx2, 2 * kLayoutCellItemtHeight) defalut:2],
                   [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftExX3, kCellBetweenGap, kLayoutCellItemWidth, kLayoutCellItemtHeight-2) defalut:1],
                   [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftExX3, kCellBetweenGap*2 + kLayoutCellItemtHeight-2, kLayoutCellItemWidth, kLayoutCellItemtHeight-2) defalut:1],
                   nil] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 3;
}

@end

@implementation LayoutCellModelTwoColumns3 
- (NSMutableArray *)items
{
    
    if (!_items) {
        _items = [[NSMutableArray arrayWithObjects:
                  [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftExX1,  kCellBetweenGap, kLayoutCellItemWidth, kLayoutCellItemtHeight-2)  defalut:1],
                  [LayoutItemBase itemWidht:1 height:1 rect:CGRectMake(kLeftExX1,  kCellBetweenGap*2 + kLayoutCellItemtHeight-2, kLayoutCellItemWidth, kLayoutCellItemtHeight-2)  defalut:1],
                  [LayoutItemBase itemWidht:1 height:2 rect:CGRectMake(kLeftExX2-5,  kCellBetweenGap, kWidthEx2, 2 * kLayoutCellItemtHeight)  defalut:2],
                   nil] retain];
    }
    return _items;
}

- (NSUInteger) count
{
    return 3;
}

@end


@implementation LayoutCellModel
@synthesize currentIndex = _currentIndex;
@synthesize contentArray = _contentArray;
@synthesize typeArray    = _typeArray;

- (void) setContentArray:(NSMutableArray *)contentArray
{
    if (_contentArray != contentArray) {
        [_contentArray release];
        _contentArray = [contentArray retain];
    }
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_contentArray);
    TT_RELEASE_SAFELY(_typeArray);
    [super dealloc];
}


- (void) resetData
{
    if (_typeArray) {
        [_typeArray removeAllObjects];
        TT_RELEASE_SAFELY(_typeArray);
    }
    self.currentIndex = 1 ;
    index = 0 ;
}

- (void) computePosition
{
    // do nothing
}


@end

@implementation LayoutCellShejieModel

- (void) computePosition
{
    NSUInteger total = [self.contentArray count];
    
    if (!self.typeArray) {
        self.typeArray = [NSMutableArray arrayWithCapacity:total];
    }
    NSUInteger left = 0;
    LayoutCellModelBase *base = nil;
    index = 0;
    
    static int layouts[] = {2,3,0,1};
    NSUInteger typeOneOrTwo = 0, postion = 0;
    while (self.currentIndex < total) {
        left = total - self.currentIndex;
        typeOneOrTwo = index % 4 ;
        
        if (left < 3)
        {
            typeOneOrTwo = 3;
        }
        postion = layouts[typeOneOrTwo];
        switch (postion) {
            case 0:
            {
                base = [[[LayoutCellModelOneColumn4 alloc] init] autorelease];
            }
                break;
            case 1:
            {
                base = [[[LayoutCellModelTwoColumns1 alloc] init] autorelease];
            }
                break;
            case 2:
            {
                base = [[[LayoutCellModelTwoColumns2 alloc] init] autorelease];
            }
                break;
            case 3:
            {
                base = [[[LayoutCellModelTwoColumns3 alloc] init] autorelease];
            }
                break;
            default:
            {
                base = [[[LayoutCellModelTwoColumns1 alloc] init] autorelease];
            }
                break;
        }
        
        for (NSUInteger i = 0 ; i < [base count]; i++) {
            LayoutItemBase *item = (LayoutItemBase *)[base.items objectAtIndex:i];
            item.content = [self.contentArray objectAtIndex: (self.currentIndex + i)];
        }
        index = index + 1;
        [self.typeArray addObject:base];
        self.currentIndex += [base count];
    }
}

@end

@implementation LayoutCellExploreModel

- (void) computePosition
{
    NSUInteger total = [self.contentArray count];
    
    if (!self.typeArray) {
        self.typeArray = [NSMutableArray arrayWithCapacity:total];
    }

    LayoutCellModelBase *base = nil;

    while (self.currentIndex < total) {
        base = [[[LayoutCellModelOneColumn5 alloc] init] autorelease];
        
        for (NSUInteger i = 0 ; i < [base count]; i++) {
            LayoutItemBase *item = (LayoutItemBase *)[base.items objectAtIndex:i];
            if (self.currentIndex + i < total) {
                item.content = [self.contentArray objectAtIndex: (self.currentIndex + i)];
            }
        }
        [self.typeArray addObject:base];
        self.currentIndex += [base count];
    }    
}


@end
