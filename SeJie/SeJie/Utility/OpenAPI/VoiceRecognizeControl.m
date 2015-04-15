//
//  VoiceRecognizeControl.m
// sejieios
//
//  Created by Jarry on 13-1-6.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "VoiceRecognizeControl.h"
#import "OpenAppKeyDefines.h"

#define H_CONTROL_ORIGIN            CGPointMake(20, 120)
#define H_CONTROL_ORIGIN_IPHONE5    CGPointMake(20, 160)

@implementation VoiceRecognizeControl

//@synthesize iFlyRecognizeControl = _iFlyRecognizeControl;
@synthesize backView = _backView;
@synthesize cancelBlock = _cancelBlock;
@synthesize completeBlock = _completeBlock;

+ (VoiceRecognizeControl *) sharedInstance
{
    static VoiceRecognizeControl *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[VoiceRecognizeControl alloc] init];
    }
    return sharedInstance;
}


- (VoiceRecognizeControl *)init
{
    if ((self = [super init])) {
        //
        NSString *initParam = [[NSString alloc] initWithFormat:
                               @"server_url=%@,appid=%@", IFLYMSC_ENGINE_URL, IFLYMSC_APPID];
        
        // init the RecognizeControl
        // 初始化语音识别控件
//        _iFlyRecognizeControl = [[IFlyRecognizeControl alloc] initWithOrigin:(iPhone5 ? H_CONTROL_ORIGIN_IPHONE5:H_CONTROL_ORIGIN) initParam:initParam];
//        
//        // Configure the RecognizeControl
//        // 设置语音识别控件的参数,具体参数可参看开发文档
//        [_iFlyRecognizeControl setEngine:@"sms" engineParam:@"asr_ptt=0" grammarID:nil];
//        [_iFlyRecognizeControl setSampleRate:16000];
//        _iFlyRecognizeControl.delegate = self;
        
        [initParam release];
        
    }
    return self;
}

- (UIButton *) backView
{
    if (!_backView) {
        _backView = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        //_backView.frame = self.view.bounds;
        _backView.backgroundColor = kClearColor;
        [_backView addTarget:self action:@selector(bottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backView;
}

- (IBAction) bottomViewAction:(id)sender
{
//    [_iFlyRecognizeControl cancel];
}

- (void)dealloc
{
//    TT_RELEASE_SAFELY(_iFlyRecognizeControl);
    _cancelBlock = nil;
    _completeBlock = nil;
    [super dealloc];
}

- (void) startRecognize:(UIView*) parentView completeBlock:(idBlock) completeBlock cancelBlock:(voidBlock) cancelBlock
{
    [self.backView setFrame:parentView.bounds];
    [parentView addSubview:self.backView];
//    [parentView addSubview:self.iFlyRecognizeControl];
    
    [parentView bringSubviewToFront:self.backView];
//    [parentView bringSubviewToFront:self.iFlyRecognizeControl];
    
    [self startRecognize:completeBlock cancelBlock:cancelBlock];
}

- (void) startRecognize:(idBlock) completeBlock cancelBlock:(voidBlock) cancelBlock
{
    self.completeBlock = completeBlock;
    self.cancelBlock = cancelBlock;
    
//    [_iFlyRecognizeControl start];
}

- (void) bringToFront:(UIView *) parentView
{
    [parentView bringSubviewToFront:self.backView];
//    [parentView bringSubviewToFront:self.iFlyRecognizeControl];
}

- (void) cancel
{
//    if (![_iFlyRecognizeControl isHidden]) {
//        [_iFlyRecognizeControl cancel];
//    }
}

#pragma mark - IFlyRecognizeControlDelegate 接口回调

//	recognition end callback
//  识别结束回调函数，当整个会话过程结束时候会调用这个函数
//- (void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(SpeechError) error
//{
//    [self.backView removeFromSuperview];
//	//NSLog(@"识别结束回调finish.....");
//	//[self enableButton];
//	//NSLog(@"getUpflow:%d,getDownflow:%d",[iFlyRecognizeControl getUpflow],[iFlyRecognizeControl getDownflow]);
//}
//
////  recognition result callback
////  识别结果回调函数
//- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
//{
//	[self onRecognizeResult:resultArray];
//}

- (void)onRecognizeResult:(NSArray *)array
{
    //  execute the onUpdateTextView function in main thread
    //  在主线程中执行onUpdateTextView方法
	[self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:
	 [[array objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
}

//  set the textView
//  设置textview中的文字，既返回的识别结果
- (void)onUpdateTextView:(NSString *)sentence
{
	//NSString *str = [[NSString alloc] initWithFormat:@"%@%@", _textView.text, sentence];
	//_textView.text = str;
    
    if (self.completeBlock) {
        self.completeBlock(sentence);
    }
	
	DEBUGLOG(@"onRecognizeResult == %@", sentence);
}


@end
