//
//  B5MPreprocessorMacros.h
//  b5mUtility
//
//  Created by allen.wang on 10/30/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#ifndef b5mUtility_B5MPreprocessorMacros_h
#define b5mUtility_B5MPreprocessorMacros_h




/**
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#ifndef B5M_FIX_CATEGORY_BUG
#define B5M_FIX_CATEGORY_BUG(name)   @interface B5M_FIX_CATEGORY_BUG_##name : NSObject @end \
                                    @implementation B5M_FIX_CATEGORY_BUG_##name @end
#endif
#endif
