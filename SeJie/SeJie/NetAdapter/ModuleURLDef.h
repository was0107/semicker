//
//  ModuleURLDef.h
//  micker
//
//  Created by Allen on 5/23/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "URLRequestHeader.h"

#define KHostHeadURL                [NSString stringWithFormat:@"%@",kHostDomain]
#define kWapHostHeadURL             [NSString stringWithFormat:@"%@%@",kDetailHostDomain,@"detail.do?ver=%@&docId=%@&p=iphone"] 
#define kTuanHostWapURL             [NSString stringWithFormat:@"%@%@",kDetailHostDomain,@"detail.do?ver=%@&channel=tuan&docId=%@&p=iphone"] 


// use to compute the url 
#define kRequestURL(url)                [NSString stringWithFormat:KHostHeadURL,url]

#define kWapURL(ver,docid)              [NSString stringWithFormat:kWapHostHeadURL,ver,docid]

#define kGoodsWapURL(docid)             [NSString stringWithFormat:kWapHostHeadURL,@"2.0.0",docid]
#define kGoodsWapURLEx(ver,docid)       [NSString stringWithFormat:kWapHostHeadURL,@"2.0.0",docid]

#define kTuanWapURL(docid)              [NSString stringWithFormat:kTuanHostWapURL,@"2.0.0",docid]
#define kTuanWapURLEx(ver,docid)        [NSString stringWithFormat:kTuanHostWapURL,ver,docid]

// 分享Url
#define kShareAppURL(user)              [NSString stringWithFormat:@"http://m.b5m.com/d.do?userid=%@",user]
#define kShareProductURL(ver,docid,user) [NSString stringWithFormat:@"%@%@?userid=%@",kWapURL(ver,docid),user]
#define kShareTuanURL(ver,docid,user)   [NSString stringWithFormat:@"%@%@?userid=%@",kTuanWapURLEx(ver,docid),user]


#define kWapParameterSupplier           @"supplier"
