//
//  ListDetailResponse.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListDetailResponse.h"

@implementation ListDetailResponse
@synthesize detailItem = _detailItem;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_detailItem);
    [super dealloc];
}

- (NSString *) resultKey
{
    return @"products";
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    self.detailItem = [[[ListDetailItem alloc] initWithDictionary:dictionary] autorelease];
    return self;
}

- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index
{
    return [[[ListGoodsItem alloc] initWithDictionary:dictionary] autorelease];
}

@end
