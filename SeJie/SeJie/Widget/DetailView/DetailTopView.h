//
//  DetailTopView.h
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WASImageWithBackgroundView.h"
#import "CustomLabel.h"
#import "UIImageButton.h"
#import "UIButton+WebCache.h"
#import "SheJieAdapterBase.h"

@interface DetailTopView : UIView
{
    int startY, shareHeight, imageHeight;
    idBlock block;
    BOOL isDownloadedSucceed;
    dispatch_queue_t que;
    UIImage *_normalImage, *_topDefaultImage;
}
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImageButton    *favourateButton;
//@property (nonatomic, retain) UIImageButton    *treadButton;
@property (nonatomic, retain) UIButton    *shareButton;
//@property (nonatomic, retain) UIButton    *downloadButton;
@property (nonatomic, retain) UILabel     *userLabel;
@property (nonatomic, retain) UILabel     *timeLabel;
@property (nonatomic, retain) UILabel     *shareLabel;
@property (nonatomic, retain) CustomLabel *contentLabel;
@property (nonatomic, retain) UIButton    *userHeaderView;
@property (nonatomic, retain) UIView      *contentView;
@property (nonatomic, retain) id          content;
@property (nonatomic, retain) id          detailContent;
@property (nonatomic, assign) NSString    *imageURLString;
@property (nonatomic, copy)   idBlock     shareBlock;
@property (nonatomic, copy)   idBlock     userBlock;
@property (nonatomic, assign) BOOL        enableClickUser;
@property (nonatomic, assign) SheJieAdapterBase *adapter;

- (CGFloat) getContentHeight;

- (void) resetData;

- (void) saveImage;

- (void) sendRequestToServer:(int) type;

@end
