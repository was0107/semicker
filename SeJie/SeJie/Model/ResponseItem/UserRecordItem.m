//
//  UserRecordItem.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserRecordItem.h"
#import "NSDate+extend.h"

@implementation UserRecordItem
@synthesize itemid          = _itemid;
@synthesize userid          = _userid;
@synthesize username        = _username;
@synthesize targetUrl       = _targetUrl;
@synthesize docid           = _docid;
@synthesize comment         = _comment;
@synthesize time            = _time;
@synthesize actionId        = _actionId;

@synthesize usertype        = _usertype;
@synthesize title           = _title;
@synthesize orgincreatedate = _orgincreatedate;
@synthesize keyword         = _keyword;
@synthesize content         = _content;
@synthesize labelnames      = _labelnames;


- (void) dealloc
{
    TT_RELEASE_SAFELY(_itemid);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_userid);
    TT_RELEASE_SAFELY(_targetUrl);
    TT_RELEASE_SAFELY(_comment);
    TT_RELEASE_SAFELY(_time);
    
    
    TT_RELEASE_SAFELY(_usertype);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_orgincreatedate);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_labelnames);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        //self.itemid     = [dictionary objectForKey:@"id"];
        self.userid     = [dictionary objectForKey:@"userid"];
        self.username   = [dictionary objectForKey:@"username"];
        self.targetUrl  = [dictionary objectForKey:@"target"];
        self.docid      = [dictionary objectForKey:@"docid"];
        
        NSString *date  = [dictionary objectForKey:@"createdate"];
        self.time = [[NSDate stringToDate:date] relativeDateString];
        
        NSString *action = [dictionary objectForKey:@"action"];
        if (action && action.length > 0) {
            self.actionId = action.integerValue;
        }
        
        self.comment    = [dictionary objectForKey:@"comment"];
        
        
        self.usertype    = [dictionary objectForKey:@"usertype"];
        self.keyword     = [dictionary objectForKey:@"keyword"];
        self.content     = [dictionary objectForKey:@"content"];
        self.labelnames  = [dictionary objectForKey:@"labelnames"];
        self.title       = [dictionary objectForKey:@"title"];
    }
    
    return self;
}

- (ListSeiJieItem *) seiJieItem
{
    ListSeiJieItem *item = [[[ListSeiJieItem alloc] init] autorelease];
    item.username   = self.username;
    item.userid     = self.userid;
    item.keyword    = self.keyword;
    item.docid      = self.docid;
    item.content    = self.content;
    item.labelname  = self.labelnames;
    item.userType   = self.usertype;
    item.img        = self.targetUrl;
    item.likecnt    = kLabelPlaceHolderString;
    item.visitcnt   = kLabelPlaceHolderString;
    item.commentcnt = kLabelPlaceHolderString;

    
//    self.label       = [dictionary objectForKey:@"label"];
//    self.username    = [dictionary objectForKey:@"username"];
//    self.type        = [dictionary objectForKey:@"type"];
//    self.likecnt     = [dictionary objectForKey:@"likecnt"];
//    self.commentcnt  = [dictionary objectForKey:@"commentcnt"];
//    self.visitcnt    = [dictionary objectForKey:@"visitcnt"];
//    self.createtime  = [dictionary objectForKey:@"createtime"];
//    self.userid      = [dictionary objectForKey:@"userid"];
//    self.userType    = [dictionary objectForKey:@"usertype"];
//    self.content    = [dictionary objectForKey:@"content"];
//    self.labelname  = [dictionary objectForKey:@"labelnames"];
//    self.keyword    = [dictionary objectForKey:@"keyword"];
//    
//    self.commentIntCnt = [self.commentcnt integerValue];
//    
//    if (!self.likecnt.length) {
//        self.likecnt = kLabelPlaceHolderString;
//    }
//    if (!self.commentcnt.length) {
//        self.commentcnt = kLabelPlaceHolderString;
//    }
//    
//    NSRange range = [self.username rangeOfString:@"@"];
//    if (range.length > 0) {
//        self.username = [self.username substringToIndex:range.location];
//    }
    
    return item;

}

- (CGFloat) imageHeight
{
    if (self.actionId == eRecordActionStart) {
        return 85.0f;
    }
//    else if (self.actionId == eRecordActionIcon) {
//        return 80.0f;
//    }
    else if (self.actionId == eRecordActionComment) {
        return 225.0f;
    }
    else {
        return 200.0f;
    }
}
    
@end
