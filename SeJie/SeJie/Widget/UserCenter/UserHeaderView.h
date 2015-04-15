//
//  UserHeaderView.h
// sejieios
//
//  Created by Jarry on 13-1-23.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

@interface UserHeaderView : UIView <SDWebImageManagerDelegate>

@property (nonatomic, retain)   UIImageView *photoImageButton;
@property (nonatomic, retain)   UILabel     *userNameLabel;
@property (nonatomic, copy)     idBlock     block;


- (void) updatePhotoImage:(NSString *)url;

- (void) resetPhotoImage;


@end
