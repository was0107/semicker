//
//  UIDevice+extend.h
//  micker
//
//  Created by Allen on 5/28/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIDevice (extend)


#define IFPGA_NAMESTRING				@"iFPGA"

#define IPHONE_1G_NAMESTRING			@"iPhone 1G"
#define IPHONE_3G_NAMESTRING			@"iPhone 3G"
#define IPHONE_3GS_NAMESTRING			@"iPhone 3GS" 
#define IPHONE_4G_NAMESTRING			@"iPhone 4G" 
#define IPHONE_UNKNOWN_NAMESTRING		@"Unknown iPhone"

#define IPOD_1G_NAMESTRING				@"iPod touch 1G"
#define IPOD_2G_NAMESTRING				@"iPod touch 2G"
#define IPOD_2GPLUS_NAMESTRING			@"iPod touch 2G Plus"
#define IPOD_3G_NAMESTRING				@"iPod touch 3G"
#define IPOD_4G_NAMESTRING				@"iPod touch 4G"
#define IPOD_UNKNOWN_NAMESTRING			@"Unknown iPod"

#define IPAD_1G_NAMESTRING				@"iPad 1G"
#define IPAD3G_1G_NAMESTRING			@"iPad3G 1G"

#define IPOD_FAMILY_UNKNOWN_DEVICE			@"Unknown device in the iPhone/iPod family"

#define IPHONE_SIMULATOR_NAMESTRING			@"iPhone Simulator"
#define IPHONE_SIMULATOR_IPHONE_NAMESTRING	@"iPhone Simulator"
#define IPHONE_SIMULATOR_IPAD_NAMESTRING	@"iPad Simulator"

typedef enum {
	UIDeviceUnknown,
	UIDeviceiPhoneSimulator,
	UIDeviceiPhoneSimulatoriPhone,
	UIDeviceiPhoneSimulatoriPad,
	UIDevice1GiPhone,
	UIDevice3GiPhone,
	UIDevice3GSiPhone,
	UIDevice4GiPhone,
	UIDevice1GiPod,
	UIDevice2GiPod,
	UIDevice2GPlusiPod,
	UIDevice3GiPod,
	UIDevice4GiPod,
	UIDevice1GiPad,
	UIDevice1GiPad3G,
	UIDeviceUnknowniPhone,
	UIDeviceUnknowniPod,
	UIDeviceIFPGA,
} UIDevicePlatform;

typedef enum {
	UIDeviceFirmware2,
	UIDeviceFirmware3,
	UIDeviceFirmware4,
} UIDeviceFirmware;

enum {
	UIDeviceSupportsTelephony = 1 << 0,
	UIDeviceSupportsSMS = 1 << 1,
	UIDeviceSupportsStillCamera = 1 << 2,
	UIDeviceSupportsAutofocusCamera = 1 << 3,
	UIDeviceSupportsVideoCamera = 1 << 4,
	UIDeviceSupportsWifi = 1 << 5,
	UIDeviceSupportsAccelerometer = 1 << 6,
	UIDeviceSupportsLocationServices = 1 << 7,
	UIDeviceSupportsGPS = 1 << 8,
	UIDeviceSupportsMagnetometer = 1 << 9,
	UIDeviceSupportsBuiltInMicrophone = 1 << 10,
	UIDeviceSupportsExternalMicrophone = 1 << 11,
	UIDeviceSupportsOPENGLES1_1 = 1 << 12,
	UIDeviceSupportsOPENGLES2 = 1 << 13,
	UIDeviceSupportsBuiltInSpeaker = 1 << 14,
	UIDeviceSupportsVibration = 1 << 15,
	UIDeviceSupportsBuiltInProximitySensor = 1 << 16,
	UIDeviceSupportsAccessibility = 1 << 17,
	UIDeviceSupportsVoiceOver = 1 << 18,
	UIDeviceSupportsVoiceControl = 1 << 19,
	UIDeviceSupportsBrightnessSensor = 1 << 20,
	UIDeviceSupportsPeerToPeer = 1 << 21,
	UIDeviceSupportsARMV7 = 1 << 22,
	UIDeviceSupportsEncodeAAC = 1 << 23,
	UIDeviceSupportsBluetooth = 1 << 24,
	UIDeviceSupportsNike = 1 << 25,
	UIDeviceSupportsPiezoClicker = 1 << 26,
	UIDeviceSupportsVolumeButtons = 1 << 27,
	UIDeviceSupportsEnhancedMultitouch = 1 << 28, // http://www.boygeniusreport.com/2010/01/13/apples-tablet-is-an-iphone-on-steroids/
};

/*
 * 判断是否3GS手机
 */
- (BOOL) isIPhone3GS;

//
- (NSString *) platform;
- (NSUInteger) platformType;
- (NSUInteger) platformCapabilities;
- (NSString *) platformString;
- (NSString *) platformCode;

/*
 * Available device memory in MB 
 */
@property(readonly) double availableMemory;

/*
 * 手机辨识码 
 */
@property(readonly) NSString *imei;

/*
 * 操作系统 
 */
@property(readonly) NSString *os;

/*
 * 手机号码 
 */
@property(readonly) NSString *mob;

/*
 * 设备名称 
 */
@property(readonly) NSString *dev;

/*
 * app版本号 
 */
@property(readonly) NSString *ver;

/*
 * 当前时间戳，从1970年1月1日0时开始到当前时间的毫秒数 
 */
@property(readonly) NSString *t;

NSArray *getValue(NSString *iosearch);


@end
