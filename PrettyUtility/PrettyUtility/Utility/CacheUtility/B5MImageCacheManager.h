//
//  B5MImageCacheManager.h
//  micker
//
//  Created by allen.wang on 7/4/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "B5MImageCacheDelegate.h"

#define kImageKey       @"key"
#define kImageDelegate  @"delegate"
#define kImageSize      @"size"
#define kImageUserInfo  @"userinfo"
#define kImageImage     @"image"


@interface B5MImageCacheManager : NSObject
{
    NSMutableDictionary     *memCache;              // memory dictionary
    NSOperationQueue        *cacheOutQueue;         // read data from file queue
    NSLock                  *theLock;
}

/**
 * @brief  Returns global shared cache instance
 *
 * @return B5MImageCacheManager global instance      
 * @note
 */
+ (B5MImageCacheManager *)sharedImageCache;

/**
 * @brief  Query the image cache asynchronousely.
 *
 * 
 * @param [in]  N/A     key         The unique key used to query the wanted image  
 * @param [in]  N/A     delegate    The delegate object to send response to   
 * @param [in]  N/A     info        An NSDictionary with some user info sent back to the delegate      
 * @param [out] N/A    
 * @return    void      
 * @note
 */
- (void)queryImageCacheForKey:(NSString *)key delegate:(id <B5MImageCacheDelegate>)delegate userInfo:(NSDictionary *)info;

/**
 * @brief  Query the memory cache for an image at a given key 
 *
 * @param [in]  N/A     key     The unique key used to store the wanted imag
 * @param [out] N/A    
 * @return      UIImage         return nil if not found
 * @note
 */
- (UIImage *)imageFromKey:(NSString *)key;

/**
 * @brief  store the image to the cache, 
 *
 * @param [in]  N/A     key     The unique key used to store the wanted imag
 * @param [in]  N/A     size    The size of the image
 * @param [in]  N/A     flag    YES, then store it 
 * @param [out] N/A    
 * @return      UIImage         return the image
 * @note
 */
- (UIImage *)storeImageforKey:(NSString *)key withSize:(CGSize) size needToStore:(BOOL) flag; 

/**
 * @brief  Clear all memory cached images
 *
 *     
 * @param [out] N/A    
 * @return      void     
 * @note
 */
- (void)clearMemory;

/**
 * @brief  Get the total size of images in memory cache
 *
 *     
 * @param [out] N/A    
 * @return      void     
 * @note
 */
- (NSUInteger)getMemorySize;

/**
 * @brief  Get the number of images in the memory cache
 *
 *     
 * @param [out] N/A    
 * @return      void     
 * @note
 */
- (NSUInteger)getMemoryCount;
@end
