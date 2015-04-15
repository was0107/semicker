//
//  ShareRecordRequest.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "ShareRecordRequest.h"
#import "UserDefaultsManager.h"

@implementation ShareRecordRequest

@synthesize touserid    = _touserid;
@synthesize tousername  = _tousername;
@synthesize target      = _target;
@synthesize label       = _label;

@synthesize docid           = _docid;
@synthesize usertype        = _usertype;
@synthesize title           = _title;
@synthesize orgincreatedate = _orgincreatedate;
@synthesize keyword         = _keyword;
@synthesize content         = _content;
@synthesize labelnames      = _labelnames;


- (void) dealloc
{
    TT_RELEASE_SAFELY(_touserid);
    TT_RELEASE_SAFELY(_tousername);
    TT_RELEASE_SAFELY(_target);
    TT_RELEASE_SAFELY(_label);
    
    
    
    TT_RELEASE_SAFELY(_docid);
    TT_RELEASE_SAFELY(_usertype);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_orgincreatedate);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_labelnames);
    
    [super dealloc];
}

- (id) init {
    self = [super init];
    if (self) {
        self.action = [NSString stringWithFormat:@"%d",eRecordActionShare];
    }
    return self;
}

- (id) initWithItem:(ListSeiJieItem *) item target:(NSString *) target label:(NSString *) label action:(NSUInteger) type
{
    self = [super init];
    if (self) {        
        self.userid     = [UserDefaultsManager userId];
        self.username   = [UserDefaultsManager userName];
        self.touserid   = item.userid;
        self.tousername = item.username;
        self.target     = target;
        self.label      = label;
        self.action     = kIntToString(type);
        
        self.docid       = item.docid;
        self.usertype    = item.userType;
        self.keyword     = item.keyword;
        self.content     = item.content;
        self.labelnames  = item.labelname;
        self.title       = item.title;
    }
    return self;
}

- (NSString *) target
{
    if (!_target) {
        return kEmptyString;
    }
    return _target;
}

- (NSString *) label
{
    if (!_label) {
        return kEmptyString;
    }
    return _label;
}

- (NSString *) docid
{
    if (!_docid) {
        return kEmptyString;
    }
    return _docid;
}

- (NSString *) usertype
{
    if (!_usertype) {
        return kEmptyString;
    }
    return _usertype;
}

- (NSString *) title
{
    if (!_title) {
        return kEmptyString;
    }
    return _title;
}

- (NSString *) keyword
{
    if (!_keyword) {
        return kEmptyString;
    }
    return _keyword;
}

- (NSString *) content
{
    if (!_content) {
        return kEmptyString;
    }
    return _content;
}

- (NSString *) labelnames
{
    if (!_labelnames) {
        return kEmptyString;
    }
    return _labelnames;
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userid",@"username",@"touserid",@"tousername",@"target",@"label",@"action",
                                            @"usertype",@"title",@"keyword",@"content",@"labelnames",@"docid",nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:[self userid],[self username],[self touserid],[self tousername],[self target],[self label],[self action],
                                            self.usertype,self.title,self.keyword,self.content,self.labelnames,self.docid,nil];
}

@end
