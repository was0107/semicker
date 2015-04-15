//
//  B5MCacheManager.h
//  micker
//
//  Created by allen.wang on 6/11/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface B5MCacheManager : NSObject
{
}
@property(nonatomic, retain) NSMutableDictionary *cacheDictionary;//   = nil;
@property(nonatomic, retain) NSMutableArray      *storedArray;//   = nil;
@property(nonatomic, assign) BOOL               enableExtendInfo;


/**
 * @brief singleton of B5MCacheManager
 *
 * 
 * @param [in]  N/A    
 * @param [out] N/A    
 * @return     B5MCacheManager *
 * @note
 */
+ (B5MCacheManager *) sharedCacheManager;


/**
 * @brief release singleton of B5MCacheManager
 *
 * 
 * @param [in]  N/A    
 * @param [out] N/A    
 * @return     void
 * @note
 */
- (void) releaseCacheManager;

/**
 * @brief restore cache data to file and clear memory cache
 *
 * 
 * @param [in]  N/A    
 * @param [out] N/A    
 * @return     void
 * @note
 */
- (void) enterBackGround;

/**
 * @brief add content to the dictionary
 *
 * 
 * @param [in]  N/A    key      
 * @param [in]  N/A    content      
 * @param [out] N/A    
 * @return     void
 * @note
 */
- (void) addItemToCache:(NSString *) key withContent:(id ) content;

/**
 * @brief get content from the dictionary
 *
 * 
 * @param [in]  N/A    key      
 * @param [out] N/A    
 * @return     id      if the key exist , then return it,else , return nil
 * @note
 */
- (id) getContentWithKey:(NSString *) key;

/**
 * @brief check the name, 
 *
 * 
 * @param [in]  N/A    name      
 * @param [out] N/A    
 * @return     BOOL    YES: need to store , NO: do not need to store
 * @note
 */
- (BOOL) isNeedToStoreToCache:(NSString *) name;

/**
 * @brief write cacheDictionay to the file
 *
 * 
 * @param [in]  N/A          
 * @param [out] N/A    
 * @return     void
 * @note
 */
- (void) writeToFileForBackUp;

/**
 * @brief remove item when count is zero with key
 *
 * 
 * @param [in]  N/A          key
 * @param [out] N/A    
 * @return     void
 * @note
 */
- (void) removeItemWithKey:(NSString *) key;

- (NSString *) dataFilePath;


@end
