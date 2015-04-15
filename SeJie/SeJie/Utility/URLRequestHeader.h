//
//  URLRequestHeader.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kDeviceIMEI                     @"imei"
#define kDeviceMOB                      @"mob"
#define kDeviceOS                       @"os"
#define kDeviceDEV                      @"dev"
#define kDeviceVER                      @"ver"
#define kDeviceCHNL                     @"chnl"
#define kDeviceTIME                     @"t"
#define kDeviceSIGN                     @"sign"
#define kDeviceMETHOD                   @"m"
#define kDeviceBODY                     @"body"
#define kGender                         @"gender"
#define kAge                            @"age"
#define kApp_key                        @"appkey"
#define kApp_secret                     @"app_secret"

//new key & secret for 1.0.4, add barcode security
#define kApp_key_value                  @"12217906"
#define kApp_secret_value               @"d0fbde9d55503419823272497e6e43a2"

#define kDid                            @"did"          //设备id,由服务器生成。客户端初始化后保存在本地


//#define kApp_key_value                  @"88201281"       //for 1.0.2
//#define kApp_secret_value               @"c0c29d89bf7f978f5e943ac30f7a5de2"
//#define kApp_key_value                  @"30232017"       //test barcode key
//#define kApp_secret_value               @"bbc104e50a96e030aec830086859a12e"   //test barcode key

