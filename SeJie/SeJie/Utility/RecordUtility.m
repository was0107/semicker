//
//  RecordUtility.m
// sejieios
//
//  Created by allen.wang on 1/25/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "RecordUtility.h"
#import "ShareRecordRequest.h"
#import "UserDefaultsManager.h"

@interface RecordUtility()
{
    dispatch_queue_t recordQueue;
}

+ (id) instance;

- (void) recored:(ListSeiJieItem *) item target:(NSString *)target label:(NSString *)label action:(NSUInteger) type;

@end

@implementation RecordUtility

- (id) init
{
    self = [super init];
    if (self) {
        recordQueue = dispatch_queue_create("RECORD", NULL);
    }
    return self;
}

+ (id) instance
{
    static dispatch_once_t  onceToken;
    static RecordUtility * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RecordUtility alloc] init];
    });
    return sharedInstance;
    
}

- (void) recored:(ListSeiJieItem *) item target:(NSString *) target label:(NSString *) label action:(NSUInteger) type
{
    dispatch_async(recordQueue, ^{
       
        idBlock successedBlock = ^(id content)
        {
            DEBUGLOG(@">>>>>>>record content = %@", content);
        };
        idBlock failedBlock = ^(id content)
        {
            ERRLOG(@">>>>>>>record error = %@", content);
        };
        ShareRecordRequest *request = [[[ShareRecordRequest alloc] initWithItem:item
                                                                         target:target
                                                                          label:label
                                                                         action:type] autorelease];
        if (request.userid.length == 0) {
            return;
        }
        
        [WASBaseServiceFace serviceWithMethod:[URLMethod record]
                                         body:[request toJsonString]
                                        onSuc:successedBlock
                                     onFailed:failedBlock
                                      onError:failedBlock];
    });
}


+ (void) recordToSelfTarget:(NSString *) target
                      label:(NSString *) label
                     action:(NSUInteger) type
{
    [self recoredToUserID:[UserDefaultsManager userId] toUserName:[UserDefaultsManager userName] target:target label:label action:type];
}

+ (void) recored:(ListSeiJieItem *) item
          target:(NSString *) target
           label:(NSString *) label
          action:(NSUInteger) type
{
    [[self instance] recored:item target:target label:label action:type];
}

+ (void) recoredToUserID:(NSString *) toUserID
              toUserName:(NSString *) toUserName
                  target:(NSString *) target
                   label:(NSString *) label
                  action:(NSUInteger) type
{
    ListSeiJieItem *item = [[[ListSeiJieItem alloc] init] autorelease];
    item.userid   = toUserID;
    item.username = toUserName;
    [self recored:item target:target label:label action:type];
}
@end
