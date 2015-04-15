//
//  UpdateTipView.h
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateTipView : UIView

@property (nonatomic, retain) UILabel       *updateLabel;
@property (nonatomic, retain) UIImageView   *bgImageView;

- (void) showViewAnimated ;

- (void) setUpdateText : (NSString *) text ;

@end
