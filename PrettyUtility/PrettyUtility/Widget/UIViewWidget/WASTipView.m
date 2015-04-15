//
//  WASTipView.m
//  micker
//
//  Created by allen.wang on 9/29/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASTipView.h"
#import "CustomLabel.h"

#define kFistLabelString        @"很抱歉!"
#define kFistLabelStringEx      @"这家伙很懒，什么都没留下!"
#define kErrorString(x)         [NSString stringWithFormat:@"Server: %@",kHostDomain]
#define kSearchGoodString(x)    [NSString stringWithFormat:@"没有搜到“%@”相关美图",x]
#define kSearchTuanString(x)    [NSString stringWithFormat:@"没有搜到“%@”相关美图",x]

@interface WASTipView()
@property (nonatomic, retain) UIImageView *tipImage;
@property (nonatomic, retain) UIImageView *tipImage1;
@property (nonatomic, retain) UILabel     *labelFirst;
@property (nonatomic, retain) CustomLabel     *labelSecond;

@end

@implementation WASTipView
@synthesize type        = _type;
@synthesize title       = _title;
@synthesize tipImage    = _tipImage;
@synthesize tipImage1   = _tipImage1;
@synthesize labelFirst  = _labelFirst;
@synthesize labelSecond = _labelSecond;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        self.backgroundColor = kClearColor;
        self.type            = eWASGoodsTip;
        [self setupContentView];
    }
    return self;
}

- (void) setupContentView
{
    [self tipImage];
    [self labelFirst];
    [self labelSecond];
}

- (UIImageView *) tipImage
{
    if (!_tipImage) {
        _tipImage = [[UIImageView alloc] initWithFrame:CGRectMake(96,0,128,90)];
        _tipImage.image = [UIImage imageNamed:@"not_found"];
        _tipImage.backgroundColor = kClearColor;
        [self addSubview:_tipImage];
    }
    return _tipImage;
}

- (UIImageView *) tipImage1
{
    if (!_tipImage1) {
        _tipImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(54,0,211,63)];
        _tipImage1.image = [UIImage imageNamed:@"not_found_ex"];
        _tipImage1.backgroundColor = kClearColor;
        [self addSubview:_tipImage1];
    }
    return _tipImage1;
}

- (UILabel *) labelFirst
{
    if (!_labelFirst) {
        _labelFirst = [[UILabel alloc] initWithFrame:CGRectMake(0,85,320,20)];
        _labelFirst.backgroundColor = kClearColor;
        _labelFirst.textAlignment = NSTextAlignmentCenter;
        _labelFirst.font          = TNRFontSIZEBIG(kFontSize17);
        _labelFirst.text          = kFistLabelString;
        [self addSubview:_labelFirst];

    }
    return _labelFirst;
}


- (CustomLabel *) labelSecond
{
    if (!_labelSecond) {
        _labelSecond = [[CustomLabel alloc] initWithFrame:CGRectMake(0,110,320,90)];
        _labelSecond.backgroundColor = kClearColor;
        _labelSecond.customColor     = kRedColor;
        _labelSecond.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelSecond];

    }
    return _labelSecond;
}

- (void) didMoveToSuperview
{
    if (self.superview) {
        CGPoint point = self.superview.center;
        point.y -= 20;
        self.center = point;
    }
}

- (void) setTitle:(NSString *) newTitle
{
    if (newTitle != _title) {
        [_title release];
        _title = [newTitle copy];
        NSString *tipString = (eWASTuanTip != self.type) ? kSearchGoodString(_title) : kSearchTuanString(_title);
        NSRange range =  [tipString rangeOfString:_title];
        self.labelSecond.colorArray = [NSMutableArray arrayWithObject:[NSDictionary dictionaryWithObject:[NSValue valueWithRange:range] forKey:kColorKey]];
        self.labelSecond.text = tipString;
        self.labelFirst.text  = kFistLabelString;
        self.tipImage1.hidden = YES;
        self.labelFirst.hidden = NO;
        self.labelSecond.hidden = NO;
        self.tipImage.hidden = NO;
    }
}

- (void) showShareNoErr
{
    self.labelSecond.hidden = YES;
    self.labelFirst.hidden = YES;
    self.tipImage.hidden = YES;
    self.tipImage1.hidden = NO;
//    self.labelFirst.text = kFistLabelStringEx;
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_tipImage);
    TT_RELEASE_SAFELY(_tipImage1);
    TT_RELEASE_SAFELY(_labelFirst);
    TT_RELEASE_SAFELY(_labelSecond);
}

- (void) dealloc
{
    [self reduceMemory];
    [super dealloc];
}
@end
