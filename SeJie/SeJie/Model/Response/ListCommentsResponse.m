//
//  ListCommentsResponse.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListCommentsResponse.h"

@implementation ListCommentsResponse

- (NSString *) resultKey
{
    return @"comments";
}

- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index
{
    return [[[ListCommentItem alloc] initWithDictionary:dictionary] autorelease];
}

@end
