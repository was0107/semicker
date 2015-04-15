//
//  UserInfoItem.h
// sejieios
//
//  Created by Jarry on 13-1-18.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ListResponseItemBase.h"

@interface UserInfoItem : ListResponseItemBase

@property (nonatomic, copy)     NSString        *userid;            
@property (nonatomic, copy)     NSString        *username;  
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, copy)     NSString        *email;
@property (nonatomic, copy)     NSString        *city;      
@property (nonatomic, copy)     NSString        *score;
@property (nonatomic, copy)     NSString        *icon;
@property (nonatomic, copy)     NSString        *likecnt;
@property (nonatomic, copy)     NSString        *sharecnt;
@property (nonatomic, assign)   NSInteger       gender;

@end
