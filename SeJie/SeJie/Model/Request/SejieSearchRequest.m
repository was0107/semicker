//
//  SejieSearchRequest.m
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "SejieSearchRequest.h"
#import "NSString+URLEncoding.h"

@implementation SejieSearchRequest

@synthesize keyword = _keyword;
@synthesize category = _category;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_category);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *result = [super keyArrays];
    if ([self.keyword length] != 0) {
        [result addObject:@"q"];
    }
    [result addObject:@"page"];
    [result addObject:@"per_page"];
    return result;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *result = [super valueArrays];
    if ([self.keyword length] != 0) {
        [result addObject:[self.keyword URLEncodedString]];
    }
    [result addObject:kIntToString(self.pageno)];;
    [result addObject:kIntToString(self.pagesize)];
    return result;
}

@end
