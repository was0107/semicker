//
//  FrameDefines.h
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#ifndef b5mappsejieios_FrameDefines_h
#define b5mappsejieios_FrameDefines_h

#define kNavigationBarHeight    44
#define kFilterViewWidth        206
#define kTopCellHeight          104
#define kBoundsHeight           (kHeightIncrease + 480)
#define kContentBoundsHeight    (kBoundsHeight - 20 - 44)
#define kContentFrame           CGRectMake(0,0,320,kContentBoundsHeight)
#define kContentWithBarFrame    CGRectMake(0,64,320,kContentBoundsHeight)

#define kHeaderFrame            CGRectMake(0, 20, 320, 44)
#define kHeaderTitleFrame       CGRectMake(50, 0, 220, 44)
#define kHeaderLeftFrame        CGRectMake(5, 3, 40, 38)
#define kHeaderRightFrame       CGRectMake(275, 3, 40, 38)
#define kHeaderDoneFrame        CGRectMake(266, 3, 46, 38)
#define kHeaderUpdateFrame      CGRectMake(203, 3, 22, 14)
#define kHeaderDotImageFrame    CGRectMake(43, 3, 8, 8)

#define kFilterUpdateFrame      CGRectMake(140, 3, 22, 14)

#define kToolBarFrame           CGRectMake(0,kBoundsHeight-20-36,320,36)

#define kMiddleGoodsHeight      136

#define kAboutLogoFrame         CGRectMake(0, 45, 320, 140+kHeightIncrease/2)
#define kAboutTableFrame        CGRectMake(0, 180+kHeightIncrease/2, 320, 220)
#define kAboutVersionFrame      CGRectMake(0, 400+kHeightIncrease, 320, 15)
#define kAboutQQGroupFrame      CGRectMake(0, 420+kHeightIncrease, 320, 15)

#define kCommentsBottomHeight   40
#define kCommentsBottomFrame    CGRectMake(0,kBoundsHeight - 60,320,kCommentsBottomHeight)


#define kScreenContentFrame     CGRectMake(0,0,320,kBoundsHeight)




//setting page
#define kSettingTopViewFrame    CGRectMake(5,44+5,310,300)
#define kSettingBgFrame         CGRectMake(5,5,300,255)
#define kSettingHeaderFrame     CGRectMake(117,112,80,80)
#define kSettingSetHeaderFrame  CGRectMake(15,210,118,29)
#define kSettingSetBGFrame      CGRectMake(177,210,118,29)
#define kSettingFemaleFrame     CGRectMake(257,270,44,21)
#define kSettingMaleFrame       CGRectMake(214,270,44,21)
#define kSettingNickFrame       CGRectMake(5,270,200,23)
#define kSettingLogoutFrame     CGRectMake(5,44+5+310,310,37)


#endif
