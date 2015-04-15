//
//  ListImageItem.m
// sejieios
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListImageItem.h"

@implementation ListImageItem
@synthesize img                 = _img;
@synthesize soureImg            = _soureImg;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_img);
    TT_RELEASE_SAFELY(_soureImg);
    [super dealloc];
}

- (id) imageName
{
    return @"pic";
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    static NSString *format = @"%@600x0";
    static NSString *prefix = @"http://img.b5m.com";
    
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSString *source= [dictionary objectForKey: [self imageName]];
        self.img = ([source hasPrefix:prefix]) ? [NSString stringWithFormat:format,source] : source ;
        self.soureImg = source;
    }
    return self;
}

@end
