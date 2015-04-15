//
//  UIDevice+extend.m
//  micker
//
//  Created by Allen on 5/28/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIDevice+extend.h"
#include <sys/types.h>
#include <sys/sysctl.h>  
#include <mach/mach.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#import <mach/mach_host.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>

#import "B5M_Constant.h"
#import "globalDefine.h"

//#if SUPPORTS_IOKIT_EXTENSIONS
#pragma mark IOKit miniheaders

#define kIODeviceTreePlane        "IODeviceTree"

enum {
    kIORegistryIterateRecursively    = 0x00000001,
    kIORegistryIterateParents        = 0x00000002
};

typedef mach_port_t    io_object_t;
typedef io_object_t    io_registry_entry_t;
typedef char        io_name_t[128];
typedef UInt32        IOOptionBits;

CFTypeRef
IORegistryEntrySearchCFProperty(
                                io_registry_entry_t    entry,
                                const io_name_t        plane,
                                CFStringRef        key,
                                CFAllocatorRef        allocator,
                                IOOptionBits        options );

kern_return_t
IOMasterPort( mach_port_t    bootstrapPort,
             mach_port_t *    masterPort );

io_registry_entry_t
IORegistryGetRootEntry(
                       mach_port_t    masterPort );

CFTypeRef
IORegistryEntrySearchCFProperty(
                                io_registry_entry_t    entry,
                                const io_name_t        plane,
                                CFStringRef        key,
                                CFAllocatorRef        allocator,
                                IOOptionBits        options );

kern_return_t   mach_port_deallocate
(ipc_space_t                               task,
 mach_port_name_t                          name);

//#endif


B5M_FIX_CATEGORY_BUG(UIDeviceextend)



@implementation UIDevice (extend)

/*
 Platforms
 
 iFPGA ->		??
 
 iPhone1,1 ->	iPhone 1G
 iPhone1,2 ->	iPhone 3G
 iPhone2,1 ->	iPhone 3GS
 iPhone3,1 ->	iPhone 4G/AT&T
 iPhone3,2 ->	iPhone 4G/Other Carrier
 iPhone3,3 ->	iPhone 4G/Other Carrier
 
 iPod1,1   -> iPod touch 1G 
 iPod2,1   -> iPod touch 2G 
 iPod2,2   -> iPod touch 2.5G
 iPod3,1   -> iPod touch 3G
 iPod4,1   -> iPod touch 4G
 
 iPad1,1   -> iPad 1G, WiFi
 iPad1,?   -> iPad 1G, 3G <- needs 3G owner to test
 iPad2,1   -> iPad 2G
 
 i386 -> iPhone Simulator
 */
- (BOOL) isIPhone3GS {
    return ([self platformType]==UIDevice3GSiPhone);
}

#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	free(answer);
	return results;
}

- (NSString *) platform
{
	return [self getSysInfoByName:"hw.machine"];
}

#pragma mark platform type and name utils
- (NSUInteger) platformType
{
	NSString *platform = [self platform];
	// if ([platform isEqualToString:@"XX"])			return UIDeviceUnknown;
	
	if ([platform isEqualToString:@"iFPGA"])		return UIDeviceIFPGA;
    
	if ([platform isEqualToString:@"iPhone1,1"])	return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"])	return UIDevice3GiPhone;
	if ([platform isEqualToString:@"iPhone2,1"])	return UIDevice3GSiPhone;
	if ([platform isEqualToString:@"iPhone3,1"])	return UIDevice4GiPhone;
	
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod2,2"])   return UIDevice2GPlusiPod;
	if ([platform isEqualToString:@"iPod3,1"])   return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPod4,1"])   return UIDevice4GiPod;
    
	if ([platform isEqualToString:@"iPad1,1"])   return UIDevice1GiPad;
	// if ([platform isEqualToString:@"iPad2,1"])   return UIDevice2GiPad;
	
	/*
	 MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.... SORRY!
	 */
    
	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	
	if ([platform hasSuffix:@"86"])
	{
		if ([[UIScreen mainScreen] bounds].size.width < 768)
			return UIDeviceiPhoneSimulatoriPhone;
		else 
			return UIDeviceiPhoneSimulatoriPad;
        
		return UIDeviceiPhoneSimulator;
	}
	return UIDeviceUnknown;
}

- (NSString *) platformString
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDevice3GSiPhone:	return IPHONE_3GS_NAMESTRING;
		case UIDevice4GiPhone:	return IPHONE_4G_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
		case UIDevice1GiPad3G : return IPAD3G_1G_NAMESTRING;
			
		case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPhone: return IPHONE_SIMULATOR_IPHONE_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPad: return IPHONE_SIMULATOR_IPAD_NAMESTRING;
			
		case UIDeviceIFPGA: return IFPGA_NAMESTRING;
			
		default: return IPOD_FAMILY_UNKNOWN_DEVICE;
	}
}

#pragma mark  platform capabilities
- (NSUInteger) platformCapabilities
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: 
			return 
			(UIDeviceSupportsTelephony  |
			 UIDeviceSupportsSMS  |
			 UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 // UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 // UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 UIDeviceSupportsVibration  |
			 UIDeviceSupportsBuiltInProximitySensor  |
			 // UIDeviceSupportsAccessibility  |
			 // UIDeviceSupportsVoiceOver |
			 // UIDeviceSupportsVoiceControl |
			 // UIDeviceSupportsPeerToPeer |
			 // UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
			 UIDeviceSupportsEncodeAAC |
			 UIDeviceSupportsBluetooth | // M68.plist says YES for this
			 // UIDeviceSupportsNike |
			 // UIDeviceSupportsPiezoClicker |
			 UIDeviceSupportsVolumeButtons
			 );
			
		case UIDevice3GiPhone: 
			return
			(UIDeviceSupportsTelephony  |
			 UIDeviceSupportsSMS  |
			 UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 // UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 UIDeviceSupportsVibration  |
			 UIDeviceSupportsBuiltInProximitySensor  |
			 // UIDeviceSupportsAccessibility  |
			 // UIDeviceSupportsVoiceOver |
			 // UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsPeerToPeer |
			 // UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
			 UIDeviceSupportsEncodeAAC |
			 UIDeviceSupportsBluetooth |
			 // UIDeviceSupportsNike |
			 // UIDeviceSupportsPiezoClicker |
			 UIDeviceSupportsVolumeButtons
			 );
			
		case UIDevice3GSiPhone: 
			return
			(UIDeviceSupportsTelephony  |
			 UIDeviceSupportsSMS  |
			 UIDeviceSupportsStillCamera  |
			 UIDeviceSupportsAutofocusCamera |
			 UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 UIDeviceSupportsGPS  |
			 UIDeviceSupportsMagnetometer  |
			 UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 UIDeviceSupportsVibration  |
			 UIDeviceSupportsBuiltInProximitySensor  |
			 UIDeviceSupportsAccessibility  |
			 UIDeviceSupportsVoiceOver |
			 UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsPeerToPeer |
			 UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
			 UIDeviceSupportsEncodeAAC |
			 UIDeviceSupportsBluetooth |
			 UIDeviceSupportsNike |
			 // UIDeviceSupportsPiezoClicker |
			 UIDeviceSupportsVolumeButtons
			 );			
		case UIDeviceUnknowniPhone: return 0;
			
		case UIDevice1GiPod: 
			return
			(// UIDeviceSupportsTelephony  |
			 // UIDeviceSupportsSMS  |
			 // UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 // UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 // UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 // UIDeviceSupportsOPENGLES2  |
			 // UIDeviceSupportsBuiltInSpeaker  |
			 // UIDeviceSupportsVibration  |
			 // UIDeviceSupportsBuiltInProximitySensor  |
			 // UIDeviceSupportsAccessibility  |
			 // UIDeviceSupportsVoiceOver |
			 // UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsBrightnessSensor |
			 // UIDeviceSupportsEncodeAAC |
			 // UIDeviceSupportsBluetooth |
			 // UIDeviceSupportsNike |
			 UIDeviceSupportsPiezoClicker
			 // UIDeviceSupportsVolumeButtons
			 );
			
		case UIDevice2GiPod: 
		case UIDevice2GPlusiPod:
			return
			(// UIDeviceSupportsTelephony  |
			 // UIDeviceSupportsSMS  |
			 // UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 // UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 // UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 // UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 // UIDeviceSupportsVibration  |
			 // UIDeviceSupportsBuiltInProximitySensor  |
			 // UIDeviceSupportsAccessibility  |
			 // UIDeviceSupportsVoiceOver |
			 // UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsPeerToPeer |
			 // UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
             UIDeviceSupportsEncodeAAC |
             UIDeviceSupportsBluetooth |
             UIDeviceSupportsNike |
             // UIDeviceSupportsPiezoClicker |
             UIDeviceSupportsVolumeButtons
			 );
			
			
		case UIDevice3GiPod: 
			return
			(// UIDeviceSupportsTelephony  |
			 // UIDeviceSupportsSMS  |
			 // UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 // UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 // UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 // UIDeviceSupportsVibration  |
			 // UIDeviceSupportsBuiltInProximitySensor  |
			 UIDeviceSupportsAccessibility  |
			 UIDeviceSupportsVoiceOver |
			 UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsPeerToPeer |
			 UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
			 UIDeviceSupportsEncodeAAC |
			 UIDeviceSupportsBluetooth |
			 UIDeviceSupportsNike |
			 // UIDeviceSupportsPiezoClicker |
			 UIDeviceSupportsVolumeButtons
			 );			
		case UIDeviceUnknowniPod:  return 0;
			
		case UIDevice1GiPad:
			return
			(// UIDeviceSupportsTelephony  |
			 // UIDeviceSupportsSMS  |
			 // UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 // UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 // UIDeviceSupportsVibration  |
			 // UIDeviceSupportsBuiltInProximitySensor  |
			 UIDeviceSupportsAccessibility  |
			 UIDeviceSupportsVoiceOver |
			 UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsPeerToPeer |
			 UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
			 UIDeviceSupportsEncodeAAC |
			 UIDeviceSupportsBluetooth |
			 UIDeviceSupportsNike |
			 // UIDeviceSupportsPiezoClicker |
			 UIDeviceSupportsVolumeButtons |
			 UIDeviceSupportsEnhancedMultitouch
			 );	
			
		case UIDevice1GiPad3G:
			return
			(// UIDeviceSupportsTelephony  |
			 UIDeviceSupportsSMS  |
			 // UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 UIDeviceSupportsBuiltInMicrophone  |
			 UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsBuiltInSpeaker  |
			 // UIDeviceSupportsVibration  |
			 // UIDeviceSupportsBuiltInProximitySensor  |
			 UIDeviceSupportsAccessibility  |
			 UIDeviceSupportsVoiceOver |
			 UIDeviceSupportsVoiceControl |
			 UIDeviceSupportsPeerToPeer |
			 UIDeviceSupportsARMV7 |
			 UIDeviceSupportsBrightnessSensor |
			 UIDeviceSupportsEncodeAAC |
			 UIDeviceSupportsBluetooth |
			 UIDeviceSupportsNike |
			 // UIDeviceSupportsPiezoClicker |
			 UIDeviceSupportsVolumeButtons |
			 UIDeviceSupportsEnhancedMultitouch
			 );				
			
		case UIDeviceiPhoneSimulator: 
			return
			(// UIDeviceSupportsTelephony  |
			 // UIDeviceSupportsSMS  |
			 // UIDeviceSupportsStillCamera  |
			 // UIDeviceSupportsAutofocusCamera |
			 // UIDeviceSupportsVideoCamera  |
			 UIDeviceSupportsWifi  |
			 // UIDeviceSupportsAccelerometer  |
			 UIDeviceSupportsLocationServices  |
			 // UIDeviceSupportsGPS  |
			 // UIDeviceSupportsMagnetometer  |
			 // UIDeviceSupportsBuiltInMicrophone  |
			 // UIDeviceSupportsExternalMicrophone  |
			 UIDeviceSupportsOPENGLES1_1  |
			 // UIDeviceSupportsOPENGLES2  |
			 UIDeviceSupportsAccessibility  | // with limitations
			 UIDeviceSupportsVoiceOver | // with limitations
			 UIDeviceSupportsBuiltInSpeaker
             // UIDeviceSupportsVibration  |
             // UIDeviceSupportsBuiltInProximitySensor  |
             // UIDeviceSupportsVoiceControl |
             // UIDeviceSupportsPeerToPeer |
             // UIDeviceSupportsARMV7 |
             // UIDeviceSupportsBrightnessSensor |
             // UIDeviceSupportsEncodeAAC |
             // UIDeviceSupportsBluetooth |
             // UIDeviceSupportsNike |
             // UIDeviceSupportsPiezoClicker |
             // UIDeviceSupportsVolumeButtons
             );
		default: return 0;
	}
}

// Courtesy of Danny Sung <dannys@mail.com>
- (BOOL) platformHasCapability:(NSUInteger)capability 
{
    if( ([self platformCapabilities] & capability) == capability )
        return YES;
    return NO;
}

- (NSString *) platformCode
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: return @"M68";
		case UIDevice3GiPhone: return @"N82";
		case UIDevice3GSiPhone:	return @"N88";
		case UIDevice4GiPhone: return @"N89";
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPod: return @"N45";
		case UIDevice2GiPod: return @"N72";
		case UIDevice3GiPod: return @"N18"; 
		case UIDevice4GiPod: return @"N80";
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPad: return @"K48";
		case UIDevice1GiPad3G: return @"K48";  // placeholder
			
		case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
			
		default: return IPOD_FAMILY_UNKNOWN_DEVICE;
	}
}

#pragma mark  availableMemory
- (double)availableMemory {
	vm_statistics_data_t vmStats;
	mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
	
	if(kernReturn != KERN_SUCCESS) {
		return NSNotFound;
	}
	
	return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}

NSArray *getValue(NSString *iosearch)
{
    return nil;
    /*
    mach_port_t          masterPort;
    CFTypeID             propID = (CFTypeID) NULL;
    unsigned int         bufSize;
    
    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
    if (kr != noErr) return nil;
    
    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
    if (entry == MACH_PORT_NULL) return nil;
    
    CFTypeRef prop = IORegistryEntrySearchCFProperty(entry,kIODeviceTreePlane, (CFStringRef) iosearch, nil,kIORegistryIterateRecursively);
    if (!prop) return nil;
    
    propID = CFGetTypeID(prop);
    if (!(propID == CFDataGetTypeID())) 
    {
        mach_port_deallocate(mach_task_self(), masterPort);
        return nil;
    }
    
    CFDataRef propData = (CFDataRef) prop;
    if (!propData) return nil;
    
    bufSize = CFDataGetLength(propData);
    if (!bufSize) return nil;
    
    //NSString *p1 = [[[NSString alloc] initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:1] autorelease];
    NSString *p1 = [[[NSString alloc]initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:NSUTF8StringEncoding] autorelease];
    mach_port_deallocate(mach_task_self(), masterPort);
    return [p1 componentsSeparatedByString:@"/0"];
     */
}

#pragma mark  B5M Header value
- (NSString *) imei {

    NSArray *results = getValue(@"device-imei");
    if (results)
    {
        NSString *string_content = [results objectAtIndex:0];
        const char *char_content = [string_content UTF8String];
        return  [[[NSString alloc] initWithCString:(const char*)char_content  encoding:NSUTF8StringEncoding] autorelease];
        
    }
    return kEmptyString;
    
}

- (NSString *) os {
    return self.systemName;
}

- (NSString *) mob {
    return kEmptyString;
}

- (NSString *) dev {
    return self.model;
}

- (NSString *) ver {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}

- (NSString *) t {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}
@end