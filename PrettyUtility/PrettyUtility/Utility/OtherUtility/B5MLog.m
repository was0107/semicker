//
//  B5MLog.m
//  PrettyUtility
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "B5MLog.h"

@implementation NSObject (INTERNAL)

+(void)B5MLog:(NSInteger)level
         file:(const char*)sourceFile
   lineNumber:(int)lineNumber
         func:(const char *)funcName
       format:(NSString*)format,...
{
#ifndef DEBUG
    return;
#endif
    
    NSInteger logLevel = level==0?LOG_LEVEL_CALLSTACK:level;
    NSString* func = [[[NSString alloc] initWithBytes:funcName length:strlen(funcName) encoding:NSUTF8StringEncoding] autorelease];
    
    
    NSString* levelDesc = @"UNDEF";
    
    switch (logLevel)
    {
        case LOG_LEVEL_CALLSTACK:
        {
            levelDesc = @"STACK";
            break;
        }
        case LOG_LEVEL_DEBUG:
        {
            levelDesc = @"DEBUG";
            break;
        }
        case LOG_LEVEL_INFO:
        {
            levelDesc = @"INFO";
            break;
        }
        case LOG_LEVEL_WARNING:
        {
            levelDesc = @"WARNING";
            break;
        }
        case LOG_LEVEL_ERROR:
        {
            levelDesc = @"ERROR";
            break;
        }
        case LOG_LEVEL_FATAL:
        {
            levelDesc = @"FATAL";
            break;
        }
        default:
            break;
    }
    
    va_list vl;
    NSString* newFormat = [NSString stringWithFormat:@"[%@] %@",levelDesc,format];
    newFormat = [newFormat stringByAppendingFormat:@"\t|| FUNC:%@ || LINE:%d ",func,lineNumber];
    va_start(vl,format);
    NSLogv(newFormat,vl);
    va_end(vl);
}

@end

