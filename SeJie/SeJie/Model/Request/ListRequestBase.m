//
//  ListRequestBase.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"
#import "UIDevice+extend.h"
#import "UserDefaultsManager.h"

@implementation ListRequestBase
@synthesize method= _method;

- (BOOL) checkArray:(NSMutableArray *) array
{
    if (array && [array count] > 0) {
        return YES;
    }
    return NO;
}

- (BOOL) checkString:(NSString *) string
{
    if (string && [string length] > 0) {
        return YES;
    }
    return NO;
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray array];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray array];
}

- (NSString *) toJsonString
{
    NSMutableArray *keys = [[[NSMutableArray alloc] initWithArray:[self commonKeysArray]] autorelease];
    [keys addObjectsFromArray:[self keyArrays]];
    NSMutableArray *values = [[[NSMutableArray alloc] initWithArray:[self commonParamsArray]] autorelease];
    [values addObjectsFromArray:[self valueArrays]];
    NSString *result = [B5MUtility generateJsonWithKeys:keys withValues:values];
    return [NSString stringWithFormat:@"%@?1=1%@",self.method, result];
}

// Common参数
- (NSArray *) commonKeysArray
{
    return [NSArray array];
//    return [NSArray arrayWithObjects:kDeviceIMEI, kDeviceMOB, kDeviceOS, kDeviceDEV, kDeviceVER,
//            kDeviceCHNL, kDeviceTIME, kDid, kGender, nil];
}

- (NSArray *) commonParamsArray
{
    return [NSArray array];
//    UIDevice *device = [UIDevice currentDevice];
//    NSString *time   = device.t;
//    NSString *chnl   = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
//    if (!chnl) {
//        chnl = @"";
//    }
//
//    NSArray *values = [NSArray arrayWithObjects:device.imei, device.mob, device.os, device.dev, device.ver,
//                        chnl, time, [UserDefaultsManager deviceID], kIntToString([UserDefaultsManager userGender]), nil];
//    return values;
}

@end
