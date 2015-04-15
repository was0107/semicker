//
//  ListResponseItemBase.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListResponseItemBase : NSObject

/**
 *  @brief  init from NSDictionary
 *
 *  @param [in]  N/A    dictionary
 *  @param [out] N/A
 *  @return id
 *  @note
 **/
- (id) initWithDictionary:(const NSDictionary *) dictionary;
@end
