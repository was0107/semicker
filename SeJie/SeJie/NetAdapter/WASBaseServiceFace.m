//
//  WASBaseServiceFace.m
//  b5mUtility
//
//  Created by allen.wang on 11/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBaseServiceFace.h"
#import "WASBaseServiceManager.h"
#import "WASASIUploadAdapter.h"

@implementation WASBaseServiceFace

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body
{
    [self serviceWithMethod:method body:body onSuc:NULL onFailed:NULL onError:NULL withCached:NO];
}

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:NULL onError:NULL withCached:NO];
}

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:failed onError:NULL withCached:NO];
}

+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error
{
    [self serviceWithMethod:method body:body onSuc:success onFailed:failed onError:error withCached:NO];
}

+(void) serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error withCached:(BOOL) cached
{
    [self cancelServiceMethod:method];
    __block WASBaseAdapter *adapterLog = [(WASBaseAdapter *)[[WASASILogAdatper  alloc] initWithAdapter:nil] autorelease];
    __block WASBaseAdapter *adapterASI = [[[WASASIAdapter alloc] initWithURL:kRequestURL(method)
                                                                      method:method
                                                                        Body:body
                                                                     adatper:(WASBaseAdapter *)adapterLog] autorelease];
    
    __block WASBaseAdapter *result = adapterASI;
    if (cached) {
        __block WASBaseAdapter *adapterCache = [[[WASASICacheAdapter alloc] initWithAdapter:adapterASI] autorelease];
        result = adapterCache;
    }
    
    // store cached ASI
    [[WASBaseServiceManager sharedRequestInstance] store:adapterASI forKey:method];
    voidBlock clearBlock = ^{
        [[WASBaseServiceManager sharedRequestInstance] removeKey:method];
    };
    
    [result onSuccessBlock:(!success) ? NULL : ^{
        success([result contents]);
        clearBlock();
    }];
    [result onFailedBlock:(!failed) ? NULL : ^{
        failed([result contents]);
        clearBlock();
    }];
    [result onErrorBlock:(!error) ? NULL : ^{
        error(kIntToString([result statusCode]));
        clearBlock();
    }];
    
    [result startService];
}

+ (void)serviceUploadMethod:(NSString *) method data:(NSData *) data body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error
{
    __block WASBaseAdapter *adapterLog = [(WASBaseAdapter *)[[WASASILogAdatper  alloc] initWithAdapter:nil] autorelease];
    __block WASASIUploadAdapter *adapterASI = [[[WASASIUploadAdapter alloc] initWithURL:kRequestURL(method)
                                                                         method:method
                                                                           data:data
                                                                           Body:body
                                                                        adatper:(WASBaseAdapter *)adapterLog] autorelease];
    
    __block WASBaseAdapter *result = adapterASI;
    [result onSuccessBlock:(!success) ? NULL : ^{
        success([result contents]);
    }];
    [result onFailedBlock:(!failed) ? NULL : ^{
        failed([result contents]);
    }];
    [result onErrorBlock:(!error) ? NULL : ^{
        error(kIntToString([result statusCode]));
    }];
    
    [result startService];
    
}

+ (void)cancelServiceMethod:(NSString *) method;
{
    WASBaseAdapter *adapterASI  = [[WASBaseServiceManager sharedRequestInstance] requestForKey:method];
    if (adapterASI) {
        DEBUGLOG(@"current method = %@ ,adapterASI = %@ is being canceld", method,adapterASI);
        [adapterASI cancel];
    }
}

@end
