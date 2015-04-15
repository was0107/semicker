//
//  WASASIAdapter.h
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASBaseAdapter.h"

#pragma mark - WASASIAdapter
/**
 *	@brief	this class is for http request
 */
@interface WASASIAdapter : WASBaseAdapter
{
    __block ASIHTTPRequest *_request;
}

/**
 *	@brief	decorate the adapter , and start a http request 
 *
 *	@param 	linkURL 	linkURL description
 *	@param 	adapter 	adapter description
 *
 *	@return	return value self
 */
- (id) initWithURL:(NSString *)linkURL method:(NSString *) method Body:(NSString *) body adatper:(WASBaseAdapter *)adapter;

@end
