//
//  SearchBarView.h
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchAutoFillList.h"

//#define kBarcodeSupport

#define kSearchBarcodeButtonImage   @"search_btn_barcode"
#define kSearchBarcodeButtonHLImage @"search_btn_barcode_hover"

#ifdef kBarcodeSupport

#define kSearchBarFrame         CGRectMake(0, 50, 320, 100)

#define kSearchVoiceButtonImage     @"search_btn_voice" 
#define kSearchVoiceButtonHLImage   @"search_btn_voice_hover"

#else

#define kSearchBarFrame         CGRectMake(0, 70, 320, 44)

#define kSearchVoiceButtonImage     @"search_bar_voice" 
#define kSearchVoiceButtonHLImage   nil

#endif


@interface SearchBarView : UIView

@property (nonatomic, copy)     idBlock         completeBlock;
@property (nonatomic, retain)   UITextField     *searchField;
@property (nonatomic, retain)   SearchAutoFillList *autoFillList;
@property (nonatomic, assign)   BOOL            supportHistory;
@property (nonatomic, assign)   NSInteger       searchPage;

- (void) activateSearchField:(BOOL)active;

- (void) initAutoFillList:(UIView *)parentView history:(BOOL)support backColor:(UIColor *)color;

- (void) showAutoFillList;

@end
