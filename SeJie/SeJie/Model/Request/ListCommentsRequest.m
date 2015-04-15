//
//  ListCommentsRequest.m
// sejieios
//
//  Created by allen.wang on 1/10/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListCommentsRequest.h"

@implementation ListCommentsRequest
@synthesize docid        = _docid;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_docid);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"docid",@"pageno",@"pagesize", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.docid, kIntToString(self.pageno),kIntToString(self.pagesize),nil];
}
@end
