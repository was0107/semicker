//
//  ListDetailRequest.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListDetailRequest.h"

@implementation ListDetailRequest
@synthesize docid        = _docid;
@synthesize label        = _label;
@synthesize userid       = _userid;
@synthesize keyword      = _keyword;
@synthesize usertype     = _usertype;
@synthesize content      = _content;
@synthesize labelname    = _labelname;

- (id) init {
    self = [super init];
    if (self) {
        self.label      = kEmptyString;
        self.keyword    = kEmptyString;
        self.content    = kEmptyString;
        self.labelname  = kEmptyString;
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_docid);
    TT_RELEASE_SAFELY(_label);
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_usertype);
    [super dealloc];
}

- (NSString *) label
{
    if (!_label) {
        return kEmptyString;
    }
    return _label;
}

- (NSString *) labelname
{
    if (!_labelname) {
        return kEmptyString;
    }
    return _labelname;
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

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"docid",@"label",@"userid",@"usertype",@"keyword",@"content", @"labelname", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.docid, self.label,self.userid,self.usertype,self.keyword,self.content,self.labelname,nil];
}
@end
