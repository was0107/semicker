//
//  ListCommentItem.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListCommentItem.h"

@implementation ListCommentItem
@synthesize text       = _text;
@synthesize time       = _time;
@synthesize username   = _username;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_text);
    TT_RELEASE_SAFELY(_time);
    TT_RELEASE_SAFELY(_username);
    [super dealloc];
}

- (id) imageName
{
    return @"img";
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.text        = [dictionary objectForKey:@"text"];
        self.username    = [dictionary objectForKey:@"username"];
        self.time        = [dictionary objectForKey:@"createtime"];
    }
    return self;
}

@end
