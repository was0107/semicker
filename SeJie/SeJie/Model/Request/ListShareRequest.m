//
//  ListShareRequest.m
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListShareRequest.h"

@implementation ListShareRequest
@synthesize userID   = _userID;
@synthesize username = _username;
@synthesize comment  = _comment;
@synthesize pic      = _pic;
@synthesize userType = _userType;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userID);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_comment);
    TT_RELEASE_SAFELY(_pic);
    TT_RELEASE_SAFELY(_userType);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid", @"username", @"comment",@"pic",@"docid",@"usertype", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.userID,self.username, self.comment,self.pic,@"",self.userType,nil];
}

@end
