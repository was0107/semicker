//
//  ListGoodsItem.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListGoodsItem.h"

@implementation ListGoodsItem
@synthesize price       = _price;
@synthesize source      = _source;
@synthesize category    = _category;
@synthesize type        = _type;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_price);
    TT_RELEASE_SAFELY(_source);
    TT_RELEASE_SAFELY(_category);
    TT_RELEASE_SAFELY(_type);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    static NSString *format = @"%@200x0";
    static NSString *prefix = @"http://img.b5m.com";
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.price        = [dictionary objectForKey:@"price"];
        self.source       = [dictionary objectForKey:@"source"];
        self.category     = [dictionary objectForKey:@"category"];
        self.type         = [dictionary objectForKey:@"type"];
        
        NSString *source= [dictionary objectForKey: [self imageName]];
        self.img = ([source hasPrefix:prefix]) ? [NSString stringWithFormat:format,source] : source ;
        self.soureImg = source;
    }
    return self;
}

@end
