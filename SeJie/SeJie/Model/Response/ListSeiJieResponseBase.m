//
//  ListSeiJieResponseBase.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListSeiJieResponseBase.h"


@implementation ListSeiJieResponseBase
@synthesize realpageno = _realpageno;
@synthesize maxId      = _maxId;

- (NSString *) resultKey
{
    return @"pins";
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    self.realpageno = [[dictionary objectForKey:@"realpageno"] unsignedIntValue];
    return self;
}

- (void) dealloc {
    TT_RELEASE_SAFELY(_maxId);
    [super dealloc];
}

- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index
{
    ListSeiJieItem *item = [[[ListSeiJieItem alloc] initWithDictionary:dictionary] autorelease];
    if (0 == index) {
        self.maxId = item.pinId;
    }
    return item;
}

@end


@implementation ListAccountResponseBase

@end
