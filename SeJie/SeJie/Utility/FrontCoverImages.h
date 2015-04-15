//
//  FrontCoverImages.h
// sejieios
//
//  Created by allen.wang on 1/25/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFontCoverImageDidChangedNotification   @"kFontCoverImageDidChangedNotification"

@interface FrontCoverImages : NSObject

+(id) instance;

- (NSMutableArray *) AllImages;

- (NSUInteger ) indexURL;

- (NSString *) stringURL;

- (void) saveURL:(NSString *) imageURL;

- (void) saveIndex:(NSUInteger )index;
@end
