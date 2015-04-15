//
//  FileManager.h
//  micker
//
//  Created by Allen on 5/21/11.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileManager : NSObject 
{
}

+ (NSString *) dbPath;
/**
 * @brief empty download data , include picture files and wap files
 *
 * 
 * @param [in]  N/A 
 * @param [out] N/A
 * @return      void
 * @note
 */
+ (void) checkToEmptyDownloadDataFolders;

/**
 * @brief 从指定文件路径中获取文件大小
 *
 * 
 * @param [in]  N/A path
 * @param [out] N/A
 * @return      unsigned long long
 * @note
 */
+ (unsigned long long ) folderSizeAtPath:(NSString *) path; 

/**
 * @brief 从url中获取图片名称
 *
 * 
 * @param [in]  N/A imgURL
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString *) imageNamedFromURL:(NSString *) imgURL;

/**
 * @brief 获取下载图片文件夹路径
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString*) downloadDirectory ;

/**
 * @brief 判断指定路径下的文件是否存在
 *
 * 
 * @param [in]  N/A     filePath    FILE PATH
 * @param [out] N/A
 * @return      BOOL
 * @note
 */
+ (BOOL) isExistFile:(NSString *) filePath;


/**
 * @brief 判断指定网络路径下的文件是否存在
 *
 * 
 * @param [in]  N/A     fileURL    FILE URL
 * @param [out] N/A
 * @return      BOOL
 * @note
 */
+ (BOOL) isExistFileAtURL:(NSString *) fileURL;


/**
 * @brief 获取网页文件夹路径
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString*)downloadWebDirectory ;

/**
 * @brief 获取数据缓存文件夹路径
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString*)downloadDataDirectory ;

/**
 * @brief 删除请求数据缓存下的文件夹
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      void
 * @note
 */
+ (void) deleteOldFiles;

/**
 * @brief 删除WEB数据缓存下的文件夹
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      void
 * @note
 */
+ (void) deleteWebFiles;

/**
 * @brief 删除图片数据缓存下的文件夹
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      void
 * @note
 */
+ (void) deletePicturesFiles;

/**
 * @brief 删除指定路径下的文件夹
 *
 * 
 * @param [in]  N/A
 * @param [out] N/A
 * @return      void
 * @note
 */
+ (void) deleteFiles:(NSString *) file;

/**
 * @brief 从url中获取下载图片文件路径
 *
 * 
 * @param [in]  N/A picID
 * @param [in]  N/A imgURL
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString *) getImagePath:(NSString *) picID withImg:(NSString *)imgURL;

+ (NSString *) getMD5ImagePath:(NSString *)imgURL;


/**
 * @brief 从url中获取下载图片文件路径，并判断是否存在，如果存在则返回路径，否则返回空
 *
 * 
 * @param [in]  N/A picID
 * @param [in]  N/A imgURL
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString *) checkLocalImage:(NSString *) picID withImg:(NSString *)imgURL;

/**
 * @brief 从url中生成下载图片文件路径
 *
 * 
 * @param [in]  N/A picID
 * @param [in]  N/A imgURL
 * @param [out] N/A
 * @return      NSString
 * @note
 */
+ (NSString *) generateImageName:(NSString *)picID withImgUrl:(NSString *)imgURL;
@end
