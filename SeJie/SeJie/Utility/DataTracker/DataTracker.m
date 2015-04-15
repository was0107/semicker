//
//  DataTracker.m
//  micker
//
//  Created by Jarry on 12-10-16.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "DataTracker.h"
#import "UserDefaultsKeys.h"

@implementation DataTracker

+ (DataTracker *)sharedInstance
{
    static DataTracker *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[DataTracker alloc] init];
    }
    return sharedInstance;
}

- (void)startDataTracker
{
#ifdef kUsingUMeng
    [self umengTrack];
#endif
    
#ifdef kUsingGoogleAnalytics
    [self GATracker];
#endif
    
#ifdef kUsingTalkingData
    [self talkingDataTrack];
#endif
}

- (void)stopDataTracker
{

}


- (void)beginTrackPage:(NSString *)page
{
    if (!page || page.length == 0) {
        return;
    }
    DEBUGLOG(@"start track page : %@", page);
#ifdef kUsingTalkingData
    // TalkingData
    [TalkingData trackPageBegin:page];
#endif
    
#ifdef kUsingGoogleAnalytics
    // GA Tracker
//    if (![[[GAI sharedInstance] defaultTracker] trackView:page]) {
//        ERRLOG(@"GA trackView Error !!");
//    }
#endif
    
#ifdef kUsingUMeng
    // UMeng
//    [MobClick beginLogPageView:page];
#endif
}

- (void)endTrackPage:(NSString *)page
{
    if (!page || page.length == 0) {
        return;
    }
#ifdef kUsingTalkingData
    // TalkingData
//    [TalkingData trackPageEnd:page];
#endif
    
#ifdef kUsingUMeng
    // UMeng
//    [MobClick endLogPageView:page];
#endif
}

- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category
{
    [self trackEvent:eventId withLabel:label category:category value:1];
}

- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category
              value:(NSInteger)value
{
    if (!eventId || eventId.length == 0) {
        return;
    }
    DEBUGLOG(@"track event : %@ , label : %@ , value : %d", eventId, label, value);
#ifdef kUsingGoogleAnalytics
//    [[[GAI sharedInstance] defaultTracker] trackEventWithCategory:category
//                                                       withAction:eventId
//                                                        withLabel:label
//                                                        withValue:[NSNumber numberWithInteger:value]];
#endif
    
#ifdef kUsingUMeng
//    [MobClick event:eventId label:label];
#endif
}

- (void) submitTrack
{
#ifdef kUsingGoogleAnalytics
    // GA Tracker
//    [[GAI sharedInstance] dispatch];
#endif
}

#pragma mark - TalkingData
#ifdef kUsingTalkingData
- (void) talkingDataTrack
{
    //channel ID
    NSString *channelId = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];

    // add TalkingData
    [TalkingData setExceptionReportEnabled:NO];
    [TalkingData setLogEnabled:NO];
    [TalkingData sessionStarted:TD_AppKey withChannelId:channelId];
    // appcpa
    NSString *deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://c.appcpa.co/e?appkey=%@&deviceName=%@", APPCPA_Key, deviceName];
    [NSURLConnection connectionWithRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:nil];
}
#endif

#pragma mark - UMENG Track
#ifdef kUsingUMeng
- (void) umengTrack
{
    //channel ID
//    NSString *channelId = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
//    
//    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
//    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
//    //    [MobClick setAppVersion:@"2.0"]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
//    //
//    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:channelId];
//    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
//    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
//    
//    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
//    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
//    
//    //[MobClick updateOnlineConfig];  //在线参数配置
//    
//    //    1.6.8之前的初始化方法
//    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void) onlineConfigCallBack:(NSNotification *)note
{
    DEBUGLOG(@"online config has fininshed and note = %@", note.userInfo);
}
#endif

#pragma mark - GoogleAnalytics
- (void) GATracker
{
    // Initialize Google Analytics
//    [GAI sharedInstance].debug = NO;
//    [GAI sharedInstance].dispatchInterval = GA_DISPATCH_PERIOD;
//#ifdef DEBUG
//    [GAI sharedInstance].trackUncaughtExceptions = NO;
//#else
//    [GAI sharedInstance].trackUncaughtExceptions = YES;
//#endif
    
    //
    // channel ID
//    NSString *channelId = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
//    NSString *referrer = [NSString stringWithFormat:@"utm_campaign=%@&utm_source=%@&utm_medium=%@&utm_term=term&utm_content=content", channelId,channelId,channelId];
//    [[[GAI sharedInstance] defaultTracker] setCampaignUrl:referrer];
//    [[[GAI sharedInstance] defaultTracker] setReferrerUrl:channelId];
//
//    [[GAI sharedInstance] trackerWithTrackingId:GA_TRACK_APPID];
}


@end
