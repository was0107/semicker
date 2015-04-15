//
//  WASWaterFlowPathInfo.m
//  micker
//
//  Created by allen.wang on 8/16/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASWaterFlowPathInfo.h"
#import "WASWaterFlowCellInfo.h"
//#import "ListPadDefines.h"

CG_INLINE CGRect
offsetFrame(CGRect frame ,CGFloat y)
{
    CGRect newRect = frame;
    newRect.size.height += y;
    return newRect;
}


@interface WASWaterFlowPathInfo()
@property (nonatomic, retain) NSMutableArray* waterCellInfos;


@end

@implementation WASWaterFlowPathInfo
@synthesize column = _column;
@synthesize width  = _width;
@synthesize x      = _x;
@synthesize headerHeight = _headerHeight;


#pragma mark - Initializers and uninitializers

- (void) dealloc {
    [self setWaterCellInfos:nil];
    [super dealloc];
}

- (CGFloat) height {
    if ([self numberOfCells] == 0) {
        return [self headerHeight];
    } else {
        return CGRectGetMaxY([[[self waterCellInfos] lastObject] frame]);
    }
}

- (NSUInteger) numberOfCells {
    return [[self waterCellInfos] count];
}

- (WASWaterFlowCellInfo*) waterFlowCellInfoForRow:(NSUInteger)row {
    if (row < [self numberOfCells]) {
        return [[self waterCellInfos] objectAtIndex:row];
    } else {
        return nil;
    }
}

- (void) changeWaterFlowCellFrame:(NSUInteger) row withOffsetY:(CGFloat) y animatin:(BOOL) flag
{
    WASWaterFlowCellInfo *cellInfo = [self waterFlowCellInfoForRow:row];
    
    if (cellInfo.hasCount) {
        return;
    }
    
    cellInfo.frame = offsetFrame(cellInfo.frame, y);
    cellInfo.hasCount = YES;
    for (NSUInteger index = row + 1, total = [self numberOfCells]; index < total; ++index) {
        cellInfo = [self waterFlowCellInfoForRow:index];
        cellInfo.frame = CGRectOffset(cellInfo.frame, 0, y);
    }

}


- (void) addWaterFlowCellInfo:(WASWaterFlowCellInfo*)petalViewInfo {
    [[self waterCellInfos] addObject:petalViewInfo];
}


#pragma mark - Private methods
@synthesize waterCellInfos = _waterCellInfos;

- (NSMutableArray*) waterCellInfos {
    if (_waterCellInfos == nil) {
        [self setWaterCellInfos:[NSMutableArray arrayWithCapacity:0]];
    }
    return _waterCellInfos;
}
@end
