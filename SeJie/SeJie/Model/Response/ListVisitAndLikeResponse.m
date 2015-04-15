//
//  ListVisitAndLikeResponse.m
// sejieios
//
//  Created by allen.wang on 1/21/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListVisitAndLikeResponse.h"

@implementation ListVisitAndLikeResponse
@synthesize visitcnt = _visitcnt;
@synthesize likecnt  = _likecnt;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_likecnt);
    TT_RELEASE_SAFELY(_visitcnt);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.likecnt       = [dictionary objectForKey:@"likecnt"];
        self.visitcnt      = [dictionary objectForKey:@"visitcnt"];
    }
    return self;
}
@end
