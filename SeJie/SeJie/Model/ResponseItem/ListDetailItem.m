//
//  ListDetailItem.m
// sejieios
//
//  Created by allen.wang on 1/9/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListDetailItem.h"

@implementation ListDetailItem
@synthesize userImg  = _userImg;
@synthesize likecnt  = _likecnt;
@synthesize visitcnt = _visitcnt;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userImg);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    static NSString *format = @"%@100x0";
    static NSString *prefix = @"http://img.b5m.com";
    
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSString *source= [dictionary objectForKey: @"icon"];
        self.userImg = ([source hasPrefix:prefix]) ? [NSString stringWithFormat:format,source] : source ;
        self.likecnt  = [dictionary objectForKey: @"likecnt"];
        self.visitcnt = [dictionary objectForKey: @"visitcnt"];
    }
    return self;
}

@end
