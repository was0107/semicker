//
//  UserDefaultsManager.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultsKeys.h"

@interface UserDefaultsManager : NSObject
/**
 * @brief  获取用户性别
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (NSInteger)userGender;
+(BOOL) isFirstUse;
+ (void)saveUserGender:(NSInteger)gender;

/**
 * @brief  获取用户信息
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (NSString *) userId;
+ (void)saveUserId:(NSString *)userId;
+ (NSString *) userName;
+ (void)saveUserName:(NSString *)userName;
+ (void)clearUserId;

+ (NSString *) userIcon;
+ (void)saveUserIcon:(NSString *)userIcon;

+ (NSString *) userCoverIcon;
+ (void)saveUserCoverIcon:(NSString *)userCoverIcon;

+ (NSString *) userType;
+ (void)saveUserType:(NSString *)userType;


+ (NSUInteger) updateTimes;
+ (void) saveUpdateTimes:(NSUInteger ) time;

/**
 * @brief  获取保存在本地的设备id
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSString
 * @note
 */
+ (NSString *) deviceID;

+ (void) saveDeviceID:(NSString *)did;

/**
 * @brief  获取用户收入
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (NSString*)shortDateString;

+ (void) SavePushID:(NSString *)pushID;

+ (NSString *) pushID;

+ (NSInteger) pushIDChanged;
+ (NSString *) theLastChangedCity;


+ (void)savePushIDChange:(NSInteger)change;

/**
 * @brief  2G/3G省流量模式 -- default 0 关闭
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (NSInteger) netTrafficMode;

+ (void)saveNetTrafficMode:(NSInteger)flag;


/**
 * @brief  设置与获取。切换到3G模式下，是否需要提醒 -- default 1 提醒
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (void) storeNetWorkChangedTipStatus:(NSUInteger)status;
+ (NSUInteger) netWorkChangedTipStatus;
//

@end
