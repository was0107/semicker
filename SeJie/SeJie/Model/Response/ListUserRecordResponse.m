//
//  ListUserRecordResponse.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListUserRecordResponse.h"
#import "UserRecordItem.h"

@implementation ListUserRecordResponse

- (NSString *) resultKey
{
    return @"moments";
}

- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index
{
    return [[[UserRecordItem alloc] initWithDictionary:dictionary] autorelease];
}

@end
