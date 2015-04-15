//
//  ListMyShareRequest.m
// sejieios
//
//  Created by allen.wang on 1/18/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListMyShareRequest.h"
#import "UserDefaultsManager.h"

@implementation ListAccountRequest

@synthesize userID      = _userID;
@synthesize userType    = _userType;
@synthesize searchType  = _searchType;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userID);
    TT_RELEASE_SAFELY(_userType);
    TT_RELEASE_SAFELY(_searchType);
    [super dealloc];
}

- (NSString *) searchType
{
    if (_searchType) {
        return _searchType;
    }
    return @"SHARE";
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"pageno",@"pagesize",@"userid",@"usertype",@"searchtype", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:kIntToString(self.pageno),kIntToString(self.pagesize),self.userID, self.userType,self.searchType, nil];
}

@end

@implementation ListMyShareRequest

- (NSString *) userType
{
    return @"a";
}

- (NSString *) userID
{
    return [UserDefaultsManager userId];
}

@end
