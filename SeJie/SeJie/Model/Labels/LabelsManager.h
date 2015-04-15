//
//  LabelsManager.h
// sejieios
//
//  Created by Jarry on 13-1-7.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LabelItem.h"

#define kLabelPlistName         @"labels.plist"
#define kLabelJasonFileMale     @"labels_male_huaban.json"
#define kLabelJasonFileFemale   @"labels_female.json"


@interface LabelsManager : NSObject

@property (nonatomic, retain) NSMutableArray *labelListData; // 所有标签，包括二级、三级
@property (nonatomic, assign) LabelItem *currentItem;


+ (LabelsManager *) sharedInstance;

/**
 * 获取一级标签列表
 */
- (NSMutableArray *) getMainLabelList;


/**
 * 获取子标签列表
 */
- (NSMutableArray *) getSubLabelList:(NSInteger)level title:(NSString *)title;

- (void) resetData:(NSInteger)gender;
@end
