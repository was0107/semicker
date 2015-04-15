//
//  ListGuangRequest.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListGuangRequest.h"

@implementation ListGuangRequest

@synthesize group       = _group;
@synthesize keywords    = _keywords;
@synthesize keywords2   = _keywords2;
@synthesize categorys   = _categorys;
@synthesize sources     = _sources;
@synthesize brands      = _brands;
@synthesize price       = _price;
@synthesize sort        = _sort;
@synthesize barcodeflag = _barcodeflag;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_keywords);
    TT_RELEASE_SAFELY(_keywords2);
    TT_RELEASE_SAFELY(_categorys);
    TT_RELEASE_SAFELY(_sources);
    TT_RELEASE_SAFELY(_brands);
    TT_RELEASE_SAFELY(_price);
    TT_RELEASE_SAFELY(_sort);
    [super dealloc];
}


- (NSMutableArray *) keyArray
{
    NSMutableArray  *keys   = [NSMutableArray arrayWithObjects:@"pageno",@"pagesize", nil];//@"group",@"barcodeflag",nil];
    
//    if ([self checkArray:self.categorys]) {
//        [keys   addObject:@"categorys"];
//    }
//    
//    if ([self checkArray:self.sources]) {
//        [keys   addObject:@"sources"];
//    }
//    
//    if ([self checkArray:self.brands]) {
//        [keys   addObject:@"brands"];
//    }
//    
//    if ([self checkString:self.keywords2]) {
//        [keys   addObject:@"keywords"];
//    }
    
    return keys;
}

- (NSMutableArray *) valueArray
{
    NSMutableArray *values = nil;
    
    values = [NSMutableArray arrayWithObjects:
              kIntToString(self.pageno),
              kIntToString(self.pagesize),nil];
//              kIntToString(self.group),
//              kBOOLToString(self.barcodeflag),nil];
//    
//    if ([self checkArray:self.categorys]) {
//        [values addObject:self.categorys];
//    }
//    
//    if ([self checkArray:self.sources]) {
//        [values addObject:self.sources];
//    }
//    
//    if ([self checkArray:self.brands]) {
//        [values addObject:self.brands];
//    }
//    
//    if ([self checkString:self.keywords2]) {
//        [values addObject:self.keywords2];
//    }
    
    return values;
}
@end
