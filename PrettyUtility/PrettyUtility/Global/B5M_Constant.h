//
//  B5M_Constant.h
//  micker
//
//  Created by Jarry Zhu on 12-5-15.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#ifndef micker_B5M_Constant_h
#define micker_B5M_Constant_h

// 判断是否iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kHeightIncrease  (iPhone5?88:0)

//
// ARC on iOS 4 and 5
//
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0 && !defined (GM_DONT_USE_ARC_WEAK_FEATURE)

#define b5m_weak   weak
#define __b5m_weak __weak
#define b5m_nil(x)

#else

#define b5m_weak   unsafe_unretained
#define __b5m_weak __unsafe_unretained
#define b5m_nil(x) x = nil

#endif


#endif
