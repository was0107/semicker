//
//  ListAddCommentRequest.m
// sejieios
//
//  Created by allen.wang on 1/23/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListAddCommentRequest.h"
#import "UserDefaultsManager.h"

@implementation ListAddCommentRequest
@synthesize userid      = _userid;
@synthesize docid       = _docid;
@synthesize comment     = _comment;

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
    TT_RELEASE_SAFELY(_comment);
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

- (id) initWithDocID:(NSString *) docID userID:(NSString *) userID comment:(NSString *) content item:(ListSeiJieItem *) item 
{
    self = [super init];
    if (self) {
        self.docid   = docID;
        self.userid  = userID;
        self.comment = content;
        
        
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
    }
    return self;
}



- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid",@"docid",@"comment",@"username",@"touserid",@"tousername",@"target",@"label",
                                            @"usertype",@"title",@"keyword",@"content",@"labelnames",nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.userid,self.docid,self.comment,self.username,self.touserid,self.tousername,self.target,self.label,
                                            self.usertype,self.title,self.keyword,self.content,self.labelnames, nil];

}

@end