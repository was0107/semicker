//
//  WeixinUtility.h
// sejieios
//
//  Created by Jarry on 13-2-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

//#import "WXApi.h"
#import "OpenAppKeyDefines.h"

@interface WeixinUtility : NSObject // < WXApiDelegate >

@property (nonatomic, copy)     idRange3Block   completeBlock;
@property (nonatomic, copy)     idBlock         cancelBlock;
@property (nonatomic, copy)     idBlock         failedBlock;


+ (WeixinUtility *) instance;

- (BOOL) handleOpenUrl:(NSURL *)url;

- (void) doAuth:(idRange3Block)completeBlock
         cancel:(idBlock)cancelBlock
         failed:(idBlock)failedBlock;

- (void) shareImageWithUrl:(NSString *)url
                      text:(NSString *)text;

- (void) shareImageContent:(UIImage *)image
                      text:(NSString *)text
                     block:(idRange3Block)completeBlock
                    cancel:(idBlock)cancelBlock
                    failed:(idBlock)failedBlock;


- (void) sendTextContent:(NSString*)nsText;

@end
