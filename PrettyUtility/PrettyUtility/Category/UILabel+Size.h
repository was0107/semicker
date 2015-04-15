//
//  UILabel+Size.h
//  B5MApp
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (Size)

- (void)setTextAutoResize:(NSString*)text;
- (void)setFontAutoResize:(UIFont*)font;
- (void)autoResize;

- (void)adjustFrameWithTextRight;
@end
