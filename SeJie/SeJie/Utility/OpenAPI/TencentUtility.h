//
//  TencentUtility.h
// sejieios
//
//  Created by Jarry on 13-2-19.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

//#import <TencentOpenAPI/TencentOAuth.h>


@interface TencentUtility : NSObject //< TencentSessionDelegate >

//@property (readonly, nonatomic)     TencentOAuth    *tencentOAuth;
@property (nonatomic, retain)       NSMutableArray  *permissions;

@property (nonatomic, copy)     idRange3Block   completeBlock;
@property (nonatomic, copy)     idBlock         cancelBlock;
@property (nonatomic, copy)     idBlock         failedBlock;

+ (TencentUtility *) instance;

- (void) doLogin:(idRange3Block)completeBlock
          cancel:(idBlock)cancelBlock
          failed:(idBlock)failedBlock;

@end
