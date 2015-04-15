//
//  B5MUtility.h
//  micker
//
//  Created by Allen on 5/21/12.
//  Copyright (c) 2012 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "B5MLog.h"


#pragma mark -
#pragma mark -B5MUtility


@interface B5MUtility : NSObject


/**
 * @brief
 *
 * 返回导航栏返回按钮
 * @param [in]  导航栏标题
 * @param [out] N/A
 * @return      按钮 
 * @note
 */
//+ (UIButton *)getLeftButtonByTitle: (NSString *)title andNavigation:(UINavigationController *)controller;
//
+ (void) storeNetWorkStatus:(NSInteger )status;

+ (NSInteger) netWorkStatus;
+ (BOOL) isWifi;

/**
 * @brief  将返回的字符串解成字典
 *
 * @param [in]　rspString  待转换的字符串
 * @param [out]　N/A
 * @return　NSDictionary
 * @note
 */
+ (NSDictionary *) stringToDictionary:(NSString *)rspString;

/**
 * @brief  将字典转换为字符串
 *
 * @param [in]　rspString  待转换的字符串
 * @param [out]　N/A
 * @return　NSString
 * @note
 */
+(NSString *) dictionaryToString:(NSMutableDictionary *)dict;

/**
 * @brief  判断返回码是否正常
 *
 * @param [in]　rspString 待判断的字符串
 * @param [out]　N/A
 * @return　BOOL
 * @note
 */
+ (BOOL) checkResultCode:(NSString *)rspString;

//
///**
// * @brief  JSON简单创建方法   deprecated, use generateJsonWithKeys:  withValues: instead
// *
// * @param [in]　keyArray    JSON尾的键数组
// * @param [in]　values      JSON尾的值数组
// * @param [out]　N/A
// * @return　NSString
// * @note    
// */
//+ (NSString *) generateJSonKeys:(NSArray *) keyArray
//                      withVaule:(NSArray *) values;


/**
 * @brief  JSON简单创建方法  use dictionary to generate json string
 *
 * @param [in]　keyArray    JSON尾的键数组
 * @param [in]　values      JSON尾的值数组
 * @param [out]　N/A
 * @return　NSString
 * @note
 */
+ (NSString *) generateJsonWithKeys:(NSArray *) keyArray
                         withValues:(NSArray *) values;

/**
 * @brief  显示提示框，不同于只有内容的框
 *
 * @param [in]　N/A  content     //title 默认为：温馨提示
 * @param [out]　N/A
 * @return　void
 * @note
 */
+ (void ) showAlertView:(NSString *) content;

/**
 * @brief  当前日期转字符串
 *
 * @param [in]　N/A  date     //当前日期
 * @param [out]　N/A
 * @return　void
 * @note
 */
+ (NSString *)shortDateStringEx:(NSDate *) date;




/*
 * app版本号 
 */
+ (NSString*)version;
//
//+ (void)createDownloadPathIfNeeded:(NSString *)filename;
//
//
//+ (NSInteger) homeViewIconStyle;
//
//+ (void)saveHomeViewIconStyle:(NSInteger)flag;
@end