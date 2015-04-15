//
//  RecordUtility.h
// sejieios
//
//  Created by allen.wang on 1/25/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListSeiJieItem.h"

@interface RecordUtility : NSObject

+ (void) recored:(ListSeiJieItem *) item
          target:(NSString *) target
           label:(NSString *) label
          action:(NSUInteger) type;

+ (void) recordToSelfTarget:(NSString *) target
                      label:(NSString *) label
                     action:(NSUInteger) type;


+ (void) recoredToUserID:(NSString *) toUserID
              toUserName:(NSString *) toUserName
                  target:(NSString *) target
                   label:(NSString *) label
                  action:(NSUInteger) type;
@end
