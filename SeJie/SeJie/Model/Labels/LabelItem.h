//
//  LabelItem.h
// sejieios
//
//  Created by Jarry on 13-1-7.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelItem : NSObject

@property (nonatomic, copy)     NSString    *labelName;
@property (nonatomic, copy)     NSString    *imageUrl;
@property (nonatomic, copy)     NSString    *urlName;
@property (nonatomic, copy)     NSString    *superLabel;
@property (nonatomic, assign)   NSInteger   level;      //
@property (nonatomic, assign)   BOOL        isSelected;

- (void) resetState;


@end
