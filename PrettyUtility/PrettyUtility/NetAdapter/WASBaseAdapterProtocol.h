//
//  WASBaseAdapterProtocol.h
//  comb5mios
//
//  Created by allen.wang on 8/20/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

typedef void (^voidBlock)();

@protocol WASBaseAdapterProtocol
@optional
/**
 *	@brief	success block
 *
 *	@param 	exec 	exec description
 */
-(void) onSuccessBlock:(voidBlock)exec;
/**
 *	@brief	faild block
 *
 *	@param 	exec 	exec description
 */
-(void) onFailedBlock:(voidBlock)exec;
/**
 *	@brief	error block
 *
 *	@param 	exec 	exec description
 */
-(void) onErrorBlock:(voidBlock)exec;
/**
 *	@brief	need to start or not
 *
 *	@param 	exec 	exec description
 */
-(BOOL) shouldStart;
/**
 *	@brief	execurate success block
 *
 *	@param 	exec 	exec description
 */
-(void) success;
/**
 *	@brief	execurate failed block
 *
 *	@param 	exec 	exec description
 */
-(void) failed;
/**
 *	@brief	execurate error block
 *
 *	@param 	exec 	exec description
 */
-(void) error;
@end
