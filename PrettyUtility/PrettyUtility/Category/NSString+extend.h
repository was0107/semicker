//
//  NSString+extend.h
//  micker
//
//  Created by allen.wang on 7/2/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	/** Aligns the text vertically at the top in the rect (the default). */
	WASStringVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	
	/** Aligns the text vertically in the center of the rect. */
	WASStringVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
	
	/** Aligns the text vertically at the bottom in the rect. */
	WASStringVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} WASStringVerticalTextAlignment;

@interface NSString(extend)

-(BOOL) isEmptyOrNull;

+ (NSString *) gen_uuid;

+(NSString *) md5:(NSString *)targetStr;

- (void) drawInRectEx:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode aligment:(WASStringVerticalTextAlignment)aligment;

- (NSString *) moneyFormat;

- (NSString *) md5String;
@end
