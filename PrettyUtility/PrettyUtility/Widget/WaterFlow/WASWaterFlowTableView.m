//
//  WASWaterFlowTableView.m
//  micker
//
//  Created by allen.wang on 8/15/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASWaterFlowTableView.h"
#import "WASWaterFlowTableView_private.h"
//#import "ListPadDefines.h"

@implementation WASWaterFlowTableView
@synthesize cellColumnInfos     = _cellColumnInfos;
@synthesize visibleCells        = _visibleCells;
@synthesize reusableCells       = _reusableCells;
@synthesize waterFlowDatasource = _waterFlowDatasource;
@synthesize headerHeight        = _headerHeight;
@synthesize cellViewGap         = _cellViewGap;
@synthesize rightMargin         = _rightMargin;
@synthesize backgroundView      = _backgroundView;
@synthesize currentIndex        = _currentIndex;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
                
        [self setCellViewGap:DEFAULT_CELL_RIGHT_MARGIN];
        [self setRightMargin:DEFAULT_RIGHT_MARGIN];        
        _currentIndex = 0;
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _waterFlowDatasource    = nil;
    
    [_visibleCells removeAllObjects];
    [_reusableCells removeAllObjects];
    [_cellColumnInfos removeAllObjects];
    
    [_visibleCells release],    _visibleCells   = nil;
    [_reusableCells release],   _reusableCells  = nil;
    [_cellColumnInfos release], _cellColumnInfos= nil;
    [_backgroundView release],  _backgroundView = nil;
    
    [super dealloc];
}
- (WASWaterFlowCell*) dequeueReusableCellWithIdentifier:(NSString*)identifier {
    WASWaterFlowCell* petalView = [self popReusableCellViewWithIdentifier:identifier];
    
    [petalView prepareForReuse];
    
    return petalView;
}


- (void) scrollToSelectedIndex
{
    if (0 ==_numberOfColumns || 0 == _currentIndex) {
        return;
    }
    NSUInteger row = _currentIndex / _numberOfColumns;
    NSUInteger col = _currentIndex % _numberOfColumns;
    WASWaterFlowPathInfo* pathInfo = (WASWaterFlowPathInfo*) [[self cellColumnInfos] objectAtIndex:col];
    WASWaterFlowCellInfo* cellInfo = [pathInfo waterFlowCellInfoForRow:row];
    [self scrollRectToVisible:cellInfo.frame animated:NO];
}


- (void) reloadData {
    // Removes old petal views.
    [self removeAllVisibleCellViews];
    [self setReusableCells:nil];
    
    // Resets path count, path widths and heights, as well as content size.
    [self prepareParametersNeededForLayout];
    [self resetContentSizeByAppendingCellViews];
    
    // Scrolls to top and tiles new petal views.
    [self flashScrollIndicators];
    if ([self currentIndex] <= _numberOfColumns) {
            [self setContentOffset:CGPointZero];
    }
    else {
        [self scrollToSelectedIndex];
    }    
    
    [self setNeedsLayout];
}

- (void) appendCells {
    [self resetContentSizeByAppendingCellViews];
    [self setNeedsLayout];
}

- (void) setBackgroundView:(UIView*)backgroundView {
    if (backgroundView != _backgroundView) {
        if ([_backgroundView superview] == self) {
            [_backgroundView removeFromSuperview];
        }
        
        _backgroundView = backgroundView;
        [_backgroundView setFrame:[self bounds]];
        [self addSubview:_backgroundView];
    }
}


- (NSUInteger) firstCellInVisble
{
    return [self firstCellInVisbleColumn:0];
}

- (NSUInteger) firstCellInVisbleColumn:(NSUInteger) col
{
    if ([[self visibleCells] count] <= 0) {
        return 0;
    }
    NSMutableArray* cellViews = [[self visibleCells] objectAtIndex:0];
    if ([cellViews count] <= 0) {
        return 0;
    }
    NSInteger firstRow = [[[[cellViews objectAtIndex:0] layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
    return firstRow;
}

- (NSUInteger) lastCellInVisbleColumn:(NSUInteger) col
{
    if ([[self visibleCells] count] <= 0) {
        return 0;
    }
    NSMutableArray* cellViews = [[self visibleCells] objectAtIndex:col];
    return [cellViews count];
}

- (void) updateTileColumn:(NSUInteger) column row:(NSUInteger) row withOffsetY:(CGFloat) y animatin:(BOOL) flag
{
    WASWaterFlowPathInfo* pathInfo = (WASWaterFlowPathInfo*) [[self cellColumnInfos] objectAtIndex:column];
    [pathInfo changeWaterFlowCellFrame:row withOffsetY:y animatin:flag];
        
    if ([self infoOfHighestCell].height < (pathInfo.height + [self cellViewGap])) {
        CGSize size = CGSizeMake([self contentSize].width, (pathInfo.height + [self cellViewGap] + kContentSizeExtendHeight));
        [self setValue:[NSValue valueWithCGSize:size] forKeyPath:@"contentSize"];
    }

    NSMutableArray* cellViews = [[self visibleCells] objectAtIndex:[pathInfo column]];
    __block int length = [cellViews count] - 1 ;
    [UIView animateWithDuration:flag?0.25:0
                     animations:^{
        while (length > 0) 
        {
            WASWaterFlowCell* cell = [cellViews objectAtIndex:length--];
            NSInteger row = [[[cell layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
            CGRect petalViewFrame = [[pathInfo waterFlowCellInfoForRow:row] frame];
            cell.frame = petalViewFrame;
        }
    }];
}

- (NSMutableDictionary*) reusableCells {
    if (!_reusableCells) {
        _reusableCells = [[NSMutableDictionary dictionaryWithCapacity:0] retain];
    }
    return _reusableCells;
}

#pragma mark - UIView methods

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds   = [self bounds];
    CGFloat minY    = CGRectGetMinY(bounds);
    CGFloat maxY    = CGRectGetMaxY(bounds);
    
    [self.backgroundView setFrame:bounds];
    
    [[self cellColumnInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        [self tileCellViewsOnPath:((WASWaterFlowPathInfo*) obj) minimumY:minY maximumY:maxY];
    }];
    
    // Always enables scrolling.
    CGSize contentSize = [self contentSize];    
    if (contentSize.height <= [self bounds].size.height - kContentSizeExtendHeight) {
        contentSize.height = [self bounds].size.height ;
        [self setValue:[NSValue valueWithCGSize:contentSize] forKeyPath:@"contentSize"];
    }
}

@end

#pragma mark  WASWaterFlowTableView(InternalMethods)

@implementation WASWaterFlowTableView(InternalMethods)

#pragma mark - Public static methods

+ (void) reverseArray:(NSMutableArray*)array {
    for (NSInteger i = 0, j = [array count] - 1; i < j; ++i, --j) {
        id tmp1 = [array objectAtIndex:i];
        id tmp2 = [array objectAtIndex:j];
        
        [array replaceObjectAtIndex:i withObject:tmp2];
        [array replaceObjectAtIndex:j withObject:tmp1];
    }
}

#pragma mark - Private methods


- (WASWaterFlowPathInfo*) infoOfShortestCell 
{
    __block WASWaterFlowPathInfo* bestPathInfo = nil;
    __block CGFloat minValue = 0.0f;
    
    [[self cellColumnInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) 
    {
        WASWaterFlowPathInfo* pathInfo = (WASWaterFlowPathInfo*) obj;
        
        if (bestPathInfo == nil || [pathInfo height] < minValue)
        {
            bestPathInfo = pathInfo;
            minValue = [pathInfo height];
        }
    }];
    
    return bestPathInfo;
}

- (WASWaterFlowPathInfo*) infoOfHighestCell 
{
    __block WASWaterFlowPathInfo* bestPathInfo = nil;
    __block CGFloat maxValue = 0.0f;
    
    [[self cellColumnInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) 
    {
        WASWaterFlowPathInfo* pathInfo = (WASWaterFlowPathInfo*) obj;
        
        if (!bestPathInfo || [pathInfo height] > maxValue) 
        {
            bestPathInfo = pathInfo;
            maxValue = [pathInfo height];
        }
    }];
    
    return bestPathInfo;
}



- (void) prepareParametersNeededForLayout {
    if ([[self waterFlowDatasource] respondsToSelector:@selector(numberOfColumnsForWaterfallView:)] == YES) 
    {
        _numberOfColumns = [[self waterFlowDatasource] numberOfColumnsForWaterfallView:self];
    } 
    else 
    {
        _numberOfColumns = DEFAULT_NUMBER_OF_CELLS;
    }
    
    [self setCellColumnInfos:nil];
    
    if (_numberOfColumns == 0) 
    {
        return;
    }
    
    CGFloat spaceWidth = _numberOfColumns * [self cellViewGap] + [self rightMargin];
    CGFloat fixedPathWidth = -1.0f;
    
    if ([[self waterFlowDatasource] respondsToSelector:@selector(waterfallView:widthOfCellOnColumn:)] == NO) {
        fixedPathWidth = ([self bounds].size.width - spaceWidth) / _numberOfColumns;
        
        if (fixedPathWidth < 0.0f) {
            fixedPathWidth = 0.0f;
        }
    }
    
    CGFloat pathStartX = [self cellViewGap];
    NSMutableArray* visiblePetalViews = [NSMutableArray arrayWithCapacity:_numberOfColumns];
    NSMutableArray* pathInfos = [NSMutableArray arrayWithCapacity:_numberOfColumns];
    
    for (NSUInteger col = 0; col < _numberOfColumns; ++col) {
        [visiblePetalViews addObject:[NSMutableArray arrayWithCapacity:0]];
        
        CGFloat pathWidth = 0.0f;
        
        if (fixedPathWidth < 0.0f) {
            pathWidth = [[self waterFlowDatasource] waterfallView:self widthOfCellOnColumn:col];
        } else {
            pathWidth = fixedPathWidth;
        }
        
        WASWaterFlowPathInfo* pathInfo = [[[WASWaterFlowPathInfo alloc] init] autorelease];
        [pathInfo setColumn:col];
        [pathInfo setHeaderHeight:[self headerHeight]];
        [pathInfo setX:pathStartX];
        [pathInfo setWidth:pathWidth];
        [pathInfos addObject:pathInfo];
        pathStartX += pathWidth + [self cellViewGap];
    }
    
    [self setVisibleCells:visiblePetalViews];
    [self setCellColumnInfos:pathInfos];
}


- (void) resetContentSizeByAppendingCellViews {
    if (_numberOfColumns == 0) {
        CGSize size = [self bounds].size;
        size.height += kContentSizeExtendHeight;
        [self setValue:[NSValue valueWithCGSize:size] forKeyPath:@"contentSize"];
        return;
    }
    
    CGFloat spaceWidth = _numberOfColumns * [self cellViewGap] + [self rightMargin];
    __block CGRect contentFrame = CGRectMake(0.0f, 0.0f, spaceWidth, 0.0f);
    __block NSUInteger fromIndex = 0;
    
    // Calculates content width.
    [[self cellColumnInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        WASWaterFlowPathInfo* pathInfo = (WASWaterFlowPathInfo*) obj;
        
        contentFrame.size.width += [pathInfo width];
        fromIndex += [pathInfo numberOfCells];
    }];
    
    // Calculates content height, at the same time calculates frame of each petal view.
    NSUInteger numberOfPetal = [[self waterFlowDatasource] numberOfCellsForWaterfallView:self];
    
    for (NSUInteger index = fromIndex; index < numberOfPetal; ++index) {
        WASWaterFlowPathInfo* pathInfo = [self infoOfShortestCell];
        CGFloat x = [pathInfo x];
        CGFloat y = [pathInfo height] + [self cellViewGap];
        CGFloat width = [pathInfo width];
        CGFloat height = 0;
            
        if ([[self waterFlowDatasource] respondsToSelector:@selector(waterfallView:normalizedHeightOfCellAtIndex:)] == YES) 
        {
            CGFloat normalizedHeight = [[self waterFlowDatasource] waterfallView:self normalizedHeightOfCellAtIndex:index];
            height = normalizedHeight * width;
        } 
        else if([[self waterFlowDatasource] respondsToSelector:@selector(waterfallView:heightOfCellAtIndex:)] == YES){
            height = [[self waterFlowDatasource] waterfallView:self heightOfCellAtIndex:index];
        }
        
        
        WASWaterFlowCellInfo* petalViewInfo = [[[WASWaterFlowCellInfo alloc] init] autorelease];
        
        [petalViewInfo setIndex:index];
        [petalViewInfo setRow:[pathInfo numberOfCells]];
        [petalViewInfo setFrame:CGRectMake(x, y, width, height)];
        
//        NSLog(@"cellInfo.x = %f, .y = %f, width = %f, .height = %f",x,y,width, height);
        [pathInfo addWaterFlowCellInfo:petalViewInfo];
    }
    
    contentFrame.size.height = [[self infoOfHighestCell] height] + [self cellViewGap] + kContentSizeExtendHeight;
    
    // Resets content size.
    contentFrame = CGRectIntegral(contentFrame);
    [self setValue:[NSValue valueWithCGSize:contentFrame.size] forKeyPath:@"contentSize"];

}



- (void) removeAllVisibleCellViews {
    [[self visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        [(NSArray*) obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
            [(WASWaterFlowCell*) obj removeFromSuperview];
        }];
    }];
    
    [self setVisibleCells:nil];
}


- (void) tileCellViewsOnPath:(WASWaterFlowPathInfo*)pathInfo minimumY:(CGFloat)minY maximumY:(CGFloat)maxY 
{
    NSMutableArray* cellViews = [[self visibleCells] objectAtIndex:[pathInfo column]];
    // Recycles invisible petal views.
    [[self class] reverseArray:cellViews];
    
    while ([cellViews count] > 0) 
    {
        WASWaterFlowCell* cell = [cellViews lastObject];
        NSInteger row = [[[cell layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
        CGRect petalViewFrame = [[pathInfo waterFlowCellInfoForRow:row] frame];
        
        if (CGRectGetMaxY(petalViewFrame) > minY) 
        {
            break;
        }
        [self pushCellViewForReuse:cell];

        [cell removeFromSuperview];
        [cellViews removeLastObject];
    }
    
    [[self class] reverseArray:cellViews];
    
    while ([cellViews count] > 0) 
    {
        WASWaterFlowCell* petalView = [cellViews lastObject];
        NSInteger row = [[[petalView layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
        CGRect petalViewFrame = [[pathInfo waterFlowCellInfoForRow:row] frame];
        
        if (CGRectGetMinY(petalViewFrame) < maxY) 
        {
            break;
        }
        [self pushCellViewForReuse:petalView];
        [petalView removeFromSuperview];
        [cellViews removeLastObject];
    }
    
    // Tiles visible petal views.
    if ([cellViews count] == 0) 
    {
        [self reloadCellViewsOnPath:pathInfo cellViewList:cellViews minimumY:minY maximumY:maxY];
    } 
    else
    {
        [[self class] reverseArray:cellViews];
        
        NSInteger firstRow = [[[[cellViews lastObject] layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
        
        for (firstRow--; firstRow >= 0; --firstRow) 
        {
            WASWaterFlowCellInfo* petalViewInfo = [pathInfo waterFlowCellInfoForRow:firstRow];
            CGRect petalViewFrame = [[pathInfo waterFlowCellInfoForRow:firstRow] frame];
            
            if (CGRectGetMaxY(petalViewFrame) <= minY) 
            {
                break;
            }
            
            [self tileCellViewWithInfo:petalViewInfo cellViewList:cellViews column:[pathInfo column]];
        }
        
        [[self class] reverseArray:cellViews];
        
        NSInteger lastRow = [[[[cellViews lastObject] layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
        
        for (lastRow++; lastRow < [pathInfo numberOfCells]; ++lastRow) 
        {
            WASWaterFlowCellInfo* petalViewInfo = [pathInfo waterFlowCellInfoForRow:lastRow];
            CGRect petalViewFrame = [petalViewInfo frame];
            
            if (CGRectGetMinY(petalViewFrame) >= maxY)
            {
                break;
            }
            
            [self tileCellViewWithInfo:petalViewInfo cellViewList:cellViews column:[pathInfo column]];
        }
    }
}


- (void) tileCellViewWithInfo:(WASWaterFlowCellInfo*)petalViewInfo 
                 cellViewList:(NSMutableArray*)cellViews
                     column:(NSUInteger) column
{
    WASWaterFlowCell* cellView = [[self waterFlowDatasource] waterFlowView:self cellForRowAtIndexPath:[petalViewInfo index]];
    [[cellView layer] setValue:[NSNumber numberWithInteger:[petalViewInfo index]] forKey:CELL_VIEW_INDEX_KEY];
    [[cellView layer] setValue:[NSNumber numberWithInteger:[petalViewInfo row]] forKey:CELL_VIEW_ROW_KEY];
    [[cellView layer] setValue:[NSNumber numberWithInteger:column] forKey:CELL_VIEW_COLUMN__];
    [cellView setFrame:CGRectIntegral([petalViewInfo frame])];
    [cellViews addObject:cellView];
    
//    RECTLOG(cellView.frame);
    
//    NSLog(@"===========1===%d=========[petalViewInfo frame] = %d",[petalViewInfo index],[cellViews count]);
        
    NSInteger count = [[self subviews] count];
    
    if (count == 0) {
        [self addSubview:cellView];
    } else {
        [self insertSubview:cellView atIndex:(count - 1)];
    }
}


- (void) reloadCellViewsOnPath:(WASWaterFlowPathInfo*)pathInfo 
                  cellViewList:(NSMutableArray*)cellViews
                       minimumY:(CGFloat)minY 
                       maximumY:(CGFloat)maxY 
{
    NSInteger row = [self firstRowBelowY:minY inPath:pathInfo];
    
    for (; row < [pathInfo numberOfCells]; ++row) 
    {
        WASWaterFlowCellInfo* cellViewInfo = [pathInfo waterFlowCellInfoForRow:row];
        CGRect cellViewFrame = [cellViewInfo frame];
        
        if (CGRectGetMinY(cellViewFrame) >= maxY) 
        {
            break;
        }
        
        [self tileCellViewWithInfo:cellViewInfo cellViewList:cellViews column:[pathInfo column]];
    }
}

- (NSInteger) firstRowBelowY:(CGFloat)y inPath:(WASWaterFlowPathInfo*)pathInfo 
{
    NSInteger row   = [pathInfo numberOfCells];
    NSInteger left  = 0;
    NSInteger right = [pathInfo numberOfCells] - 1;
    
    while (left <= right)
    {
        NSInteger mid = (left + right) / 2;
        
        if (CGRectGetMaxY([[pathInfo waterFlowCellInfoForRow:mid] frame]) < y) 
        {
            left = mid + 1;
        } 
        else 
        {
            right = mid - 1;
            row = MIN(row, mid);
        }
    }
    
    return row;
}


- (void) pushCellViewForReuse:(WASWaterFlowCell*)petalView
{
    if ([petalView reuseIdentifier] == nil) 
    {
        return;
    }
    
    NSMutableArray* petalViews = [[self reusableCells] objectForKey:[petalView reuseIdentifier]];
    
    if (!petalViews)
    {
        petalViews = [NSMutableArray arrayWithCapacity:0];
        [[self reusableCells] setObject:petalViews forKey:[petalView reuseIdentifier]];
    }
    
    [petalViews addObject:[[petalView retain] autorelease]];
}

- (WASWaterFlowCell*) popReusableCellViewWithIdentifier:(NSString*)identifier 
{
    if (identifier == nil) 
    {
        return nil;
    }
    
    NSMutableArray* cellViews = [[self reusableCells] objectForKey:identifier];
    
    if ([cellViews count] == 0) 
    {
        return nil;
    } 
    else 
    {
        WASWaterFlowCell* cellView = [cellViews lastObject];
        
        [[cellView retain] autorelease];
        
        [cellViews removeLastObject];
        
        return cellView;
    }
}

@end

