//
//  SejieSearchResponse.h
// sejieios
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListSeiJieResponseBase.h"
#import "LabelItem.h"


@interface SejieSearchResponse : ListSeiJieResponseBase

@property (nonatomic, retain) NSMutableArray   *tagsGroup;      //标签筛选

@end




@interface SejieSearchResponseManager : NSObject
@property (nonatomic, retain) NSArray *contents;
@property (nonatomic, retain) NSMutableArray *cellsArray;
@property (nonatomic, assign) NSString *currentItem;

+ (id) instanceManger;

- (void) setTheKeyword:(NSString *) keyword;

- (void) resetContent;

- (void) resetData;

@end