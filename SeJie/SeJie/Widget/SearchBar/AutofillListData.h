//
//  AutofillListData.h
//  micker
//
//  Created by Jarry Zhu on 12-6-1.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 
 *  Autofill list item data
 *
 **/
@interface AutofillDataItem : NSObject
{
    NSString    *_name;     // 匹配的关键字
    NSUInteger   _count;     // 相关产品数量
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger count;

@end

/**
 *  @brief 
 *  Autofill list data
 *
 **/
@interface AutofillListData : NSObject
{
    NSMutableArray  *_listData; // 关键字列表数据
}

@property (nonatomic, retain) NSMutableArray  *listData;

- (void)initWithJsonString:(NSString*)jsonString;

@end
