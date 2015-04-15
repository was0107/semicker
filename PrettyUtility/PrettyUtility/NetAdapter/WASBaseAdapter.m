//
//  WASBaseAdapter.m
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBaseAdapter.h"

@interface WASBaseAdapter()
{
    __block NSString *_contents;
    __block NSInteger _statusCode;
}
@end

@implementation WASBaseAdapter
@synthesize contents = _contents;
@synthesize statusCode = _statusCode;

-(void) onSuccessBlock:(voidBlock)exec
{
    if (exec) {
        _onSuccessBlock = [exec copy];
    }
}

-(void) onFailedBlock:(voidBlock)exec
{
    if (exec) {
        _onFailedBlock = [exec copy];
    }
}

-(void) onErrorBlock:(voidBlock)exec
{
    if (exec) {
        _onErrorBlock = [exec copy];
    }
}

- (void) success
{
    if (_onSuccessBlock) {
        _onSuccessBlock();
    }
}

- (void) failed
{
    if (_onFailedBlock) {
        _onFailedBlock();
    }
}

- (void) error
{
    if (_onErrorBlock) {
        _onErrorBlock();
    }
}

-(BOOL) shouldStart
{
    return YES;
}

- (void) startService
{
    //do nothing 
}

- (NSString *) hash
{
    return @"";
}

- (NSString *) contents
{
    return @"";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"class = %@", NSStringFromClass([self class])];
}

- (void) dealloc
{
    [_contents release], _contents = nil;
    [super dealloc];
}
@end
