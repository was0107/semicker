//
//  ListCommentItem.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListImageItem.h"

//3.8.	色界图片的评论接口(comment)
@interface ListCommentItem : ListImageItem
@property (nonatomic, copy)     NSString        *text;             //:
@property (nonatomic, copy)     NSString        *time;             //:
@property (nonatomic, copy)     NSString        *username;         //:

@end
