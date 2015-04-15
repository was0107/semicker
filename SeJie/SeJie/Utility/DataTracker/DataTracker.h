//
//  DataTracker.h
//  micker
//
//  Created by Jarry on 12-10-16.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define kUsingTalkingData
#define kUsingUMeng
#define kUsingGoogleAnalytics

#pragma mark - import header

#ifdef kUsingUMeng
// UMeng
//#import "MobClick.h"        
// Umeng Track Define
#define UMENG_APPKEY        @"50e68c4b5270153798000001"
#endif

#ifdef kUsingGoogleAnalytics
// GA
//#import "GAI.h"
// GA Track
#define GA_TRACK_APPID      @"UA-37742030-1"

#ifdef DEBUG
#define GA_DISPATCH_PERIOD  5
#else
#define GA_DISPATCH_PERIOD  30
#endif

#endif

#pragma mark - constants define

// page id
#define TD_PAGE_SEJIE_INDEX         @"精彩色界"
#define TD_PAGE_SEJIE_EXPLORE       @"发现色界"
#define TD_PAGE_SEJIE_SEARCH        @"搜色界主页"
#define TD_PAGE_SEJIE_SEARCH_INPUT  @"搜色界"
#define TD_PAGE_USERCENTER          @"我的色界"
#define TD_PAGE_USERCENTER_SHARE    @"我的分享"
#define TD_PAGE_DETAIL              @"图片详情"
#define TD_PAGE_DETAIL_COMMODITY    @"商家详情页"
#define TD_PAGE_SHARE_WEIBO         @"微博分享"
#define TD_PAGE_SHARE_PICTURE       @"照片分享"
#define TD_PAGE_LOGIN_MAIN          @"登录主页"
#define TD_PAGE_LOGIN_B5M           @"B5M登录"
#define TD_PAGE_ABOUT               @"关于"
#define TD_PAGE_FEEDBACK            @"意见反馈"
#define TD_PAGE_SEJIE_WEIBO         @"官方微博"
#define TD_PAGE_DISCLAIMER          @"免责声明"


// event id
#define TD_EVENT_Category           @"sejieapp"
// GA
#define TD_EVENT_INDEX_SEARCH_PV        @"sejie_index_search_text_pv"
#define TD_EVENT_INDEX_VOICE_PV         @"sejie_index_search_voice_pv"
#define TD_EVENT_INDEX_REFRESH_PV       @"sejie_index_refresh_pv"
#define TD_EVENT_INDEX_IMAGE_PV         @"sejie_index_image_pv"
#define TD_EVENT_INDEX_IMAGE_SAVE_PV    @"sejie_index_image_save_pv"
#define TD_EVENT_INDEX_IMAGE_LIKE_PV    @"sejie_index_image_like_pv"
#define TD_EVENT_INDEX_IMAGE_SHARE_PV   @"sejie_index_image_share_pv"
#define TD_EVENT_INDEX_IMAGE_USER_PV    @"sejie_index_image_user_pv"
#define TD_EVENT_INDEX_IMAGE_GOODS_PV   @"sejie_index_image_goods_pv"
#define TD_EVENT_INDEX_IMAGE_GOODS_MC   @"sejie_index_image_goods_mc"
#define TD_EVENT_INDEX_IMAGE_GOODS_CPS  @"sejie_index_image_goods_cps"

#define TD_EVENT_EXPLORE_SEARCH_PV      @"sejie_explore_search_text_pv"
#define TD_EVENT_EXPLORE_VOICE_PV       @"sejie_explore_search_voice_pv"
#define TD_EVENT_EXPLORE_CLASS1_PV      @"sejie_explore_class1_pv"
#define TD_EVENT_EXPLORE_CLASS2_PV      @"sejie_explore_class2_pv"
#define TD_EVENT_EXPLORE_CLASS3_PV      @"sejie_explore_class3_pv"
#define TD_EVENT_EXPLORE_REFRESH_PV     @"sejie_explore_class_refresh_pv"
#define TD_EVENT_EXPLORE_IMAGE_PV       @"sejie_explore_class_image_pv"
#define TD_EVENT_EXPLORE_IMAGE_SAVE_PV  @"sejie_explore_class_image_save_pv"
#define TD_EVENT_EXPLORE_IMAGE_LIKE_PV  @"sejie_explore_class_image_like_pv"
#define TD_EVENT_EXPLORE_IMAGE_SHARE_PV @"sejie_explore_class_image_share_pv"
#define TD_EVENT_EXPLORE_IMAGE_USER_PV  @"sejie_explore_class_image_user_pv"
#define TD_EVENT_EXPLORE_IMAGE_GOODS_PV @"sejie_explore_class_image_goods_pv"
#define TD_EVENT_EXPLORE_IMAGE_GOODS_MC @"sejie_explore_class_image_goods_mc"
#define TD_EVENT_EXPLORE_IMAGE_GOODS_CPS @"sejie_explore_class_image_goods_cps"

#define TD_EVENT_SEARCH_SEARCH_TEXT_PV  @"sejie_search_search_text_pv"
#define TD_EVENT_SEARCH_SEARCH_VOICE_PV @"sejie_search_search_voice_pv"
#define TD_EVENT_SEARCH_REFRESH_PV      @"sejie_search_refresh_pv"
#define TD_EVENT_SEARCH_IMAGE_PV        @"sejie_search_image_pv"
#define TD_EVENT_SEARCH_IMAGE_SAVE_PV   @"sejie_search_image_save_pv"
#define TD_EVENT_SEARCH_IMAGE_LIKE_PV   @"sejie_search_image_like_pv"
#define TD_EVENT_SEARCH_IMAGE_SHARE_PV  @"sejie_search_image_share_pv"
#define TD_EVENT_SEARCH_IMAGE_USER_PV   @"sejie_search_image_user_pv"
#define TD_EVENT_SEARCH_IMAGE_GOODS_PV  @"sejie_search_image_goods_pv"
#define TD_EVENT_SEARCH_IMAGE_GOODS_MC  @"sejie_search_image_goods_mc"
#define TD_EVENT_SEARCH_IMAGE_GOODS_CPS @"sejie_search_image_goods_cps"

#define TD_EVENT_SEARCH_TEXT_PV         @"sejie_search_text_pv"
#define TD_EVENT_SEARCH_VOICE_PV        @"sejie_search_voice_pv"
#define TD_EVENT_SEARCH_RECORD_PV       @"sejie_search_record_pv"
#define TD_EVENT_SEARCH_AUTOFILL_PV     @"sejie_search_autofill_pv"

#define TD_EVENT_NAVI_BUTTON_PV         @"sejie_navigation_button_pv"
#define TD_EVENT_NAVI_INDEX_PV          @"sejie_navigation_index_pv"
#define TD_EVENT_NAVI_EXPLORE_PV        @"sejie_navigation_explore_pv"
#define TD_EVENT_NAVI_CLASS1_PV         @"sejie_navigation_class1_pv"
#define TD_EVENT_NAVI_USERCENTER_PV     @"sejie_navigation_usercenter_pv"
#define TD_EVENT_NAVI_SEARCH_VOICE_PV   @"sejie_navigation_search_voice_pv"

#define TD_EVENT_USER_IMAGE_PV          @"sejie_usercenter_image_pv"
#define TD_EVENT_USER_IMAGE_SAVE_PV     @"sejie_usercenter_image_save_pv"
#define TD_EVENT_USER_IMAGE_LIKE_PV     @"sejie_usercenter_image_like_pv"
#define TD_EVENT_USER_IMAGE_SHARE_PV    @"sejie_usercenter_image_share_pv"
#define TD_EVENT_USER_IMAGE_GOODS_PV    @"sejie_usercenter_image_goods_pv"
#define TD_EVENT_USER_IMAGE_GOODS_MC    @"sejie_usercenter_image_goods_mc"
#define TD_EVENT_USER_IMAGE_GOODS_CPS   @"sejie_usercenter_image_goods_cps"
#define TD_EVENT_USER_TIME_PV           @"sejie_usercenter_time_pv"

#define TD_EVENT_USER_UPLOAD_PV         @"sejie_usercenter_upload_pv"
#define TD_EVENT_USER_UPLOAD_OK_PV      @"sejie_usercenter_upload_ok_pv"

#define TD_EVENT_404_PV                 @"sejie_404_pv"


#pragma mark - DataTracker

@interface DataTracker : NSObject

+ (DataTracker *) sharedInstance ;

/**
 * @brief 
 * 
 * @note
 */
- (void) startDataTracker ;

/**
 * @brief
 *
 * @note
 */
- (void) stopDataTracker ;


/**
 * @brief 开始跟踪用户访问页面
 *
 * @note
 */
- (void) beginTrackPage:(NSString *)page ;

/**
 * @brief 结束跟踪用户访问页面
 *
 * @note
 */
- (void) endTrackPage:(NSString *)page ;

/**
 * @brief 自定义事件跟踪统计
 *
 * @note
 */
- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category
              value:(NSInteger)value ;

- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category ;


- (void) submitTrack ;

@end
