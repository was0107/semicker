//
//  ListRequestProtocol.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListRequestProtocol <NSObject>

- (BOOL) checkArray:(NSMutableArray *) array;

- (BOOL) checkString:(NSString *) string;

- (NSMutableArray *) keyArrays;

- (NSMutableArray *) valueArrays;

- (NSString *) toJsonString;

@end
