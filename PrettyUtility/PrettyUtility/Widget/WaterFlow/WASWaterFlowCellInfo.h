//
//  WASWaterFlowCellInfo.h
//  micker
//
//  Created by allen.wang on 8/16/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASWaterFlowCellInfo : NSObject
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) BOOL   hasCount;
@property (nonatomic, assign) CGRect frame;
@end
