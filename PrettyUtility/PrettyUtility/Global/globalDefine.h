//
//  globalDefine.h
//  micker
//
//  Created by Allen on 5/21/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "B5MUtility.h"
#import "SVProgressHUD.h"
#import "B5M_Constant.h"
#import "B5MPreprocessorMacros.h"
#import "BlockDefines.h"


#ifndef micker_globalDefine_h
#define micker_globalDefine_h


#define kBarcodeNewInterface    0

//empty string
#define kEmptyString            @""


//生成tag
#define MakeTag(x, y) (((x)<<16) + (y))

//从32位Tag中分离supplier Tag
#define SupplierTag(x) ((x)>>16)

//从32位Tag中分离price Tag
#define PriceTag(x) (((x)<<16)>>16)


//release marco
#define TT_RELEASE_SAFELY(__POINTER)        {[__POINTER release];   __POINTER = nil;}       // relase safety
#define TT_INVALIDATE_SAFELY(__TIMER)       {[__TIMER invalidate];   __TIMER = nil;}        // invalidate safety

//string format
#define kStringFormatInterger               @"%ld"
#define kIntToString(x)                     [NSString stringWithFormat:kStringFormatInterger,x]
#define kBOOLToString(x)                    [NSNumber numberWithBool:x]

#define ValiedCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }


//color marco
#define kClearColor                 [UIColor clearColor]        // clear color
#define kRedColor                   [UIColor redColor]          // red color
#define kGreenColor                 [UIColor greenColor]        // green color
#define kBlueColor                  [UIColor blueColor]         // blue color
#define kWhiteColor                 [UIColor whiteColor]        // white color
#define kBlackColor                 [UIColor blackColor]        // black color 
#define kGrayColor                  [UIColor grayColor]         // gray color 
#define kLightGrayColor             [UIColor lightGrayColor]    // light gray color
#define kOrangeColor                [UIColor orangeColor]       // orange color
#define kDarkTextColor              [UIColor darkTextColor]
#define kDarkGrayColor              [UIColor darkGrayColor]

#define kBackGroundColor            @"d9d9d9"
#define kBtnFontColor               @"ec7020"
#define kListBgColor                @"fff4e6"
#define kSwitchColor                @"ff9900"
#define kTitleFontColor             @"ff9900" //@"ff3399"
#define kSlideFontColor             @"ff9900"
#define kFilterFontColor            @"575757"


//frame marco
#define kContentViewFrame           CGRectMake(0, 0, 320, 480 + kHeightIncrease)

// font marco
#define FONTNAMEWITHSIZE(fontName,fontSize)     [UIFont fontWithName:fontName size:fontSize] 
#define TNRFONTSIZE(X)                          FONTNAMEWITHSIZE(@"Times New Roman",X)
#define TNRFontSIZEBIG(X)                       FONTNAMEWITHSIZE(@"TimesNewRomanPS-BoldMT",X)
#define SYSTEMFONT(X)                           [UIFont systemFontOfSize:X]
#define BOLDSYSTEMFONT(X)                       [UIFont boldSystemFontOfSize:X]

#define kDefaultFontName            @"STHeitiSC-Medium"

#define kFontSize10                 10
#define kFontSize11                 11
#define kFontSize12                 12
#define kFontSize13                 13
#define kFontSize14                 14
#define kFontSize15                 15
#define kFontSize16                 16
#define kFontSize17                 17
#define kFontSize18                 18
#define kFontSize19                 19
#define kFontSize20                 20
#define kFontSize21                 21
#define kFontSize22                 22
#define kFontSize23                 23
#define kFontSize24                 24

#define kSystemFontSize10           10
#define kSystemFontSize11           11
#define kSystemFontSize12           12
#define kSystemFontSize13           13
#define kSystemFontSize14           14
#define kSystemFontSize15           15
#define kSystemFontSize16           16
#define kSystemFontSize17           17
#define kSystemFontSize18           18
#define kSystemFontSize19           19
#define kSystemFontSize20           20
#define kSystemFontSize21           21
#define kSystemFontSize22           22
#define kSystemFontSize23           23
#define kSystemFontSize24           24



#endif
