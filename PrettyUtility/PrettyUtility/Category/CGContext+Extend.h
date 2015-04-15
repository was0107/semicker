//
//  CGContext+Extend.h
//  micker
//
//  Created by allen.wang on 7/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 * @brief add a round rect to ccontext
 *
 * 
 * @param [in]  N/A     ccontext  
 * @param [in]  N/A     rect   
 * @param [in]  N/A     radius      
 * @param [out] N/A    
 * @return              void    
 * @note
 */
CG_EXTERN void CGContextAddRoundedRect(CGContextRef ccontext, CGRect rect, CGFloat radius);
CG_EXTERN void CGContextAddRoundedRectComplex(CGContextRef ccontext, CGRect rect, const CGFloat radiuses[]);
