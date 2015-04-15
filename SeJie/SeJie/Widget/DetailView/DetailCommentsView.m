//
//  DetailCommentsView.m
// sejieios
//
//  Created by allen.wang on 1/22/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "DetailCommentsView.h"
#import "GrowingTextView.h"
#import "UIView+extend.h"
#import "UIButton+extend.h"

@interface DetailCommentsView()<GrowingTextViewDelegate>
@property (nonatomic, retain) GrowingTextView *textField;
@property (nonatomic, retain) UIButton *doneButton;


@end

@implementation DetailCommentsView
@synthesize textField   = _textField;
@synthesize commitBlock = _commitBlock;
@synthesize animateBlock= _animateBlock;
@synthesize doneButton  = _doneButton;
@synthesize backgroundButton = _backgroundButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillHide:)
													 name:UIKeyboardWillHideNotification
												   object:nil];
        
        
        [self setupContentView];
    }
    return self;
}

- (void) setupContentView
{
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[[UIImageView alloc] initWithImage:entryBackground] autorelease];
    entryImageView.frame = CGRectMake(5, 0, 250, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    
    
    
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:background] autorelease];
    imageView.frame = CGRectMake(0, 0, 320, self.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    // view hierachy
    [self addSubview:imageView];
    [self addSubview:self.textField];
    [self addSubview:entryImageView];
    
    [self addSubview:self.doneButton];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

}

- (GrowingTextView *) textField
{
    if (!_textField) {
        _textField = [[GrowingTextView alloc] initWithFrame:CGRectMake(5, 2, 245, 40)];
        _textField.minNumberOfLines = 1;
        _textField.maxNumberOfLines = 6;
        _textField.returnKeyType = UIReturnKeyDone; //just as an example
        _textField.font = [UIFont systemFontOfSize:15.0f];
        _textField.delegate = self;
        _textField.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    }
    return _textField;
}

- (UIButton *) doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        _doneButton.enabled = NO;
        _doneButton.frame = CGRectMake(self.frame.size.width - 66, 8, 63, 27);
        _doneButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_doneButton setNormalImage:kCommentBGImage selectedImage:nil];
        [_doneButton addTarget:self action:@selector(resignTextView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (UIButton *) backgroundButton
{
    if (!_backgroundButton) {
        _backgroundButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _backgroundButton.alpha = 0.5;
        _backgroundButton.backgroundColor = kClearColor;
        _backgroundButton.frame = self.superview.bounds;
        [_backgroundButton addTarget:self action:@selector(hideInputView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
}

- (IBAction)hideInputView:(id)sender
{
    [self.textField resignFirstResponder];
}

- (IBAction)resignTextView:(id)sender
{
    if (![self.textField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"评论内容不能为空。"];
        return;
    }
    if (self.commitBlock) {
        self.commitBlock(self.textField.text);
    }
    [self hideInputView:nil];
    self.textField.text = kEmptyString;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_textField);
    TT_RELEASE_SAFELY(_commitBlock);
    TT_RELEASE_SAFELY(_animateBlock);
    TT_RELEASE_SAFELY(_doneButton);
    TT_RELEASE_SAFELY(_backgroundButton);
    [super dealloc];
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{

	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self convertRect:keyboardBounds toView:nil];
    
	CGRect containerFrame = self.frame;
    containerFrame.origin.y = self.superview.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    
    [self.superview bringSubviewToFront:self];
    [self.superview insertSubview:self.backgroundButton belowSubview:self];
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	self.frame = containerFrame;
    if (self.animateBlock) {
        self.animateBlock([NSNumber numberWithFloat:containerFrame.origin.y], YES);
    }
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	CGRect containerFrame = self.frame;
    containerFrame.origin.y = self.superview.bounds.size.height - containerFrame.size.height;
    
    [self.backgroundButton removeFromSuperview];

	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	self.frame = containerFrame;
	if (self.animateBlock) {
        self.animateBlock([NSNumber numberWithFloat:0], NO);
    }
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(GrowingTextView *)growingTextView willChangeHeight:(float)height
{
    [self setExtendHeight:(growingTextView.height - height)];
}

- (void)growingTextViewDidChange:(GrowingTextView *)growingTextView
{
//    self.doneButton.enabled = [growingTextView hasText];
}

- (BOOL)growingTextViewShouldReturn:(GrowingTextView *)growingTextView
{
    if ([growingTextView hasText]) {
        [self resignTextView:nil];
    }
    return YES;
}


- (void) emptyContentData
{
    self.textField.text = kEmptyString;
}

@end
