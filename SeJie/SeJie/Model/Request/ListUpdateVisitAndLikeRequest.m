//
//  ListUpdateVisitAndLikeRequest.m
// sejieios
//
//  Created by allen.wang on 1/21/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListUpdateVisitAndLikeRequest.h"
#import "UserDefaultsManager.h"

@implementation ListUpdateVisitAndLikeRequest
@synthesize userid      = _userid;
@synthesize docid       = _docid;
@synthesize type        = _type;
@synthesize username    = _username;
@synthesize touserid    = _touserid;
@synthesize tousername  = _tousername;
@synthesize target      = _target;
@synthesize label       = _label;


@synthesize usertype        = _usertype;
@synthesize title           = _title;
@synthesize orgincreatedate = _orgincreatedate;
@synthesize keyword         = _keyword;
@synthesize content         = _content;
@synthesize labelnames      = _labelnames;


- (void) dealloc
{
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_docid);
    TT_RELEASE_SAFELY(_type);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_touserid);
    TT_RELEASE_SAFELY(_tousername);
    TT_RELEASE_SAFELY(_target);
    TT_RELEASE_SAFELY(_label);
    
    TT_RELEASE_SAFELY(_usertype);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_orgincreatedate);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_labelnames);
    [super dealloc];
}

- (id) initWithDocID:(NSString *) docID userID:(NSString *) userID type:(int) type  item:(ListSeiJieItem *) item
{
    self = [super init];
    if (self) {
        self.docid       = docID;
        self.userid      = userID;

        self.touserid    = item.userid;
        self.tousername  = item.username;
        self.target      = item.img;
        self.label       = item.label;
        self.username    = [UserDefaultsManager userName];

        self.usertype    = item.userType;
        self.keyword     = item.keyword;
        self.content     = item.content;
        self.labelnames  = item.labelname;
        self.title       = item.title;
        
        if (0 == type) {
            self.type = @"VISIT";//类型(VISIT|LIKE)
        } else {
            self.type = @"LIKE";
        }
    }
    return self;
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid",@"docid",@"type",@"username",@"touserid",@"tousername",@"target",@"label",
                                            @"usertype",@"title",@"keyword",@"content",@"labelnames",nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.userid,self.docid,self.type,self.username,self.touserid,self.tousername,self.target,self.label,
                                            self.usertype,self.title,self.keyword,self.content,self.labelnames, nil];
}


@end
