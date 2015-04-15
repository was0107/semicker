//
//  WASBaseAdapter.h
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASBaseAdapterProtocol.h"

#define kKeyValueContents           @"_contents"

@interface WASBaseAdapter : NSObject<WASBaseAdapterProtocol>
{
    voidBlock _onSuccessBlock;
    voidBlock _onFailedBlock;
    voidBlock _onErrorBlock;
}
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, assign) NSInteger statusCode;

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
