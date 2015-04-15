//
//  AppDelegate.m
//  comprettyios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SplashViewController.h"
#import "UserDefaultsManager.h"
#import "SinaWeiboUtility.h"
#import "ShareUtility.h"
#import "UISplashWindow.h"
#import "iRate/iRate.h"
#import "UserDefaultsManager.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [[DataTracker sharedInstance] stopDataTracker];
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
    
    // DataTracker
    [[DataTracker sharedInstance] startDataTracker];
    
    // 渠道ID读取，若不存在 保存配置到本地
    NSString *chnid = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
    if (!chnid) {
        [[NSUserDefaults standardUserDefaults] setObject:TD_ChannelID
                                                  forKey:UDK_CHANNEL_ID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 自动提示评价
    NSInteger gender = [UserDefaultsManager userGender];
    //[iRate sharedInstance].debug = YES;
    [iRate sharedInstance].applicationBundleID = @"com.b5m.sejie";
    [iRate sharedInstance].messageTitle = (gender==eGenderMale) ? kCommentStringTitleMale : kCommentStringTitleFemale;
    [iRate sharedInstance].message = (gender==eGenderMale) ? kCommentStringContentMale : kCommentStringContentFemale;
    [iRate sharedInstance].cancelButtonLabel = (gender==eGenderMale) ? kCommentStringCancelMale : kCommentStringCancelFemale;
    [iRate sharedInstance].rateButtonLabel = (gender==eGenderMale) ? kCommentStringOkMale : kCommentStringOkFemale;

    //
    [[ShareUtility instance] initInstance];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    if ([UserDefaultsManager isFirstUse]) {
        SplashViewController *splashViewController = [[[SplashViewController alloc] init] autorelease];
        self.viewController = splashViewController;
        UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
        [navigationController setNavigationBarHidden:YES];
        navigationController.navigationBar.translucent = NO;
        self.window.rootViewController = navigationController;
        splashViewController.block = ^{
            MainViewController *mainViewContr = [[[MainViewController alloc] init] autorelease];
            [navigationController pushViewController:mainViewContr animated:YES];
        };
    }
    else
    {
        self.viewController = [[[MainViewController alloc] init] autorelease];
        UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
        [navigationController setNavigationBarHidden:YES];
        navigationController.navigationBar.translucent = NO;
        self.window.rootViewController = navigationController;
    }
    
    __block AppDelegate *blockSelf = self;
    [UISplashWindow instance].block = ^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [blockSelf.window makeKeyAndVisible];
    };
    [[UISplashWindow instance] dissmiss];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[DataTracker sharedInstance] submitTrack];
    
    [self addLocalPushNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //[self removeLocalNotification];
    DEBUGLOG(@"== applicationWillEnterForeground ==");
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    [[SinaWeiboUtility sharedInstance].sinaWeibo applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //return [[SinaWeiboUtility sharedInstance].sinaWeibo handleOpenURL:url];
    return [[ShareUtility instance] handleOpenUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //return [[SinaWeiboUtility sharedInstance].sinaWeibo handleOpenURL:url];
    return [[ShareUtility instance] handleOpenUrl:url];
}

#pragma mark - Local Notification

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iWeibo" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    // 图标上的数字减1
    application.applicationIconBadgeNumber = 0;
}

- (void) addLocalPushNotification
{
    // 创建一个本地推送
    UILocalNotification *notification = [[[UILocalNotification alloc] init] autorelease];
    // 设置5天之后
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*5];
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = 0; //kCFCalendarUnitMonth;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        notification.alertBody = kLocalNotificationString;
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"UpdateNotification"forKey:@"key"];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification]; 
    }
}

- (void) removeLocalNotification
{
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification = nil;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:@"UpdateNotification"]) {
                    if (localNotification){
                        [localNotification release];
                        localNotification = nil;
                    }
                    localNotification = [noti retain];
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
        }
        
        if (localNotification) {
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
            [localNotification release];
            return;
        }
    }
}

@end
