//
//  UITableViewCell+extend.h
//  DSM_iPad
//
//  Created by Wang Dean on 11-9-26.
//  Copyright 2011 cienet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UITableViewCell (UITableViewCellExt)

- (void)setBackgroundImage:(UIImage*)image;
- (void)setBackgroundImageByName:(NSString*)imageName;

@end

