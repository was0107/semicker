//
//  FrontCoverImages.m
// sejieios
//
//  Created by allen.wang on 1/25/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "FrontCoverImages.h"
#import "UserDefaultsManager.h"
#import "RecordUtility.h"

@implementation FrontCoverImages

+(id) instance
{
    static dispatch_once_t  onceToken;
    static FrontCoverImages * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FrontCoverImages alloc] init];
    });
    return sharedInstance;

    return self;
}

- (NSMutableArray *) AllImages
{
    static NSMutableArray *contents = nil;
    if (!contents) {
        contents = [[NSMutableArray arrayWithObjects:
                    @"http://cdn.b5m.com/upload/sejie/frontcover/01.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/02.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/03.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/04.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/05.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/06.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/07.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/08.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/09.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/10.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/11.jpg",
                    @"http://cdn.b5m.com/upload/sejie/frontcover/12.jpg",nil] retain];
    }
    return contents;
}

- (NSUInteger ) indexURL
{
    NSString *string = [UserDefaultsManager userCoverIcon];
    if ([string length] > 0) {
        return [[self AllImages] indexOfObject:string];
    }
    return 0;
}

- (NSString *) stringURL
{
    NSString *string = [UserDefaultsManager userCoverIcon];
    if ([string length] > 0) {
        return string;
    }
    [UserDefaultsManager saveUserCoverIcon:string];
    return [[self AllImages] objectAtIndex:0];
}

- (void) saveURL:(NSString *) imageURL
{
     NSString *string = [UserDefaultsManager userCoverIcon];
    if (![string isEqualToString:imageURL]) {
        
        [RecordUtility recordToSelfTarget:imageURL label:kEmptyString action:eRecordActionCover];
        
        [UserDefaultsManager saveUserCoverIcon:imageURL];
        [[NSNotificationCenter defaultCenter] postNotificationName:kFontCoverImageDidChangedNotification object:nil];
    }
}

- (void) saveIndex:(NSUInteger )index
{
    [self saveURL: [[self AllImages] objectAtIndex:index]];
}
@end
