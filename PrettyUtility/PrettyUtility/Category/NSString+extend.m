//
//  NSString+extend.m
//  micker
//
//  Created by allen.wang on 7/2/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "NSString+extend.h"
#import <CommonCrypto/CommonDigest.h>

B5M_FIX_CATEGORY_BUG(NSStringextend)


@implementation NSString(extend)

-(BOOL) isEmptyOrNull 
{
    if (!self) 
    {
        // null object
        return true;
    } else {
        NSString *trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) 
        {
            // empty string
            return true;
        } else 
        {
            // is neither empty nor null 
            return false;
        }
    }
}

+(NSString *) md5:(NSString *)targetStr { 
    const char *cStr = [targetStr UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],   result[3], 
            result[4],  result[5],  result[6],   result[7],
            result[8],  result[9],  result[10],  result[11],
            result[12], result[13], result[14],  result[15] ];
    
}

- (NSString *) md5String
{
    return [[self class] md5:self];
}

+ (NSString *) gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

- (void) drawInRectEx:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode  aligment:(WASStringVerticalTextAlignment)aligment
{
    CGSize newSize = [self sizeWithFont:font constrainedToSize:rect.size lineBreakMode:lineBreakMode];
    CGRect newRect = rect;
    if (UIControlContentVerticalAlignmentTop == aligment) {
        newRect = CGRectMake(rect.origin.x, rect.origin.y, newSize.width,newSize.height);
    }
    else if(UIControlContentVerticalAlignmentCenter == aligment) {
        newRect.origin.y += (rect.size.height - newSize.height)/2;
    }
    else if(UIControlContentVerticalAlignmentBottom == aligment) {
        newRect.origin.y += (rect.size.height - newSize.height);
    }
    
    [self drawInRect:newRect withFont:font lineBreakMode:lineBreakMode];
}

- (NSString *) moneyFormat
{
    NSRange rangeNew = [self rangeOfString:@"-"];
    NSArray  *array  = nil;
    
    if (rangeNew.location != NSNotFound) {
        NSString *price1 = [self substringToIndex:rangeNew.location];
        NSString *price2 = [self substringFromIndex:rangeNew.location];
        
        array  = [NSArray arrayWithObjects:price1,price2, nil];
    }
    else {
        array  = [NSArray arrayWithObjects:self, nil];
    }
    
    NSMutableString *result = [[[NSMutableString alloc] initWithCapacity:10] autorelease];
    [result appendString:@"￥"];
    
    for (NSUInteger i = 0, total = [array count] ; i < total  ; i++)
    {
        
        NSString *strPrice = [array objectAtIndex:i];
        
        NSString *stringLeft = nil;        
        NSRange range = [strPrice rangeOfString:@"."];
        if (range.location != NSNotFound) {
            stringLeft = [strPrice substringToIndex:range.location];
        }
        else {
            stringLeft = strPrice;
        }
        [result appendString:stringLeft];
    }
    
    return result;
}



@end
