//
//  CustomLabel.m
//  micker
//
//  Created by allen.wang on 6/5/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "CustomLabel.h"
#import<CoreText/CoreText.h>

#define kBeginPosition      5

@implementation CustomLabel
@synthesize colorArray  = _colorArray;
@synthesize customColor = _customColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc
{
    [_colorArray release], _colorArray = nil;
    [_customColor release],_customColor= nil;
    [super dealloc];
}

-(void) drawTextInRect:(CGRect)requestedRect
{
    if (!self.text) {
        return;
    }
    
    NSMutableAttributedString *string =[[[NSMutableAttributedString alloc]initWithString:self.text] autorelease];
    
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateUIFontForLanguage(kCTFontLabelFontType,self.font.pointSize,NULL);
    
    [string addAttribute:(NSString *)kCTFontAttributeName 
                   value:(id)helveticaBold 
                   range:NSMakeRange(0,[string length])];
    //设置默认字体颜色
    [string addAttribute:(NSString *)kCTForegroundColorAttributeName 
                   value:(id)([self.textColor CGColor]) 
                   range:NSMakeRange(0,[string length])];
    
    NSRange  totalRange = NSMakeRange(0, self.text.length);
    
    //设置指定字体颜色
    if (self.colorArray && self.customColor) {
        for (NSUInteger index = 0; index < [self.colorArray count]; index++) {
            
            NSDictionary *dic   = (NSDictionary *) [self.colorArray objectAtIndex:index];
            NSRange range       =  [(NSValue *) [dic objectForKey:kColorKey] rangeValue];
            if (!NSLocationInRange(NSMaxRange(range), totalRange)) {
                continue;
            }
            [string addAttribute:(NSString *)kCTForegroundColorAttributeName 
                           value:(id)([self.customColor CGColor]) 
                           range:range]; 
        }
    }
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;
    if(self.textAlignment == NSTextAlignmentCenter) {
        alignment = kCTCenterTextAlignment;
    }
    else  if(self.textAlignment == NSTextAlignmentRight) {
        alignment = kCTRightTextAlignment;
    }
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    //创建设置数组
    
    CTParagraphStyleSetting settings[ ] ={alignmentStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings));
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(id)style range:NSMakeRange(0 , [string length])];
    
    CTFramesetterRef framesetter    = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //画出文本
    CTFrameDraw(leftFrame,context);
    
    //释放
    CFRelease(leftFrame);
    CFRelease(framesetter);
    CGPathRelease(leftColumnPath);
    CFRelease(style);
    CFRelease(helveticaBold);
//    [string release];
    UIGraphicsPushContext(context);
    
}

@end
