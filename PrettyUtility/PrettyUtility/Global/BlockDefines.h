//
//  BlockDefines.h
//  PrettyUtility
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#ifndef PrettyUtility_BlockDefines_h
#define PrettyUtility_BlockDefines_h

typedef void (^voidBlock)();
typedef void (^backBlock)();
typedef void (^idBlock)( id content);
typedef void (^idBOOLBlock)( id content, BOOL direction);
typedef void (^idRangeBlock)( id content1, id content2);
typedef void (^idRange3Block)( id content1, id content2, id content3);
typedef void (^boolBlock)(BOOL finised);
typedef void (^intBlock)(int flag);
typedef void (^refreshContent)(NSString *name);
typedef void (^intIdBlock)(int type , id content);

#endif
