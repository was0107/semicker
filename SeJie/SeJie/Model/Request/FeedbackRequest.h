//
//  FeedbackRequest.h
// sejieios
//
//  Created by Jarry on 13-1-9.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListRequestBase.h"

@interface FeedbackRequest : ListRequestBase

/**
 * comment*(String)：用户建议
 * contact*(String):联系方式
 * source(String):来源(app,plugin,andriod)
 */
@property (nonatomic, copy)     NSString    *comment;
@property (nonatomic, copy)     NSString    *contact;
@property (nonatomic, copy)     NSString    *source;


@end
