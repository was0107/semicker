//
//  ListResponseBase.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListResponseBase.h"

@implementation ListResponseBase

@synthesize succ = _succ;
@synthesize msg  = _msg;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_msg);
    [super dealloc];
}

- (id) initWithJsonString:(NSString *) jsonString
{
    SBJSON *json = [[[SBJSON alloc]init] autorelease];
    NSDictionary *dictionary = [json fragmentWithString:jsonString error:nil];
    self = [self initWithDictionary:dictionary];
    return self;
    
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.succ       = [[dictionary objectForKey:@"succ"] integerValue];
        self.msg        = [dictionary objectForKey:@"msg"];
    }
    return self;
}

@end
