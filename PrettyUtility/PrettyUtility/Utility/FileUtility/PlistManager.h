//
//  PlistManager.h
//  micker
//
//  Created by Allen on 5/21/11.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlistManager : NSObject {
    
    NSMutableDictionary *sourceData_;                    //PlistManager数据源
    
}
@property (nonatomic, retain) NSMutableDictionary *sourceData;

/**
 * @brief 获取PlistManager单例
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      PlanAndRemindSourceData
 * @note
 */
+ (PlistManager *)plistManagerInstance;

/**
 * @brief 返回sourceData
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      
 * @note
 */
- (NSDictionary *)getAllData;

/**
 * @brief 获取PlistManager Keys总数
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      
 * @note
 */
- (NSUInteger)getKeysCount;

/**
 * @brief 获取PlistManager 中对应Key的总数
 *
 * 
 * @param [in]  N/A  key 键值
 * @param [out] N/A
 * @return           key 对应字典的记数
 * @note
 */
- (NSUInteger)getKeyCount:(NSString *)key;

/**
 * @brief 从文件中读取数据
 *
 * 
 * @param [in]  N/A fileName  plist文件名称
 * @param [out] N/A
 * @return      
 * @note
 */
- (void)readDataFromPlist:(NSString *)fileName;

/**
 * @brief 获取PlistManager 中对应键值的值
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      
 * @note
 */
- (id)getDataWithKey:(NSString *)key1;
- (id)getDataWithKey:(NSString *)key1  withKey:(NSString *)key2;
- (id)getDataWithKey:(NSString *)key1  withKey:(NSString *)key2  withKey:(NSString *)key3;


/**
 * @brief 获取PlistManager 中位于index1的键
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      
 * @note
 */
- (id)getKey1:(NSUInteger) index1;

@end
