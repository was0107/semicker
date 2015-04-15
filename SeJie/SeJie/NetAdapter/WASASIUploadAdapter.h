//
//  WASASIUploadAdapter.h
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "WASBaseAdapter.h"
#import "ASIFormDataRequest.h"

@interface WASASIUploadAdapter : WASBaseAdapter
{
    __block ASIFormDataRequest *_request;
}

- (id) initWithURL:(NSString *)linkURL method:(NSString *)method data:(NSData *) data Body:(NSString *) body adatper:(WASBaseAdapter *)adapter;
@end
