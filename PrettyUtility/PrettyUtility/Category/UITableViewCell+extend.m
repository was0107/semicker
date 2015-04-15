//
//  UITableViewCell+extend.m
//  DSM_iPad
//
//  Created by Wang Dean on 11-9-26.
//  Copyright 2011 cienet. All rights reserved.
//

#import "UITableViewCell+extend.h"

B5M_FIX_CATEGORY_BUG(UITableViewCellUITableViewCellExt)

@implementation UITableViewCell (UITableViewCellExt)

- (void)setBackgroundImage:(UIImage*)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    self.backgroundView = imageView;
    [imageView release];
    
}

- (void)setBackgroundImageByName:(NSString*)imageName
{
    [self setBackgroundImage:[UIImage imageNamed:imageName]];
}


@end
