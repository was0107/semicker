//
//  ListPaggingResponseBase.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListPaggingResponseBase.h"

@implementation ListPaggingResponseBase
@synthesize result      = _result;
@synthesize count       = _count;
@synthesize arrayCount  = _arrayCount;

- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.result = [self getResultFrom:dictionary];
        self.count  = [[dictionary objectForKey:@"listNum"] integerValue];
        self.arrayCount = [self.result count];
        [self translateFrom:dictionary];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_result);
    [super dealloc];
}


- (NSMutableArray *) getResultFrom:(NSDictionary *) dictionary
{
//    DEBUGLOG(@"dictionary = %@",dictionary);
    NSMutableArray *array = [dictionary objectForKey:[self resultKey]];
    NSMutableArray *arrayResult = [NSMutableArray array];
    for ( NSUInteger i = 0 , total = [array count]; i < total; ++i) {
        NSDictionary *dictionary = (NSDictionary *) [array objectAtIndex:i];
        id valied = [self translateItemFrom:dictionary index:i];
        ValiedCheck(valied);
        [arrayResult addObject:valied];
    }
    return arrayResult;
}

- (void) appendPaggingFromJsonString:(NSString *) jsonString
{
    SBJSON *json = [[[SBJSON alloc] init] autorelease];
    NSDictionary *dictionary = [json fragmentWithString:jsonString error:nil];
    [self.result addObjectsFromArray:[self getResultFrom:dictionary]];
    self.arrayCount = [self.result count];
}

- (BOOL) reachTheEnd
{
    if (self.result) {
        return self.arrayCount >= self.count;
    }
    return NO;
}

- (BOOL) isEmpty
{
    return self.arrayCount == 0;
}


- (NSString *) resultKey
{
    return @"data";
}


- (id) translateItemFrom:(const NSDictionary *) dictionary index:(NSUInteger) index
{
    return nil;
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    return nil;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"self = %@ ;self.resultKey= %@ ; self.result = %@", self, self.resultKey, self.result];
}

- (NSString *) debugDescription
{
    return self.description;
}

@end
