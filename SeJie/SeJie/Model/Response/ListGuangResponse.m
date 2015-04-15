//
//  ListGuangResponse.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListGuangResponse.h"
#import "ListGuangItem.h"
@implementation ListGuangResponse


- (NSString *) resultKey
{
    return @"imgs";
}

- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index
{
    return [[[ListGuangItem alloc] initWithDictionary:dictionary] autorelease];
}

@end
