//
//  UserInfoItem.m
// sejieios
//
//  Created by Jarry on 13-1-18.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserInfoItem.h"
#import "UserDefaultsManager.h"

@implementation UserInfoItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_score);
    TT_RELEASE_SAFELY(_city);
    TT_RELEASE_SAFELY(_icon);
    TT_RELEASE_SAFELY(_likecnt);
    TT_RELEASE_SAFELY(_sharecnt);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.userid     = [dictionary objectForKey:@"id"];
        self.username   = [dictionary objectForKey:@"username"];
        self.name       = [dictionary objectForKey:@"name"];
        self.email      = [dictionary objectForKey:@"email"];
        self.score      = [dictionary objectForKey:@"score"];
        self.city       = [dictionary objectForKey:@"city"];
        
        self.icon       = [dictionary objectForKey:@"icon"];
        self.likecnt    = [dictionary objectForKey:@"likecnt"];
        self.sharecnt   = [dictionary objectForKey:@"sharecnt"];

        NSString *gender = [dictionary objectForKey:@"gender"];
        if (gender && gender.length > 0) {
            [UserDefaultsManager saveUserGender:[gender integerValue]];
        }
        
        if (!self.username || self.username.length == 0) {
            self.username = self.userid;
        }
    }
    return self;
}

@end
