//
//  ListUploadImageResponse.m
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListUploadImageResponse.h"

@implementation ListUploadImageResponse
@synthesize pic = _pic;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_pic);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.pic = [dictionary objectForKey:@"pic"];
    }
    return self;
}


@end
