//
//  B5MLog.h
//  PrettyUtility
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

enum eLogLeverl
{
    LOG_LEVEL_UNDEF     = 0,    // undefined
    LOG_LEVEL_CALLSTACK = 1,    // call stack
    LOG_LEVEL_DEBUG     = 2,    // debug
    LOG_LEVEL_INFO      = 3,    // info
    LOG_LEVEL_WARNING   = 4,    // warning
    LOG_LEVEL_ERROR     = 5,    // error
    LOG_LEVEL_FATAL     = 6     // fatal
};


@interface NSObject (INTERNAL)

#define LOG(lv,s,...) [NSObject B5MLog:lv file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define DEBUGLOG(s,...) [NSObject B5MLog:LOG_LEVEL_DEBUG file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define INFOLOG(s,...)  [NSObject B5MLog:LOG_LEVEL_INFO file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define WARNLOG(s,...)  [NSObject B5MLog:LOG_LEVEL_WARNING file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define ERRLOG(s,...)   [NSObject B5MLog:LOG_LEVEL_ERROR file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]


#define showRect( rect ) NSLog(@"rect.origin.x = %f,rect.origin.y = %f,rect.size.width = %f,rect.size.height = %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);

#define showSize( size ) NSLog(@"size.width = %f, size.height = %f", size.width, size.height);

#define showPoint(point) NSLog(@"pt.x = %f,pt.y = %f",point.x,point.y);

/**
 * @brief format the log with Fun name and line
 *
 *
 * @param [in]  N/A    level        LOG level
 * @param [in]  N/A    sourceFile   file name
 * @param [in]  N/A    lineNumber   line number
 * @param [in]  N/A    funcName     fun name
 * @param [in]  N/A    format
 * @param [out] N/A
 * @return     void
 * @note
 */
+(void)B5MLog:(NSInteger)level
         file:(const char*)sourceFile
   lineNumber:(int)lineNumber
         func:(const char *)funcName
       format:(NSString*)format,...;
@end
