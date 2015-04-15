//
//  ListModifyRequest.h
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListRequestBase.h"

@interface ListModifyRequest : ListRequestBase
@property (nonatomic, copy)     NSString        *userid;
@property (nonatomic, copy)     NSString        *icon; 
@property (nonatomic, copy)     NSString        *birthday; 
@property (nonatomic, copy)     NSString        *email; 
@property (nonatomic, copy)     NSString        *name;       
@property (nonatomic, copy)     NSString        *gender;            
@end
