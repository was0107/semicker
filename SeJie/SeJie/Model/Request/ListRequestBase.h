//
//  ListRequestBase.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListRequestProtocol.h"

#import "NSString+URLEncoding.h"

@interface ListRequestBase : NSObject<ListRequestProtocol>
@property (nonatomic, copy) NSString *method;
@end
