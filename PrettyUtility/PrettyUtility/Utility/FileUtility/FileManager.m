//
//  FileManager.m
//  micker
//
//  Created by Allen on 5/21/11.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "FileManager.h"
#import "B5MUtility.h"
#import "NSString+extend.h"

#define kMB         (1024 * 1024)
#define k512MB      (512*kMB)

static NSString *gDownloadPictureFilePath   = nil;
static NSString *gDownloadWapFilePath       = nil;


@implementation FileManager

+ (NSString *) dbPath
{
    NSString *path = [[[NSString alloc] initWithString:[NSHomeDirectory() 
                                                        stringByAppendingPathComponent:@"Documents"]] autorelease];
//	path = [path  stringByAppendingPathComponent:@"DataBase/"];
    NSLog(@"PATH = %@", path);
    return path;
}


+ (unsigned long long ) folderSizeAtPath:(NSString *) path 
{
    NSFileManager *manager  = [NSFileManager defaultManager];
    NSDictionary *attribute = [manager attributesOfItemAtPath:path error:nil];
        
    NSUInteger fileSize = [[attribute objectForKey:NSFileSize] unsignedLongLongValue];
    return fileSize;
}

+ (void) checkToEmptyDownloadDataFolders
{
    if (([self folderSizeAtPath:[self downloadDirectory]]  + 
         [self folderSizeAtPath:[self downloadWebDirectory]] )   > k512MB) 
    {
        [self deleteWebFiles];
        [self deletePicturesFiles];
        
        WARNLOG(@"File Size reach the max size! ");
    }
}


+ (NSString*)downloadDirectory 
{
    if (gDownloadPictureFilePath) {
        return gDownloadPictureFilePath;
    }
	NSString *path = [[[NSString alloc] initWithString:[NSHomeDirectory() 
                                                        stringByAppendingPathComponent:@"Documents"]] autorelease];
	path = [path  stringByAppendingPathComponent:@"Downloads/"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) 
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    gDownloadPictureFilePath = [path retain];
    
    return path;
}

+ (NSString*)downloadWebDirectory 
{
    if (gDownloadWapFilePath) {
        return gDownloadWapFilePath;
    }
	NSString *path = [[[NSString alloc] initWithString:[NSHomeDirectory() 
                                                        stringByAppendingPathComponent:@"Documents"]] autorelease];
	path = [path  stringByAppendingPathComponent:@"Caches/"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) 
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    gDownloadWapFilePath = [path retain];
	return path;
}

+ (NSString*)downloadDataDirectory 
{
	NSString *path = [[[NSString alloc] initWithString:[NSHomeDirectory() 
                                                        stringByAppendingPathComponent:@"Documents"]] autorelease];
	path = [path  stringByAppendingPathComponent:@"Datas/"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) 
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
	return path;
}

+ (void) deleteFiles:(NSString *) file
{
    NSString *path = [[[NSString alloc] initWithString:[NSHomeDirectory() 
                                                        stringByAppendingPathComponent:@"Documents"]] autorelease];
	path = [path  stringByAppendingPathComponent:file];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager removeItemAtPath:path error:nil]) {
        
    }
}

+ (void) deleteOldFiles
{
    [self deleteFiles:@"Datas/"];
    [self downloadDataDirectory];

}

+ (void) deletePicturesFiles
{    
    [self deleteFiles:@"Downloads/"];
    [gDownloadPictureFilePath release], gDownloadPictureFilePath = nil;
    [self downloadDirectory];
}

+ (void) deleteWebFiles
{    
    [self deleteFiles:@"Caches/"];
    [gDownloadWapFilePath release], gDownloadWapFilePath = nil;
    [self downloadWebDirectory];
}

+ (BOOL) isExistFile:(NSString *) filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}

+ (BOOL) isExistFileAtURL:(NSString *)fileURL
{
    if (!fileURL) {
        return NO;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:fileURL];
}


+ (NSString *) imageNamedFromURL:(NSString *) imgURL
{
    NSRange  range   = [imgURL rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *subString;
    if (range.location != NSNotFound) 
    {                
        subString = [imgURL substringFromIndex:range.location + 1];
    }
    else
    {
        return nil;
    }    
    return subString;

}

+ (NSString *) generateImageName:(NSString *)picID withImgUrl:(NSString *)imgURL
{    
    NSString *subString = [self imageNamedFromURL:imgURL];
    NSString *result = [NSString stringWithFormat:@"%@_%@",picID,subString];
    return result;
}

+ (NSString *) getImagePath:(NSString *)picID withImg:(NSString *)imgURL
{
    NSString *currentPath = [NSString stringWithFormat:@"%@/%@",
                             [self downloadDirectory],
                             [self generateImageName:picID withImgUrl:imgURL]];
    //    NSLog(@"%@", currentPath);
    return currentPath;
}

+ (NSString *) getMD5ImagePath:(NSString *)imgURL
{
    NSString *currentPath = [NSString stringWithFormat:@"%@/%@",[self downloadDirectory],[imgURL md5String]];
    return currentPath;
}

+ (NSString *) checkLocalImage:(NSString *) picID withImg:(NSString *)imgURL
{    
    NSFileManager * file = [NSFileManager defaultManager];  
    NSString *currentPath = [self getImagePath:picID withImg:imgURL];
    if ([file isReadableFileAtPath:currentPath ]) 
    {
        return currentPath;
    }
    return nil;
}
@end
