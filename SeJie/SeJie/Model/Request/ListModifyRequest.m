//
//  ListModifyRequest.m
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListModifyRequest.h"

@implementation ListModifyRequest

@synthesize userid  = _userid;
@synthesize icon    = _icon;
@synthesize email   = _email;
@synthesize name    = _name;
@synthesize gender  = _gender;
@synthesize birthday= _birthday;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_icon);
    TT_RELEASE_SAFELY(_birthday);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_gender);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid",@"icon",@"gender",nil];//@"name",
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:[self userid],[self icon],[self gender],nil];//[self name],
}

@end
