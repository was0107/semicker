//
//  WASBaseAdapter.m
//  micker
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBaseAdapter.h"

@interface WASBaseAdapter()
{
    __block NSString *_contents;
    __block NSInteger _statusCode;
    
    voidBlock _onSuccessBlock;
    voidBlock _onFailedBlock;
    voidBlock _onErrorBlock;
}

@property (nonatomic, copy) voidBlock successBlock;
@property (nonatomic, copy) voidBlock failedBlock;
@property (nonatomic, copy) voidBlock errorBlock;
@end

@implementation WASBaseAdapter
@synthesize contents        = _contents;
@synthesize statusCode      = _statusCode;
@synthesize successBlock    = _onSuccessBlock;
@synthesize failedBlock     = _onFailedBlock;
@synthesize errorBlock      = _onErrorBlock;

-(void) onSuccessBlock:(voidBlock)exec
{
    self.successBlock = exec;
}

-(void) onFailedBlock:(voidBlock)exec
{
    self.failedBlock = exec;
}

-(void) onErrorBlock:(voidBlock)exec
{
    self.errorBlock = exec;
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

- (void) cancel
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

- (void) dealloc
{
    [_contents release], _contents = nil;
    [_onSuccessBlock release], _onSuccessBlock = nil;
    [_onFailedBlock release], _onFailedBlock = nil;
    [_onErrorBlock release], _onErrorBlock = nil;
    [super dealloc];
}
@end
