//
//  ListPaggingRequestBase.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@implementation ListPaggingRequestBase
@synthesize pageno      = _pageno;
@synthesize pagesize    = _pagesize;
@synthesize max         = _max;

- (id) init {
    self = [super init];
    if (self) {
        self.pageno     = 1;
        self.pagesize   = 60;
        self.max        = kEmptyString;
    }
    return self;
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *result = [NSMutableArray arrayWithObject:@"limit"];
    if ([self.max length] != 0) {
        [result addObject:@"max"];
    }
    return result;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *result = [NSMutableArray arrayWithObject:kIntToString(self.pagesize)];
    if ([self.max length] != 0) {
        [result addObject:self.max];
    }
    return result;
}

- (id) nextPage
{
    self.pageno += 1;
    return self;
}

- (id) firstPage
{
    self.pageno = 1;
    self.max = kEmptyString;
    return self;
}

- (BOOL) isFristPage
{
    return self.pageno == 1;
}


@end
