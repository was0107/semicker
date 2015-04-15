//
//  B5MUtility.m
//  Allen
//
//  Created by Allen on 5/21/12.
//  Copyright (c) 2012 B5M. All rights reserved.
//
#import "B5MUtility.h"
#import "JSON.h"
//#import "UserDefaultsKeys.h"
//#import "GCDiscreetNotificationView.h"

#define kTipServerErrorString            @"服务器数据错误！"


#define kSuccessValue                  1    //1表示成功，0表示失败

#define kErrorCodeMax                  1000 //服务端定义最大错误码

static NSInteger gNetWorkStatus = 2;

#pragma mark -
#pragma mark -B5MUtility

@implementation B5MUtility

//+ (UIButton *)getLeftButtonByTitle: (NSString *)title andNavigation:(UINavigationController *)controller
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    button.frame = CGRectMake(2, 2, 48, 32);
//    
//    [button addTarget:controller
//               action:@selector(popViewControllerAnimated:) 
//     forControlEvents:UIControlEventTouchUpInside];
//    
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:kButtonDefaultImage] forState:UIControlStateNormal];
//    button.titleLabel.font = SYSTEMFONT(kFontSize14);
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    return button;
//}

+ (void) storeNetWorkStatus:(NSInteger )status
{
    gNetWorkStatus = status;
}

+ (NSInteger) netWorkStatus
{
    return gNetWorkStatus;
}

+ (BOOL) isWifi
{
    return gNetWorkStatus == kReachableViaWiFi;
}

+ (NSDictionary *) stringToDictionary:(NSString *)rspString
{
    SBJSON *json = [[SBJSON alloc]init];
    NSDictionary *deserializedData = [json fragmentWithString:rspString error:nil]; 
    [json release];
    return deserializedData;
}

+(NSString *) dictionaryToString:(NSMutableDictionary *)dict 
{
    SBJSON *json = [[SBJSON alloc]init];
    NSError *error = nil;
    NSString *stringData = [json stringWithObject:dict error:&error]; 
    [json release];
    return stringData;
}

+ (BOOL) checkResultCode:(NSString *)rspString
{  
    BOOL result = YES;
    NSDictionary *deserializedData = [self stringToDictionary:rspString];
    //[B5MUtility showAlertView:rspString];
    NSNumber *errorCode = [deserializedData objectForKey:@"err"];
    if ([errorCode integerValue] > 0 && [errorCode integerValue] < kErrorCodeMax) {
        NSString *errMsg = [deserializedData objectForKey:@"msg"];
        if (403 == [errorCode integerValue]) {
            [SVProgressHUD showErrorWithStatus:errMsg];
        }
        result = NO;
    }
    return result;
}

+ (NSString *) generateJsonWithKeys:(NSArray *) keyArray
                         withValues:(NSArray *) values 
{
    NSAssert(([keyArray count] == [values count]),@"the count of keys and values are not equal! keys = %@, values = %@",keyArray,values);
    
    NSMutableString *jsonResult = [NSMutableString string];
    for (NSUInteger i = 0, total = (int)[keyArray count]; i < total; i++) {
        [jsonResult appendFormat:@"&%@=%@", [keyArray objectAtIndex:i], [values objectAtIndex:i]];
    }
    
//    SBJSON *json = [[SBJSON alloc] init];
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjects:values
//                                                                         forKeys:keyArray];
//    
//    NSString *jsonResult = [json stringWithObject:dictionary error:nil];
//    [json release];
//    DEBUGLOG(@"json string = %@", jsonResult);
    return jsonResult;
}


+ (void ) showAlertView:(NSString *) content
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:content 
                                                       delegate:nil 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];
    
}

+ (NSString *)shortDateStringEx:(NSDate *) date 
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [format stringFromDate:date];
    [format release];
    return strDate;
}

//+ (void) showTipText:(NSString *) text activity:(BOOL) flag inView:(UIView *) view duration:(float )time
//{
//    GCDiscreetNotificationView *notificationView 
//    = [[[GCDiscreetNotificationView alloc] initWithText:text 
//                                           showActivity:flag
//                                     inPresentationMode:GCDiscreetNotificationViewPresentationModeTop
//                                                 inView:view] autorelease];
//    [notificationView show:YES];
//    [notificationView hideAnimatedAfter:time];
//}
//

+ (NSString*)version {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}


@end
