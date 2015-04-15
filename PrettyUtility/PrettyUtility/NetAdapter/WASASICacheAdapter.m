//
//  WASASICacheAdapter.m
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASASICacheAdapter.h"
#import "B5MCacheManager.h"
#import "B5MUtility.h"

@interface WASASICacheAdapter()
@property (nonatomic, retain)  WASBaseAdapter *adapter;
@property (nonatomic, copy)    NSString *result;
@end

@implementation WASASICacheAdapter
@synthesize adapter = _adapter;
@synthesize result  = _result;

- (id) initWithAdapter:(WASBaseAdapter *)adapter
{
    self = [super init];
    if (self) {
        [self setAdapter:adapter];
    }
    return self;
}

- (void) startService
{
    [super startService];
    
    if ([self shouldStart]) {
        [self success];
    }else {
        [_adapter addObserver:self forKeyPath:kKeyValueContents options:NSKeyValueObservingOptionNew context:nil];
        [_adapter startService];
    }
}

-(BOOL) shouldStart
{
    return  (self.result = [[B5MCacheManager sharedCacheManager] getContentWithKey:[self hash]]) ? YES:NO;
}

- (void) success
{
    [super success];
}

- (void) failed
{
    [super failed];
}

- (NSString *) hash
{
    return [_adapter hash];
}

- (NSString *) contents
{
    return self.result;
}

-(void)observeValueForKeyPath:(NSString *)keyPath 
					 ofObject:(id)object
					   change:(NSDictionary *)change
					  context:(void *)context
{
    self.result = [_adapter contents];
    if ([B5MUtility checkResultCode:[_adapter contents]]) {
        [[B5MCacheManager sharedCacheManager] addItemToCache:[self hash] withContent:[_adapter contents]];
        [self success];
    }else {
        [self failed]; 
    }
}

- (void) dealloc
{
    [_adapter removeObserver:self forKeyPath:kKeyValueContents];
    [_adapter release], _adapter = nil;
    [_result release], _result = nil;
    [super dealloc];
}

@end
