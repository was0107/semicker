//
//  AutofillListData.m
//  micker
//
//  Created by Jarry Zhu on 12-6-1.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "AutofillListData.h"
#import "JSON.h"

#pragma mark - AutofileDataItem

@implementation AutofillDataItem

@synthesize name = _name;
@synthesize count = _count;

- (void)dealloc {
    [_name release];
    [super dealloc];
}

@end


#pragma mark - AutofillListData

@implementation AutofillListData

@synthesize listData = _listData;

- (id) init {
    self = [super init];
    if (self) {
        _listData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)initWithJsonString:(NSString*)jsonString {
    
    SBJSON *json = [[[SBJSON alloc] init] autorelease];
    NSDictionary *dictionary  = [json fragmentWithString:jsonString error:nil]; 
    
    NSArray *arrayData  = [dictionary objectForKey:@"keywords"];
    NSUInteger count    = [arrayData count];

    for (NSUInteger i=0; i < count; i++) {
        NSDictionary *itemDic = [arrayData objectAtIndex:i];
        AutofillDataItem *item = [[[AutofillDataItem alloc] init] autorelease];
        item.name = [itemDic objectForKey:@"name"];
        //item.count = 
        NSNumber *itemCount = [itemDic objectForKey:@"count"];
        item.count = [itemCount integerValue];
        
        [_listData addObject:item];
    }
    
}

- (void)dealloc {
    [_listData release];
    [super dealloc];
}

@end
