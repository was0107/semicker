//
//  ListImageItem.h
// sejieios
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListResponseItemBase.h"

@interface ListImageItem : ListResponseItemBase
@property (nonatomic, copy) NSString        *img;                   //": "http://img.b5m.com/image/T1i5JTBmYT1RCvBVdK/",
@property (nonatomic, copy) NSString        *soureImg;              //": "http://img.b5m.com/image/T1i5JTBmYT1RCvBVdK/",

- (id) imageName;

@end
