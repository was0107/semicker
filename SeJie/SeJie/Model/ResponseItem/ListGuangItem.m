//
//  ListGuangItem.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListGuangItem.h"

@implementation ListGuangItemBase
@synthesize title               = _title;
@synthesize docid               = _docid;
@synthesize like                = _like;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_docid);
    TT_RELEASE_SAFELY(_like);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.title        = [dictionary objectForKey:@"title"];
        self.docid        = [dictionary objectForKey:@"docid"];
        self.like         = [dictionary objectForKey:@"like"];
    }
    return self;
}
@end

@implementation ListGuangItem
- (void) dealloc
{
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    return self;
}

- (NSString *) subItemRequestString
{
    return [NSString stringWithFormat:@"{\"docid\":\"%@\"}",self.docid];//@"297951"] ;//
}

@end
