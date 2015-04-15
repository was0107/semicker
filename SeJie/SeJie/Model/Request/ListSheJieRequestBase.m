//
//  ListSheJieRequestBase.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListSheJieRequestBase.h"

@implementation ListSheJieRequestBase

@end

@implementation ListSheJieNormalRequest

- (id) firstPage
{
    self.pageno = 0;
    return self;
}


- (BOOL) isFristPage
{
    return self.pageno == 0;
}

@end


@implementation ListSheJieExplorerRequest
@synthesize label       = _label;
@synthesize labelTwo    = _labelTwo;
@synthesize labelThree  = _labelThree;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_label);
    TT_RELEASE_SAFELY(_labelTwo);
    TT_RELEASE_SAFELY(_labelThree);
    [super dealloc];
}

- (void) setLabel:(NSString *)label
{
    if (_label != label) {
        [_label release];
        _label = [label copy];
        self.labelTwo = nil;
        [self firstPage];
    }
}

- (void) setLabelTwo:(NSString *)labelTwo
{
    if (_labelTwo != labelTwo) {
        [_labelTwo release];
        _labelTwo = [labelTwo copy];
        self.labelThree = nil;
        [self firstPage];
    }
}

- (void) setLabelThree:(NSString *)labelThree
{
    if (_labelThree != labelThree) {
        [_labelThree release];
        _labelThree = [labelThree copy];
        [self firstPage];
    }
}

- (NSString *) theLabe
{
    if ([self checkString:self.labelThree]) {
        return [NSString stringWithFormat:@"%@>%@>%@",self.label,self.labelTwo,self.labelThree];
    } else if ([self checkString:self.labelTwo]) {
        return [NSString stringWithFormat:@"%@>%@",self.label,self.labelTwo];
    }
    return self.label;
}

//
//- (NSString *) toJsonString
//{
//    return ;
//}
@end
