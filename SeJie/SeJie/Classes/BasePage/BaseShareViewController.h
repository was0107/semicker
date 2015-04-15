//
//  BaseShareViewController.h
// sejieios
//
//  Created by Jarry on 13-1-16.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "PlaceHolderTextView.h"

#define kScrollViewFrame        CGRectMake(20, 44, 280, 420)
#define kShareViewFrame         CGRectMake(0, 115, 280, 144)


@interface BaseShareViewController : BaseTitleViewController <UIActionSheetDelegate>

@property (nonatomic, retain)   UIImageView         *shareImageView;
@property (nonatomic, retain)   UIScrollView        *scrollView;
@property (nonatomic, retain)   UIView              *shareView;
@property (nonatomic, retain)   PlaceHolderTextView *contentTextView;
@property (nonatomic, retain)   UIButton            *countButton;


- (void) setShareImage:(UIImage *)image;

- (void) shareRequest;

- (NSString *) shareText;

- (void) enableButton;

@end
