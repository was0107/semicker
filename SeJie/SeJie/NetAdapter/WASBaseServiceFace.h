//
//  WASBaseServiceFace.h
//  b5mUtility
//
//  Created by allen.wang on 11/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASNetServer.h"
#import "BlockDefines.h"

@interface WASBaseServiceFace : NSObject

/*!
 *	@brief	service factory
 *
 *	@param 	method      method 
 *	@param 	body        body    
 *	@param 	success 	success 
 *	@param 	failed      failed 
 *	@param 	error       error 
 *	@param 	cached      cached 
 *
 *	@return	void 
 */
+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body;
+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success;
+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed;
+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error;
+ (void)serviceWithMethod:(NSString *) method body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error withCached:(BOOL) cached;


+ (void)serviceUploadMethod:(NSString *) method data:(NSData *) data body:(NSString *) body onSuc:(idBlock) success onFailed:(idBlock) failed onError:(idBlock) error;

+ (void)cancelServiceMethod:(NSString *) method;

@end
