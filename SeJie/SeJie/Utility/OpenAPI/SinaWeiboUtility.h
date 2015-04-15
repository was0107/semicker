//
//  SinaWeiboUtility.h
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SinaWeibo.h"
//#import "SinaWeiboRequest.h"

@interface SinaWeiboUtility : NSObject //< SinaWeiboDelegate, SinaWeiboRequestDelegate >

//@property (readonly, nonatomic) SinaWeibo       *sinaWeibo;
@property (nonatomic, copy)     idRange3Block   completeBlock;
@property (nonatomic, copy)     idBlock         cancelBlock;
@property (nonatomic, copy)     idBlock         failedBlock;


+ (SinaWeiboUtility *) sharedInstance;

- (void) doLogin:(idRange3Block)completeBlock
          cancel:(idBlock)cancelBlock
          failed:(idBlock)failedBlock;

- (void) shareImageWithText:(UIImage *)image
                       text:(NSString *)text
                      block:(idRange3Block)completeBlock
                     cancel:(idBlock)cancelBlock
                     failed:(idBlock)failedBlock;

- (void) shareImageWithUrl:(NSString *)url
                       text:(NSString *)text
                      block:(idRange3Block)completeBlock
                     cancel:(idBlock)cancelBlock
                     failed:(idBlock)failedBlock;

- (void) logOut;

- (BOOL) isAuthValid;

@end
