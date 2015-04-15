//
//  ListSeiJieItem.m
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListSeiJieItem.h"


@implementation ListSeiJieItemBase
@synthesize title               = _title;
@synthesize docid               = _docid;
@synthesize urlName             = _urlName;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_docid);
    TT_RELEASE_SAFELY(_urlName);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.title        = [dictionary objectForKey:@"title"];
        self.docid        = [dictionary objectForKey:@"docid"];
        self.urlName      = [dictionary objectForKey:@"urlname"];
    }
    return self;
}


- (NSString *) title
{
    if (!_title) {
        return kEmptyString;
    }
    return _title;
}

- (NSString *) subItemRequestString
{
    return [NSString stringWithFormat:@"{\"docid\":\"%@\"}",self.docid];//@"297951"] ;//
}

@end

@implementation ListSeiJieItem
@synthesize label               = _label;
@synthesize username            = _username;
@synthesize userType            = _userType;
//@synthesize userImg             = _userImg;
@synthesize type                = _type;
@synthesize likecnt             = _likecnt;
@synthesize commentcnt          = _commentcnt;
@synthesize visitcnt            = _visitcnt;
@synthesize createtime          = _createtime;
@synthesize commentIntCnt       = _commentIntCnt;
@synthesize detailResponse      = _detailResponse;
@synthesize commentResponse     = _commentResponse;
@synthesize content             = _content;
@synthesize labelname           = _labelname;
@synthesize keyword             = _keyword;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_label);
    
    TT_RELEASE_SAFELY(_username);
//    TT_RELEASE_SAFELY(_userImg);
    TT_RELEASE_SAFELY(_userType);
    TT_RELEASE_SAFELY(_type);
    TT_RELEASE_SAFELY(_likecnt);
    TT_RELEASE_SAFELY(_commentcnt);
    TT_RELEASE_SAFELY(_visitcnt);
    TT_RELEASE_SAFELY(_createtime);
    TT_RELEASE_SAFELY(_detailResponse);
    TT_RELEASE_SAFELY(_commentResponse);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_labelname);
    TT_RELEASE_SAFELY(_keyword);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSDictionary *item = [dictionary objectForKey:@"file"];
        NSString *_imgage = [item objectForKey:@"key"];
        self.img = [NSString stringWithFormat:@"%@%@_fw320",kIMGHostDomain, _imgage];//@"http://img4.imgtn.bdimg.com/it/u=2596847722,3266288728&fm=15&gp=0.jpg";//
        self.soureImg = _imgage;//@"http://img4.imgtn.bdimg.com/it/u=2596847722,3266288728&fm=15&gp=0.jpg";//
        self.pinId = [[dictionary objectForKey:@"pin_id"] stringValue];
        self.label       = kEmptyString;//[dictionary objectForKey:@"fromPageTitleEnc"];
        self.username    = kEmptyString;//[dictionary objectForKey:@"username"];
        self.type        = kEmptyString;//[dictionary objectForKey:@"type"];
        self.likecnt     = kEmptyString;//[dictionary objectForKey:@"likecnt"];
        self.commentcnt  = kEmptyString;//[dictionary objectForKey:@"commentcnt"];
        self.visitcnt    = kEmptyString;//[dictionary objectForKey:@"visitcnt"];
        self.createtime  = kEmptyString;//[dictionary objectForKey:@"createtime"];
        self.userid      = kEmptyString;//[dictionary objectForKey:@"userid"];
        self.userType    = kEmptyString;//[dictionary objectForKey:@"usertype"];
        self.content    = kEmptyString;//[dictionary objectForKey:@"content"];
        self.labelname  = kEmptyString;//[dictionary objectForKey:@"labelnames"];
        self.keyword    = @"美女";//[dictionary objectForKey:@"fromPageTitleEnc"];
        
//        "hasAspData": "0",
//        "thumbURL": "http://img5.imgtn.bdimg.com/it/u=2754789269,2478586012&fm=21&gp=0.jpg",
//        "middleURL": "http://img5.imgtn.bdimg.com/it/u=2754789269,2478586012&fm=21&gp=0.jpg",
//        "largeTnImageUrl": "http://img5.imgtn.bdimg.com/it/u=2754789269,2478586012&fm=21&gp=0.jpg",
//        "hasLarge": 0,
//        "hoverURL": "http://img5.imgtn.bdimg.com/it/u=2754789269,2478586012&fm=23&gp=0.jpg",
//        "pageNum": 60,
//        "objURL": "ippr_z2C$qAzdH3FAzdH3Fj_z&e3Bitri5p5f_z&e3Bkwt17_z&e3Bv54AzdH3Fzit1w5AzdH3FrtvAzdH3Ftpj4AzdH3Fnaw1vkju0mal9knm9bj0w8ccw8vv0v1lb18al18c_z&e3B3r2",
//        "fromURL": "ippr_z2C$qAzdH3FAzdH3Fzit1w5_z&e3Bkwt17_z&e3Bv54AzdH3Fq7jfpt5gAzdH3Fl80llcla90clcn8bll_z&e3Bip4s",
//        "fromURLHost": "http://zhidao.baidu.com",
//        "currentIndex": "28690",
//        "width": 580,
//        "height": 1029,
//        "type": "jpg",
//        "filesize": "70",
//        "bdSrcType": "0",
//        "di": "97694929530",
//        "is": "0,0",
//        "hasThumbData": "0",
//        "bdSetImgNum": 0,
//        "bdImgnewsDate": "1970-01-01 08:00",
//        "fromPageTitle": "iphone的美图软件_<strong>百度</strong>知道",
//        "fromPageTitleEnc": "iphone的美图软件_百度知道",
//        "bdSourceName": "",
//        "bdFromPageTitlePrefix": "",
//        "isAspDianjing": 0,
//        "token": "10842",
//        "imgType": "",
//        "cs": "2754789269,2478586012",
//        "os": "177238503,339026449",
//        "simid_info": {
//            "cardSeq": [],
//            "card_pres_info": []
//        },
//        "face_info": [],
//        "xiangshi_info": [],
//        "adPicId": "0",
//        "source_type": ""
        
        
        
        self.commentIntCnt = [self.commentcnt integerValue];
        
        if (!self.likecnt.length) {
            self.likecnt = kLabelPlaceHolderString;
        }
        if (!self.commentcnt.length) {
            self.commentcnt = kLabelPlaceHolderString;
        }
        
        NSRange range = [self.username rangeOfString:@"@"];
        if (range.length > 0) {
            self.username = [self.username substringToIndex:range.location];
        }

    }
    return self;
}


- (NSString *) label
{
    if (!_label) {
        return kEmptyString;
    }
    return _label;
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

- (NSString *) labelname
{
    if (!_labelname) {
        return kEmptyString;
    }
    return _labelname;
}


@end
