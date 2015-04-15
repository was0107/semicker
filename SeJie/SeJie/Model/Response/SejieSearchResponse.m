//
//  SejieSearchResponse.m
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SejieSearchResponse.h"

@implementation SejieSearchResponse

@synthesize tagsGroup   = _tagsGroup;


- (void) dealloc
{
    TT_RELEASE_SAFELY(_tagsGroup);
    [super dealloc];
}


- (id) translateFrom:(const NSDictionary *) dictionary
{
    self = [super translateFrom:dictionary];
    
    NSArray *array = [dictionary objectForKey:@"group"];
    self.tagsGroup = [NSMutableArray array];
    for (NSString *name in array) {
        LabelItem *item = [[[LabelItem alloc] init] autorelease];
        item.labelName = name;
        
        [self.tagsGroup addObject:item];
    }
    
    return self;
}


@end



@implementation SejieSearchResponseManager
@synthesize contents      = _contents;
@synthesize cellsArray    = _cellsArray;
@synthesize currentItem   = _currentItem;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_cellsArray);
    TT_RELEASE_SAFELY(_contents);
    [super dealloc];
}


+(id) instanceManger
{
    static dispatch_once_t  onceToken;
    static SejieSearchResponseManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SejieSearchResponseManager alloc] init];
    });
    return sharedInstance;
}

- (void) setTheKeyword:(NSString*) keyword
{
    if (self.contents) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    LabelItem *item = [[[LabelItem alloc] init] autorelease];
    item.labelName = keyword;
    [array addObject:item];
    self.contents = array;
}

- (void) setCellsArray:(NSMutableArray *)cellsArray
{
    if (_cellsArray != cellsArray) {
        [_cellsArray release];
        _cellsArray = [cellsArray retain];
    }
}

- (void) setCurrentItem:(NSString *)currentItem
{
    if (_currentItem != currentItem) {
        [self resetContent];
        _currentItem = currentItem;
        if (!_currentItem) {
            [self setTopSelected];
        } else {
            [self changeData:[self cellsArray] selected:YES];
        }
    }
}


- (void) resetContent
{
    [self resetCurrentLeve1];
    [self resetCurrentLeve2];
}

- (void) setTopSelected
{
    for (NSUInteger i = 0,total = [[self contents] count] ; i < total; i++) {
        LabelItem *item = [[self contents]  objectAtIndex:i];
        item.isSelected = YES;
    }
}

- (void) changeData:(NSArray *) array selected:(BOOL) flag
{
    for (NSUInteger i = 0,total = [array count] ; i < total; i++) {
        LabelItem *item = [array objectAtIndex:i];
        if ([self.currentItem isEqualToString:item.labelName]) {
            item.isSelected = flag;
        }
    }
}

- (void) resetCurrentLeve1
{
    if (self.currentItem) {
        [self changeData:[self contents] selected:NO];
    }
}

- (void) resetCurrentLeve2
{
    if (self.currentItem) {
        [self changeData:[self cellsArray] selected:NO];
    }
}

- (void) resetData
{
    self.contents = nil;
    self.cellsArray = nil;
    self.currentItem = nil;
}
@end