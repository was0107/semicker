//
//  GlobalConfig.h
//  micker
//
//  Created by Jarry on 12-11-5.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#ifndef micker_GlobalConfig_h
#define micker_GlobalConfig_h


#ifndef  AUTO_SHELL_BUILD   //

/*****************************************************
 * 全局参数配置
 * 发布版本时需要配置的主要参数：
 *  1.版本号
 *  2.渠道ID
 *  3.服务器地址
 *****************************************************/

/*
 *  版本号，主要显示在关于页面
 */
#define B5M_VERSION     @"Version 1.0.4  Build 001"


/*
 *  渠道ID，用于分渠道打包 用户数据跟踪
 */
//#define TD_ChannelID    @"dev"
//#define TD_ChannelID    @"b5m"
//#define TD_ChannelID    @"91sj"
#define TD_ChannelID    @"AppStore"


/*
 *  服务器配置
 */
//#define kUseSimulateData    0     //打开表示使用测试环境

#ifdef kUseSimulateData
// 测试环境
//#define kHostDomain       @"http://172.16.4.46:8080/b5mappsejieserver/"         //victor
//#define kHostDomain       @"http://172.16.4.39:8080/b5mappsejieserver/"       //libin
//#define kHostDomain         @"http://172.16.2.22:8080/b5mappsejieserver/"     //allen.wang
#define kHostDomain         @"http://sejie.a.beta.bang5mai.com/"
#define kDetailHostDomain   @"http://a.beta.bang5mai.com/"                //116


#else
// 正式环境
#define kHostDomain         @"http://huaban.com/"
#define kIMGHostDomain      @"http://img.hb.aicdn.com/"
#define kDetailHostDomain   @"http://a.b5m.com/" 

#endif


#endif

#endif
