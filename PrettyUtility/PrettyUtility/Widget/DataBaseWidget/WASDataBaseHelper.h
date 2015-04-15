//
//  WASDataBaseHelper.h
//  micker
//
//  Created by allen.wang on 8/27/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface WASDataBaseHelper : NSObject
/**
 *	@brief	add a recored to DataBase
 *
 *	@param 	key 	key ==>docID
 *	@param 	type    type ==>tuan/good
 *	@param 	user 	user==>userName
 */
+ (void) addItemsToTable:(id) content key:(NSString *)key type:(NSUInteger) type;
+ (void) addItemsToTable:(id) content key:(NSString *)key type:(NSUInteger) type user:(NSString *)user;

+ (void) deleteWithKey:(NSString *) key  withType:(NSUInteger) type;
+ (void) deleteWithKey:(NSString *) key  withType:(NSUInteger) type user:(NSString *) user ;

+ (NSMutableArray *) getDataFrom:(NSUInteger) type;
+ (NSMutableArray *) getDataFrom:(NSUInteger) type user:(NSString *)user;

@end
