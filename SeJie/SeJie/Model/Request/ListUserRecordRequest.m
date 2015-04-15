//
//  ListUserRecordRequest.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListUserRecordRequest.h"

@implementation ListUserRecordRequest

@synthesize userid  =   _userid;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userid);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"pageno",@"pagesize",@"userid", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:kIntToString(self.pageno),kIntToString(self.pagesize),[self userid], nil];
}


@end
