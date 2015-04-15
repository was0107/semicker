//
//  DetailMiddleItem.h
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMiddleItem : UIView
{
    __block BOOL _isDownload;
    
    UIImage *_defalutImage;
}
@property (nonatomic, assign) BOOL isDownload;
@property (nonatomic, assign) id content;
@property (nonatomic, copy)   idBlock   itemBlock;

- (void) downloadImage;

@end
