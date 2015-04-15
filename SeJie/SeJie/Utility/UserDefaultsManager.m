//
//  UserDefaultsManager.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "UserDefaultsManager.h"
#import "OpenUDID.h"

@implementation UserDefaultsManager


+ (void)saveUserGender:(NSInteger)gender {
    
    NSNumber *number = [NSNumber numberWithInt:(0 != gender) ? 1 : 0];
    [[NSUserDefaults standardUserDefaults] setObject:number
                                              forKey:UDK_UserGender];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)userGender {
    NSNumber *gender = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserGender];
    if (!gender) {
        return 0;
    } else {
        return [gender intValue];
    }
}

+ (NSString *) userId
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserID];
    if (!userId) {
        return kEmptyString;
    }
    return userId;
}

+ (void)saveUserId:(NSString *)userId
{
    if (!userId || userId.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userId
                                              forKey:UDK_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *) userIcon
{
    NSString *userIcon = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserIcon];
    if (!userIcon) {
        return kEmptyString;
    }
    return userIcon;

}

+ (void)saveUserIcon:(NSString *)userIcon
{
    if (!userIcon || userIcon.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userIcon
                                              forKey:UDK_UserIcon];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *) userCoverIcon
{
    NSString *userCoverIcon = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserCoverIcon];
    if (!userCoverIcon) {
        return kEmptyString;
    }
    return userCoverIcon;
}

+ (void)saveUserCoverIcon:(NSString *)userCoverIcon
{
    if (!userCoverIcon || userCoverIcon.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userCoverIcon
                                              forKey:UDK_UserCoverIcon];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearUserId
{
    [[NSUserDefaults standardUserDefaults] setObject:@""
                                              forKey:UDK_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) userType
{
    NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserType];
    if (!userType) {
        return @"b";
    }
    return userType;
}

+ (void)saveUserType:(NSString *)userType
{
    if (!userType || userType.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userType
                                              forKey:UDK_UserType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) userName
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserName];
    if (!userName) {
        return kEmptyString;
    }
    return userName;
}

+ (void)saveUserName:(NSString *)userName
{
    if (!userName || userName.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userName
                                              forKey:UDK_UserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (NSUInteger) updateTimes
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UPDATE_TIMES];
    if (!dic) {
        return 1;
    }
    NSDate *date = [dic objectForKey:@"date"];
    NSUInteger time = [[dic objectForKey:@"time"] integerValue];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger units = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit);
    NSDateComponents *components = [calendar components:units fromDate:date toDate:[NSDate date] options:0];
    if ([components year] > 0 || [components month] > 0 || [components day] > 0) {
        return 1;
    }
    return time;
}

+ (void) saveUpdateTimes:(NSUInteger ) time
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate date], @"date", [NSNumber numberWithInteger:time], @"time",nil];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:UDK_UPDATE_TIMES];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(BOOL) isFirstUse
{
    NSNumber *gender = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserGender];
    return !gender ? YES : NO;
}

+ (void) saveDeviceID:(NSString *)did
{
    [[NSUserDefaults standardUserDefaults] setObject:did
                                              forKey:UDK_DeviceID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) deviceID
{
    NSString *did = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_DeviceID];
    if (!did) {
        DEBUGLOG(@"did = %@", [OpenUDID value]);
        did = [OpenUDID value];
        [self saveDeviceID:did];
        return did;
    }
    return did;
}


+ (NSString*)shortDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return currentDateStr;
}


+ (void) SavePushID:(NSString *)pushID
{
    [[NSUserDefaults standardUserDefaults] setObject:pushID
                                              forKey:UDK_PushID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) pushID
{
    NSString *pushID = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_PushID];
    if (!pushID) {
        return kEmptyString;
    }
    return pushID;
}

+ (NSInteger) pushIDChanged {
    NSNumber *netFlag = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_PushID_Change];
    if (!netFlag) {
        return 1;
    } else {
        return [netFlag intValue];
    }
}

+ (NSString *) theLastChangedCity
{
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_LastCityName];
    if (!city || city.length == 0) {
        return kEmptyString;
    }
    return city;
}


+ (void)savePushIDChange:(NSInteger)change {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:change]
                                              forKey:UDK_PushID_Change];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)netTrafficMode {
    NSNumber *netFlag = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_Net_SaveTraffic];
    if (!netFlag) {
        return 0;
    } else {
        return [netFlag intValue];
    }
}

+ (void)saveNetTrafficMode:(NSInteger)flag {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:flag]
                                              forKey:UDK_Net_SaveTraffic];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void) storeNetWorkChangedTipStatus:(NSUInteger)status
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedInteger:status]
                                              forKey:UDK_Network_Tip];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger) netWorkChangedTipStatus
{
    NSNumber *netFlag = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_Network_Tip];
    if (!netFlag) {
        return 1;
    } else {
        return [netFlag unsignedIntValue];
    }
}

@end
