//
//  WASBaseAdapter.h
//  micker
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASBaseAdapterProtocol.h"
#import "ASIHTTPRequest.h"

#define kKeyValueContents           @"_contents"

@interface WASBaseAdapter : NSObject<WASBaseAdapterProtocol>
@property (nonatomic, copy)     NSString *contents;
@property (nonatomic, assign)   NSInteger statusCode;

/**
 *	@brief	store the key
 *
 *	@return	a string valued
 */
- (NSString *) hash;

/**
 *	@brief	start net service
 */
- (void) startService;
@end
