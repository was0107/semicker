//
//  UINavigationItem+extend.m
//  HuaWeiTrip
//
//  Created by zz cienet on 07/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UINavigationItem+extend.h"

B5M_FIX_CATEGORY_BUG(UINavigationItem_extend)

@implementation UINavigationItem(_extend)
- (void) setTitle:(NSString *)  theString
{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 170, 44)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:theString];
    [customLab  setBackgroundColor:[UIColor clearColor]];
//    customLab.font = FONTNAMEWITHSIZE(KFontName,kSystemFont18);
    customLab.lineBreakMode = NSLineBreakByTruncatingTail;
    customLab.minimumFontSize = 16;
    customLab.adjustsFontSizeToFitWidth = YES;
    customLab.textAlignment = NSTextAlignmentCenter;
    self.titleView = customLab;
    [customLab release];
    //return theString;
}
@end
