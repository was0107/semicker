//
//  WASASILogAdatper.h
//  micker
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASBaseAdapter.h"

@interface WASASILogAdatper : WASBaseAdapter
/**
 *	@brief	decorate the appoint adapter
 *
 *	@param 	adapter 	adapter needed to be decoreated
 *
 *	@return	return value self
 */
- (id) initWithAdapter:(WASBaseAdapter *)adapter;

@end
