//
//  WASDataBase.h
//  micker
//
//  Created by allen.wang on 10/10/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class FMDatabase;

@interface WASDataBase : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *tableName;

+ (WASDataBase*)sharedDBHelpter;

- (void) insertItem:(id) content with:(NSString *) key value:(NSString *) value;

- (void) deleteWith:(id) content key:(NSString *) key value:(NSString *) value;

- (void) deleteAll:(id) content;

- (BOOL) isExistKey:(NSString *) key value:(NSString *) value;

- (NSMutableArray *) getAllData;
@end
