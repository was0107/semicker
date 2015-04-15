//
//  GrowingTextView.h
//  PrettyUtility
//
//  Created by allen.wang on 1/22/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrowingTextViewInternal.h"


@class GrowingTextView;
@class GrowingTextViewInternal;

@protocol GrowingTextViewDelegate

@optional
- (BOOL)growingTextViewShouldBeginEditing:(GrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldEndEditing:(GrowingTextView *)growingTextView;

- (void)growingTextViewDidBeginEditing:(GrowingTextView *)growingTextView;
- (void)growingTextViewDidEndEditing:(GrowingTextView *)growingTextView;

- (BOOL)growingTextView:(GrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)growingTextViewDidChange:(GrowingTextView *)growingTextView;

- (void)growingTextView:(GrowingTextView *)growingTextView willChangeHeight:(float)height;
- (void)growingTextView:(GrowingTextView *)growingTextView didChangeHeight:(float)height;

- (void)growingTextViewDidChangeSelection:(GrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldReturn:(GrowingTextView *)growingTextView;
@end

@interface GrowingTextView : UIView <UITextViewDelegate> {
	GrowingTextViewInternal *internalTextView;
	int             minHeight;
	int             maxHeight;
	
	//class properties
	int             maxNumberOfLines;
	int             minNumberOfLines;
	
	BOOL            animateHeightChange;
	
	//uitextview properties
	NSString        *text;
	UIFont          *font;
	UIColor         *textColor;
	UITextAlignment textAlignment;
	NSRange         selectedRange;
	BOOL            editable;
	UIReturnKeyType returnKeyType;
    UIEdgeInsets    contentInset;
    UIDataDetectorTypes dataDetectorTypes;
    NSObject <GrowingTextViewDelegate> *delegate;


}

//real class properties
@property int maxNumberOfLines;
@property int minNumberOfLines;
@property BOOL animateHeightChange;
@property (retain) UITextView *internalTextView;

//uitextview properties
@property (nonatomic) UITextAlignment   textAlignment;              // default is NSTextAlignmentLeft
@property (nonatomic) NSRange           selectedRange;              // only ranges of length 0 are supported
@property (nonatomic) UIReturnKeyType   returnKeyType;
@property (assign) UIEdgeInsets         contentInset;
@property (nonatomic,assign) NSString   *text;
@property (nonatomic,assign) UIFont     *font;
@property (nonatomic,assign) UIColor    *textColor;
@property (nonatomic,getter=isEditable) BOOL editable;
@property (nonatomic) UIDataDetectorTypes dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (assign) NSObject<GrowingTextViewDelegate> *delegate;


- (BOOL)hasText;

- (void)scrollRangeToVisible:(NSRange)range;

- (BOOL)becomeFirstResponder;

- (BOOL)resignFirstResponder;

@end
