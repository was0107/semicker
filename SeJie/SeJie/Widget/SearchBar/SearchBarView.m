//
//  SearchBarView.m
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import "SearchBarView.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"
#import "VoiceRecognizeControl.h"
#import "NSObject+Block.h"
#import "AutoFillRequest.h"
#import "AutofillListData.h"
#import "SearchData.h"
#import "WASDataBase.h"

#define kVoiceButtonWidth       30.0f
#define kCancelButtonWidth      46.0f
#define kCancelButtonHeight     34.0f
#define kLeftRightSpace         8.0f
#define kSearchFieldLeft        36.0f


@interface SearchBarView () < UITextFieldDelegate, UIGestureRecognizerDelegate >

//@property (nonatomic, retain)   UIImageView     *searchBackground;
@property (nonatomic, retain)   UIView          *searchBar;
@property (nonatomic, retain)   UIButton        *voiceButton;
@property (nonatomic, retain)   UIButton        *barcodeButton;
@property (nonatomic, assign)   UIView          *parentView;
//@property (nonatomic, retain)   UIButton        *cancelButton;
@property (nonatomic, copy)     NSString        *inputText;

@end

@implementation SearchBarView

@synthesize completeBlock = _completeBlock;
//@synthesize searchBackground = _searchBackground;
@synthesize searchBar = _searchBar;
@synthesize searchField = _searchField;
@synthesize voiceButton = _voiceButton;
@synthesize parentView = _parentView;
//@synthesize cancelButton = _cancelButton;
@synthesize inputText = _inputText;
@synthesize autoFillList = _autoFillList;
@synthesize supportHistory = _supportHistory;
@synthesize searchPage = _searchPage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        _searchBar = [[UIView alloc] initWithFrame:CGRectMake(kLeftRightSpace, 4, frame.size.width-2*kLeftRightSpace, frame.size.height-8)];
        //_searchBar.backgroundColor = kRedColor;
#ifdef kBarcodeSupport
        [_searchBar addBackgroundStretchableImage:kSearchBarBarcodeBg leftCapWidth:80 topCapHeight:0];
        [_searchBar addSubview:self.barcodeButton];
#else
        [_searchBar addBackgroundStretchableImage:kSearchBarBackGround leftCapWidth:80 topCapHeight:0];
#endif
        [_searchBar addSubview:self.searchField];
        [_searchBar addSubview:self.voiceButton];
        [self addSubview:_searchBar];
        
        [self addSubview:_autoFillList];
        
//        [self addSubview:self.cancelButton];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_completeBlock);
//    TT_RELEASE_SAFELY(_searchBackground);
    TT_RELEASE_SAFELY(_searchBar);
    TT_RELEASE_SAFELY(_searchField);
    TT_RELEASE_SAFELY(_voiceButton);
    TT_RELEASE_SAFELY(_barcodeButton);
//    TT_RELEASE_SAFELY(_cancelButton);
    TT_RELEASE_SAFELY(_inputText);
    TT_RELEASE_SAFELY(_autoFillList);
    [super dealloc];
}


- (UITextField *) searchField
{
    if (!_searchField) {
        _searchField = [[UITextField alloc] initWithFrame:CGRectMake(kSearchFieldLeft, 0, _searchBar.width-kSearchFieldLeft, 36)];
        _searchField.placeholder = @"请输入内容吧";
        _searchField.borderStyle = UITextBorderStyleNone;
        _searchField.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _searchField.font = SYSTEMFONT(kSystemFontSize15);
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.backgroundColor = kClearColor;
        //_searchField.textColor = kDarkGrayColor;
        _searchField.text = @"";
        _searchField.delegate = self;
        [_searchField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchField;
}

- (UIButton *) voiceButton
{
    if (!_voiceButton) {
        _voiceButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_voiceButton setBackgroundColor:kClearColor];
        [_voiceButton setNormalImage:kSearchVoiceButtonImage hilighted:kSearchVoiceButtonHLImage selectedImage:kSearchVoiceButtonHLImage];
        [_voiceButton addTarget:self
                          action:@selector(voiceButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
        //[_voiceButton setImage:[UIImage imageNamed:kSearchVoiceButtonImage] forState:UIControlStateNormal];
#ifdef kBarcodeSupport
        [_voiceButton setFrame:CGRectMake(25, 42, 100, 40)];
#else
        [_voiceButton setFrame:CGRectMake(_searchBar.width-kVoiceButtonWidth, 3, kVoiceButtonWidth, _searchBar.height-6)];
#endif
    }
    return _voiceButton;
}

- (UIButton *) barcodeButton
{
    if (!_barcodeButton) {
        _barcodeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_barcodeButton setBackgroundColor:kClearColor];
        [_barcodeButton setNormalImage:kSearchBarcodeButtonImage hilighted:kSearchBarcodeButtonHLImage selectedImage:kSearchBarcodeButtonHLImage];
        [_barcodeButton addTarget:self
                         action:@selector(voiceButtonAction:)
               forControlEvents:UIControlEventTouchUpInside];
        [_barcodeButton setFrame:CGRectMake(180, 42, 100, 40)];
    }
    return _barcodeButton;
}

- (SearchAutoFillList *) autoFillList
{
    if (!_autoFillList) {
        _autoFillList = [[SearchAutoFillList alloc] init];
        _autoFillList.alpha = 0.0f;
        _autoFillList.backgroundColor = kClearColor;
                
        SelectBlock block = ^(NSString *keyword){
            if (keyword.length > 0) {
                
                [_searchField resignFirstResponder];
                
                NSString *text = [[keyword copy] autorelease];
                [self.searchField setText:text];

                // Search Text PV
                NSString *event = _autoFillList.isHistory ? TD_EVENT_SEARCH_RECORD_PV:[self searchEvent:_searchPage];
                [[DataTracker sharedInstance] trackEvent:event withLabel:text category:TD_EVENT_Category];

                // 保存历史
                [self saveSearchHistory:text];
                
                if (self.completeBlock) {
                    self.completeBlock(text);
                }
            }
        };
        _autoFillList.selectBlock = block;
        
        UILongPressGestureRecognizer *touchGesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(touchGestureUpdated:)] autorelease];
        touchGesture.delegate = self;
        touchGesture.cancelsTouchesInView = NO;
        touchGesture.minimumPressDuration = 0;
        [_autoFillList addGestureRecognizer:touchGesture];
    }
    return _autoFillList;
}

/*- (UIButton *) cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:kSearchBarCancelBg] forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kGrayColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = SYSTEMFONT(kFontSize14);
        [_cancelButton addTarget:self
                          action:@selector(cancelButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setFrame:CGRectMake(320, 1, kCancelButtonWidth, kCancelButtonHeight)];
        [_cancelButton setAlpha:1.0f];
    }
    return _cancelButton;
}*/

- (NSString *) searchEvent:(NSInteger)page
{
    NSString *event = TD_EVENT_SEARCH_TEXT_PV;
    switch (page) {
        case eSheJieNormal:
            event = TD_EVENT_INDEX_SEARCH_PV;
            break;
        case eSheJieExplorFirst:
        case eSheJieExplorSecond:
        case eSheJieExplorThird:
            event = TD_EVENT_EXPLORE_SEARCH_PV;
            break;
        case eSheJieSearch:
            event = TD_EVENT_SEARCH_SEARCH_TEXT_PV;
            break;
        default:
            break;
    }
    return event;
}

- (NSString *) voiceEvent:(NSInteger)page
{
    NSString *event = TD_EVENT_SEARCH_VOICE_PV;
    switch (page) {
        case eSheJieNormal:
            event = TD_EVENT_INDEX_VOICE_PV;
            break;
        case eSheJieExplorFirst:
        case eSheJieExplorSecond:
        case eSheJieExplorThird:
            event = TD_EVENT_EXPLORE_VOICE_PV;
            break;
        case eSheJieSearch:
            event = TD_EVENT_SEARCH_SEARCH_VOICE_PV;
            break;
        default:
            break;
    }
    return event;
}


#pragma mark - Actions

- (void) initAutoFillList:(UIView *)parentView history:(BOOL)support backColor:(UIColor *)color
{
    self.parentView = parentView;
    self.supportHistory = support;
    
#ifdef kBarcodeSupport
    //[[self.autoFillList setFrameWidth:parentView.width-20] setFrameX:10];
    //[_autoFillList addBackgroundStretchableImage:@"search_autofill_bg" leftCapWidth:0 topCapHeight:20];
    
    /*UIView *bgView = [[[UIView alloc] initWithFrame:CGRectMake(8, self.y+40, self.width-16, parentView.height-self.y-50)] autorelease];
    [bgView addBackgroundStretchableImage:@"search_autofill_bg" leftCapWidth:0 topCapHeight:20];
    [parentView addSubview:bgView];
    [parentView bringSubviewToFront:bgView];*/
    
    [self.autoFillList setFrame:CGRectMake(8, self.y+40, self.width-16, parentView.height-self.y-50)];
#else
    [self.autoFillList setFrame:parentView.bounds];
    [self.autoFillList setExtendHeight:self.y+self.height];
#endif
    
    [parentView addSubview:self.autoFillList];
    //[parentView bringSubviewToFront:self];

    if (color) {
        self.backgroundColor = color;
    }

}

- (void) showAutoFillList
{
    if (!self.autoFillList.superview && self.parentView) {
        [self.parentView addSubview:self.autoFillList];
    }
    
    self.autoFillList.alpha = 1.0f;
    [self.parentView bringSubviewToFront:self.autoFillList];
}

- (IBAction)voiceButtonAction:(id)sender
{
    if ([_searchField isFirstResponder]) {
        [self activateSearchField:NO];
    }
    
    if (_searchField.text.length > 0) {
        [_searchField setText:@""];
    }
    
    if (self.autoFillList.superview && !self.supportHistory) {
        [self.autoFillList removeFromSuperview];
    }
    
//    [self.superview addSubview:[VoiceRecognizeControl sharedInstance].iFlyRecognizeControl];
    [[VoiceRecognizeControl sharedInstance] startRecognize:self.superview
                                             completeBlock:^(id content)
    {
        [_searchField setText:(NSString *)content];
        
        [_searchField performBlock:^{
            // Search Voice PV
            [[DataTracker sharedInstance] trackEvent:[self voiceEvent:_searchPage]
                                           withLabel:(NSString *)content
                                            category:TD_EVENT_Category];
            // 保存历史
            [self saveSearchHistory:content];
            
            if (self.completeBlock) {
                self.completeBlock(content);
            }
        } afterDelay:0.5];
        
    } cancelBlock:^{
        
    }];
    
}

- (IBAction)cancelButtonAction:(id)sender
{
    [self activateSearchField:NO];
}

- (void) activateSearchField:(BOOL)active
{
    if (active) {
        if ([_searchField isFirstResponder]) {
            return;
        }
        
        [_searchField becomeFirstResponder];
        
    }
    else {
        
        if (self.autoFillList.superview && !self.supportHistory) {
            [self.autoFillList removeFromSuperview];
        }
        
        if (![_searchField isFirstResponder]) {
            return;
        }
        
        [_searchField resignFirstResponder];
        [_voiceButton setAlpha:1.0f];

    }
}

- (void) sendAutoFillRequest:(NSString *)keyword
{
    /*
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        if (_searchField.text.length == 0 || !self.superview) {
            return;
        }
        // AutoFill结果处理
        AutofillListData *listData = [[[AutofillListData alloc] init] autorelease];
        [listData initWithJsonString:content];
        [self showAutoFillList];
        [self.autoFillList setListData:listData.listData];
        [self.autoFillList setIsHistory:NO];
        [self.autoFillList reloadData];
    };
    
    idBlock failedBlock = ^(id content)
    {

    };
    
    AutoFillRequest *request = [[[AutoFillRequest alloc] init] autorelease];
    request.keyword = keyword;
    [WASBaseServiceFace serviceWithMethod:[URLMethod autofill]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
     */

}

- (void)saveSearchHistory:(NSString*)keyword
{
    SearchData *data = [[SearchData alloc] init];
    data.keyword = keyword;
    
    [[WASDataBase sharedDBHelpter] setTableName:NSStringFromClass([data class])];
    [[WASDataBase sharedDBHelpter] insertItem:data with:@"keyword" value:data.keyword];
    
    [data release];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        return NO;
    }
    
    [_searchField resignFirstResponder];
    
    // Search Text PV
    [[DataTracker sharedInstance] trackEvent:[self searchEvent:_searchPage]
                                   withLabel:textField.text
                                    category:TD_EVENT_Category];
    
    // 保存历史
    [self saveSearchHistory:textField.text];
    
    if (self.completeBlock) {
        self.completeBlock(textField.text);
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[self activateSearchField:YES];
    
#ifndef kBarcodeSupport
    if (textField.text.length > 0) {
        [_voiceButton setAlpha:0.0f];
    }
#endif
    //
    if (textField.text.length == 0 && self.supportHistory) {
        [self.autoFillList loadHistoryData];
    }
    
    return YES;
}

- (void)editingChanged:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    NSString *newString = [textField text];
    
    if ([self.inputText isEqualToString:newString]) {
        return;
    }
    
#ifndef kBarcodeSupport
    if (newString.length > 0) {
        [_voiceButton setAlpha:0.0f];
    }
    else {
        [_voiceButton setAlpha:1.0f];
    }
#endif
    
    if (newString.length > 0) {
        // 获取AutoFill
        [self sendAutoFillRequest:newString];
        self.inputText = newString;
    }
    else {
        self.inputText = @"";
        if (self.supportHistory) {
            [self.autoFillList loadHistoryData];
            [self showAutoFillList];
        }
        else {
            [self.autoFillList clearList];
            [self.autoFillList setAlpha:0.0f];
        }
    }
}

#pragma mark - GestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)touchGestureUpdated:(UILongPressGestureRecognizer *)touchGesture
{
    if (touchGesture.state == UIGestureRecognizerStateBegan) {
        
    }
    else if (touchGesture.state == UIGestureRecognizerStateEnded) {
        [_searchField resignFirstResponder];
        [_voiceButton setAlpha:1.0f];
    }
}

@end
