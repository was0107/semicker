//
//  BaseWithRequestViewController.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "BaseWithRequestViewController.h"

@implementation BaseWithRequestViewController
@synthesize request  = _request;
@synthesize response = _response;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sendRequestToServer
{
    
}

- (void) sendMessageToServer
{
    
}


- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

@end
