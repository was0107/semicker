//
//  FeedbackRequest.m
// sejieios
//
//  Created by Jarry on 13-1-9.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "FeedbackRequest.h"

@implementation FeedbackRequest

@synthesize comment = _comment;
@synthesize contact = _contact;
@synthesize source = _source;

- (id) init {
    self = [super init];
    if (self) {
        self.source = @"app";
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_comment);
    TT_RELEASE_SAFELY(_contact);
    TT_RELEASE_SAFELY(_source);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"comment", @"contact",  @"source", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.comment, self.contact, self.source, nil];
}


@end
