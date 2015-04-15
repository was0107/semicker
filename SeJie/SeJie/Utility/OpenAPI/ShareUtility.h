//
//  ShareUtility.h
// sejieios
//
//  Created by Jarry on 13-2-5.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareUtility : NSObject

@property   (nonatomic, assign)     NSInteger   shareType;


+ (ShareUtility *) instance;

- (void) initInstance;

- (BOOL) handleOpenUrl:(NSURL *)url;

- (void) shareImageWithSNS:(UIImage *)image
                       url:(NSString *)url
                      text:(NSString *)text
                     block:(idRange3Block)completeBlock
                    cancel:(idBlock)cancelBlock
                    failed:(idBlock)failedBlock;


@end
