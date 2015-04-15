//
//  UIImageView+(ASI).m
//  micker
//
//  Created by allen.wang on 7/23/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>

#import "UIImageView+(ASI).h"


@implementation UIImageView(ASI)

- (void)setImageWithURLString:(NSString *)url
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure
{
    
//    [self setImageWithURL:[NSURL URLWithString:url]
//                  success:success
//                  failure:failure];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            failure(error);
        } else {
            success(image);
        }
    }];
}

- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholder
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure
{
//    [self setImageWithURL:[NSURL URLWithString:url]
//         placeholderImage:[UIImage imageNamed:placeholder]
//                  success:success
//                  failure:failure];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder] options:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            failure(error);
        } else {
            success(image);
        }
    }];
}

- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholder
                      options:(SDWebImageOptions)options
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure
{
//    [self setImageWithURL:[NSURL URLWithString:url]
//         placeholderImage:[UIImage imageNamed:placeholder]
//                  options:options
//                  success:success
//                  failure:failure];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder] options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            failure(error);
        } else {
            success(image);
        }
    }];
}

-(void)cancelDownloadImage
{
    [self sd_cancelCurrentImageLoad];
}

- (void) saveCurrentImageToPhoto
{
    if (!self.image) {
        return;
    }
    
    [SVProgressHUD showWithStatus:kSavePictureLoadingString];
    
    ALAssetsLibrary *library = [[[ALAssetsLibrary alloc] init] autorelease];
    [library writeImageToSavedPhotosAlbum:[self.image CGImage]
                                 metadata:nil
                          completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (error) {
             ERRLOG(@"ERROR: the image failed to be written");
             [SVProgressHUD showErrorWithStatus:kSavePictureFailedString];
         }
         else {
             INFOLOG(@"PHOTO SAVED - assetURL: %@", assetURL);
             [SVProgressHUD showSuccessWithStatus:kSavePictureSuccessString];

         }
     }];
}

@end