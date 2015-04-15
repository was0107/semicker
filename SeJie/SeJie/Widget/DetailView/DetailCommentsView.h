//
//  DetailCommentsView.h
// sejieios
//
//  Created by allen.wang on 1/22/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCommentsView : UIView
@property (nonatomic, copy  ) idBlock      commitBlock;
@property (nonatomic, copy  ) idBOOLBlock  animateBlock;
@property (nonatomic, retain) UIButton     *backgroundButton;

- (void) emptyContentData;

@end
