//
//  UIImageView+(ASI).h
//  micker
//
//  Created by allen.wang on 7/23/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


#ifndef SuccessBlock
typedef void (^SuccessBlock)(UIImage *image);
typedef void (^FailedBlock) (NSError *error);
#endif

@interface UIImageView(ASI)

#if NS_BLOCKS_AVAILABLE
/**
 * Set the imageView `image` with an `url`.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param success A block to be executed when the image request succeed This block has no return value and takes the retrieved image as argument.
 * @param failure A block object to be executed when the image request failed. This block has no return value and takes the error object describing the network or parsing error that occurred (may be nil).
 */
- (void)setImageWithURLString:(NSString *)url
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure;

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param success A block to be executed when the image request succeed This block has no return value and takes the retrieved image as argument.
 * @param failure A block object to be executed when the image request failed. This block has no return value and takes the error object describing the network or parsing error that occurred (may be nil).
 */
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholder
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure;

/**
 * Set the imageView `image` with an `url`, placeholder and custom options.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param options The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 * @param success A block to be executed when the image request succeed This block has no return value and takes the retrieved image as argument.
 * @param failure A block object to be executed when the image request failed. This block has no return value and takes the error object describing the network or parsing error that occurred (may be nil).
 */
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholder
                      options:(SDWebImageOptions)options
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure;
#endif

-(void)cancelDownloadImage;

- (void) saveCurrentImageToPhoto;


@end
