//
//  B5MImageCacheDelegate.h
//  micker
//
//  Created by allen.wang on 7/4/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
@class B5MImageCacheManager;


@protocol B5MImageCacheDelegate <NSObject>

@optional

/**
 *  @brief  Called when [B5MImageCacheManager queryImageCacheForKey:delegate:userInfo:] retrived the image from cache
 *
 *  @param [in]  N/A      imageCache    The cache store instance
 *  @param [in]  N/A      image         The requested image instance
 *  @param [in]  N/A      key           The requested image cache key
 *  @param [in]  N/A      info          The provided user info dictionary
 */
- (void)imageCache:(B5MImageCacheManager *)imageCache didFindImage:(UIImage *)image forKey:(NSString *)key userInfo:(NSDictionary *)info;

/**
 *  @brief  Called when [B5MImageCacheManager queryImageCacheForKey:delegate:userInfo:] did not find the image in the cache
 *
 * @param [in]  N/A      imageCache    The cache store instance
 * @param [in]  N/A      key           The requested image cache key
 * @param [in]  N/A      info          The provided user info dictionary
 */
- (void)imageCache:(B5MImageCacheManager *)imageCache didNotFindImageForKey:(NSString *)key userInfo:(NSDictionary *)info;
@end
