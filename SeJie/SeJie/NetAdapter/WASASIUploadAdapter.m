//
//  WASASIUploadAdapter.m
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "WASASIUploadAdapter.h"
#import "UIDevice+extend.h"
#import "NSString+extend.h"
#import "UserDefaultsManager.h"
#import "ModuleURLDef.h"
#import "UserDefaultsKeys.h"

@interface WASASIUploadAdapter()
@property (nonatomic, copy) NSString *linkURL;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) WASBaseAdapter *adapter;


/*!
 *	@brief	init request
 *
 *	@return	self
 */
- (id) initRequest;

/*!
 *	@brief	addrequest Headers info
 *
 *	@return	self
 */
- (id) addRequestHeaderInfo;

/*!
 *	@brief	add blocks
 *
 *	@return	self
 */
- (id) addBlocks;

/*!
 *	@brief	start net work
 *
 *	@return	self
 */
- (id) startNetWork;

/**
 *	@brief	encrept the headers
 *
 *	@param 	method 	method description
 *
 *	@return	return value MD5 result
 */
- (NSString *) requestHeaderHash:(NSString *) method;
@end

@implementation WASASIUploadAdapter
@synthesize linkURL = _linkURL;
@synthesize data    = _data;
@synthesize method  = _method;
@synthesize body    = _body;
@synthesize adapter = _adapter;

- (id) initWithURL:(NSString *)linkURL method:(NSString *)method data:(NSData *) data Body:(NSString *) body adatper:(WASBaseAdapter *)adapter
{
    self = [super init];
    if (self) {
        [self setBody:body];
        [self setMethod:method];
        [self setAdapter:adapter];
        [self setLinkURL:linkURL];
        [self setData:data];
    }
    return self;
}

- (id) initRequest
{
    self.statusCode = 0;
    NSString *stringURL     = [NSString stringWithFormat:@"%@?m=%@",self.linkURL,self.method];
    NSURL *url              = [NSURL URLWithString:stringURL];
    _request = [[ASIFormDataRequest requestWithURL:url] retain];
    _request.delegate = nil;
    _request.allowCompressedResponse = YES;
#ifdef kUseSimulateData
    _request.shouldCompressRequestBody = NO;
#endif
    
    [_request setData:self.data forKey:@"uploadimg"];
    [_request buildRequestHeaders];
    NSData *postBody = [self.body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [_request appendPostData:postBody];
    
    INFOLOG(@"\nrequest URL  = %@ \nrequest BODY = %@", stringURL,self.body);
    return self;
}

- (id) addRequestHeaderInfo
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *time   = device.t;
    NSString *chnl   = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
    if (!chnl) {
        chnl = @"";
    }
    
    static NSString *keys[] = {kDeviceIMEI,kDeviceMOB,kDeviceOS,kDeviceDEV,kDeviceVER,
        kDeviceCHNL, kDeviceTIME,kDid,kGender,kApp_key};
    NSArray *values = [NSArray arrayWithObjects:device.imei,device.mob,device.os,device.dev,device.ver,
                       chnl,time,[UserDefaultsManager deviceID],kIntToString([UserDefaultsManager userGender]),kApp_key_value,nil];
    
    for (NSUInteger i = 0, total = 11; i< total; i++) {
        [_request addRequestHeader:keys[i] value:[values objectAtIndex:i]];
    }
    
    [_request addRequestHeader:kDeviceSIGN  value:[self requestHeaderHash:self.method]];
    [_request addRequestHeader:@"Content-Type" value:@"application/json; charset = UTF-8"];
    
    return self;
}

- (id) addBlocks
{
    __block WASASIUploadAdapter *blockself = self;
    [_request setCompletionBlock:^{
        [blockself setValue:_request.responseString forKey:kKeyValueContents];
        [B5MUtility checkResultCode:_request.responseString] ? [blockself success] : ([blockself failed] ,  ERRLOG(@"FAILED MSG = %@",_request.responseString));
    }];
    
    [_request setFailedBlock:^{
        ERRLOG(@"request response status code =   %d", _request.responseStatusCode);
        blockself.statusCode = _request.responseStatusCode;
        [blockself error];
    } ];
    return self;
}

- (id) startNetWork
{
    [_request startAsynchronous];
    return self;
}

- (void) startASIService
{
    [[[self initRequest]  addBlocks] startNetWork];//addRequestHeaderInfo]
}

- (NSString *) requestHeaderHash:(NSString *) method{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_request.requestHeaders];
    [dic setObject:method  forKey:kDeviceMETHOD];
    
    NSArray *sortedArray = [[dic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSEnumerator    *enumerator = [sortedArray objectEnumerator];;
    NSMutableString *stringCode = [[[NSMutableString alloc] initWithCapacity:12] autorelease];
    id obj;
    while(obj = [enumerator nextObject])
    {
        [stringCode appendFormat:@"%@=%@&",obj, [dic valueForKey:obj]];
    }
    [stringCode appendFormat:@"%@=%@",kApp_secret, kApp_secret_value];
    return [NSString md5:stringCode];
}


- (NSString *) hash
{
    return [NSString stringWithFormat:@"%@-%@",
            kIntToString([UserDefaultsManager userGender]),
            self.body];
}

- (NSString *)contents
{
    return  [self valueForKey:@"_contents"];
}

- (void) startService
{
    [super startService];
    [_adapter startService];
    
    if ([self shouldStart]) {
        [self success];
    }else {
        [self startASIService];
    }
}

- (void) cancel
{
    [_request cancel];
}

-(BOOL) shouldStart
{
    return NO;
}

- (void) success
{
    [super success];
    [_adapter success];
}

- (void) failed
{
    [super failed];
    [_adapter failed];
}

- (void) error
{
    [super error];
    [_adapter error];
}

- (void) dealloc
{
    [_linkURL release], _linkURL = nil;
    [_method release], _method = nil;
    [_data release], _data = nil;
    [_body release], _body = nil;
    [_adapter release], _adapter = nil;
    [_request release], _request = nil;
    [super dealloc];
}
@end
