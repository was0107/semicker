//
//  BaseWithRequestViewController.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "ListRequestBase.h"
#import "ListResponseBase.h"
#import "WASBaseServiceFace.h"

@interface BaseWithRequestViewController : BaseTitleViewController

@property (nonatomic, retain) ListRequestBase  *request;
@property (nonatomic, retain) ListResponseBase *response;

- (void) sendRequestToServer;

- (void) sendMessageToServer;
@end
