//
//  FunctionMarcos.h
//  PrettyUtility
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#ifndef PrettyUtility_FunctionMarcos_h
#define PrettyUtility_FunctionMarcos_h

///////////////////////////////////////////////////////////////////////////////////////
//定义基本类型的静态属性
#define DEF_NORMAL_STATIC_PROPERTY(__type, __name) \
@property (nonatomic, readonly) __type  __name; \
+ (__type) __name;

//定义基本类型的静态属性
#define DEF_STRING_STATIC_PROPERTY(__type, __name) \
@property (nonatomic, readonly) __type  __name; \
+ (__type) __name;



///////////////////////////////////////////////////////////////////////////////////////
//实现基本类型的静态属性
#define IMP_NORMAL_STATIC_PROPERTY(__type, __name, __value) \
@dynamic __name; \
+ (__type) __name \
{ \
    static __type __local = 0; \
    __local = __value; \
    return __local; \
}

//实现基本类型的静态属性
#define IMP_STRING_STATIC_PROPERTY(__name, __value) \
@dynamic __name; \
+ (NSString *) __name \
{ \
    static NSString * __local = nil; \
    if ( nil == __local ) \
    { \
        __local = [[NSString stringWithFormat:@"%s", #__value] retain]; \
    } \
    return __local; \
}


///////////////////////////////////////////////////////////////////////////////////////
//浮点静态定义
#define kFloatFunctionDef(__name)        DEF_NORMAL_STATIC_PROPERTY(float, __name)
#define kFloatFunctionImp(__name ,time)  IMP_NORMAL_STATIC_PROPERTY(float, __name, time)

//字符串静态定义
#define kStringFunctionDef(__name)          DEF_STRING_STATIC_PROPERTY(NSString *,__name)
#define kStringFunctionImp(__name,__value)  IMP_STRING_STATIC_PROPERTY(__name,__value)

#endif
