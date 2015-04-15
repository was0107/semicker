//
//  DetailTopView.m
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "DetailTopView.h"
#import "UIImageView+(ASI).h"
#import "UIImage+extend.h"
#import "UIButton+extend.h"
#import "UIView+extend.h"
#import "CreateObject.h"
#import "ListDetailItem.h"
#import "CustomAnimation.h"
#import "UIImageView+border.h"
#import "ListUpdateVisitAndLikeRequest.h"
#import "ListVisitAndLikeResponse.h"
#import "UserDefaultsManager.h"
#import "RecordUtility.h"


@implementation DetailTopView
@synthesize imageView       = _imageView;
@synthesize userHeaderView  = _userHeaderView;
@synthesize content         = _content;
@synthesize detailContent   = _detailContent;
@synthesize favourateButton = _favourateButton;
//@synthesize treadButton     = _treadButton;
@synthesize shareButton     = _shareButton;
@synthesize userLabel       = _userLabel;
@synthesize timeLabel       = _timeLabel;
@synthesize shareLabel      = _shareLabel;
@synthesize contentLabel    = _contentLabel;
//@synthesize downloadButton  = _downloadButton;
@synthesize imageURLString  = _imageURLString;
@synthesize contentView     = _contentView;
@synthesize shareBlock      = _shareBlock;
@synthesize userBlock       = _userBlock;
@synthesize adapter         = _adapter;
@synthesize enableClickUser = _enableClickUser;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        
        startY = 370.0f;
        shareHeight = 30.0f;
        
        [self addSubview:self.imageView];
        
        [self.contentView addSubview:self.userLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.shareLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.userHeaderView];
        [self.contentView addSubview:self.favourateButton];
//        [self.contentView addSubview:self.treadButton];
        [self.contentView addSubview:self.shareButton];
//        [self addSubview:self.downloadButton];
        [self addSubview:self.contentView];
        isDownloadedSucceed = NO;
        [self enableButtons:NO];
        que = dispatch_queue_create("que", NULL);
        _normalImage = [[[UIImage imageNamed:kNoPhotoImage] imageWithCornerRadius:4] retain];
        _topDefaultImage = [[[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:4] retain];

    }
    return self;
}

- (void) dealloc
{
//    [_imageView cancelDownloadImage];
//    [_userHeaderView cancelCurrentImageLoad];
    
    dispatch_release(que);
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_normalImage);
    TT_RELEASE_SAFELY(_topDefaultImage);
    TT_RELEASE_SAFELY(_userHeaderView);
    TT_RELEASE_SAFELY(_favourateButton);
//    TT_RELEASE_SAFELY(_treadButton);
    TT_RELEASE_SAFELY(_shareButton);
    TT_RELEASE_SAFELY(_userLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_shareLabel);
    TT_RELEASE_SAFELY(_contentLabel);
    TT_RELEASE_SAFELY(_contentView);
//    TT_RELEASE_SAFELY(_downloadButton);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_detailContent);
    TT_RELEASE_SAFELY(_shareBlock);
    TT_RELEASE_SAFELY(_userBlock);
    TT_RELEASE_SAFELY(block);
    [super dealloc];
}

- (void) resetData
{
//    [_imageView cancelDownloadImage];
//    [_userHeaderView cancelCurrentImageLoad];
//    startY = 370.0f;
//    shareHeight = 30.0f;
//    imageHeight = 340;
//    isDownloadedSucceed = NO;
    _imageView.image = _topDefaultImage;
    [_userHeaderView setNormalImageEx:_normalImage selectedImageEx:nil];
//    self.userLabel.text = kLabelPlaceHolderString;
//    self.timeLabel.text = kLabelPlaceHolderString;
//    self.shareLabel.text = kEmptyString;
//    self.contentLabel.text = [NSString stringWithFormat:kLabelSeeAndFavourateString, @"-",@"-"];
//    [self enableButtons:NO];
    [self computeSize];
}

- (void) setEnableClickUser:(BOOL)enableClickUser
{
    _enableClickUser = enableClickUser;
}

- (void) computeSize
{
    CGSize size = [self.shareLabel.text sizeWithFont:self.shareLabel.font constrainedToSize:CGSizeMake(310, 1000)];
    shareHeight = size.height + 2;
    [[self shareLabel] setFrameSize:size];
    [[self contentLabel] setFrameY:(_shareLabel.y + shareHeight + 1)];
//    [[self treadButton] setFrameY:(_shareLabel.y + shareHeight - 4)];
    [[self shareButton] setFrameY:(_shareLabel.y + shareHeight - 1)];
    [[self favourateButton] setFrameY:(_shareLabel.y + shareHeight - 1)];
    [self.contentView setFrameHeight:(_favourateButton.y + _favourateButton.height + 5)];
    [self setFrameHeight:[self getContentHeight]];
}

- (CGFloat) getContentHeight
{
    return [self contentView].height + [self contentView].y - 2;
}

- (void) resetFrame:(UIImage *) image
{
    image = [image imageScaledToWidth:320];
    imageHeight = image.size.height;
    [_imageView setFrameHeight:imageHeight];
    [self imageFrameChanged:YES];
    isDownloadedSucceed = YES;
}


- (void) imageFrameChanged:(BOOL) flag
{
    __block DetailTopView *blockSelf = self;
    [UIView animateWithDuration:flag ? AnimateTime.SHORT : 0
                     animations:^
     {
         [blockSelf.contentView setFrameY:imageHeight - 25];
         [blockSelf setFrameHeight:[blockSelf getContentHeight]];
     }];
    

}

- (void) setImageURLString:(NSString *)imageURLString
{
    [_imageView cancelDownloadImage];
    if (_imageURLString != imageURLString) {
        _imageURLString = imageURLString;
    }
    if (!_imageURLString) {
        return;
    }
    
    isDownloadedSucceed = NO;
    __block DetailTopView *blockSelf = self;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageURLString] placeholderImage:_topDefaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            if (!isDownloadedSucceed) {
                [blockSelf resetFrame:image];
            };
        }
    }];
}

- (void) downloadImage
{
    __block DetailTopView *blockSelf = self;
    ListDetailItem *item = (ListDetailItem *) _content;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:item.soureImg]
                  placeholderImage:(!isDownloadedSucceed) ? _topDefaultImage :_imageView.image
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            if (!isDownloadedSucceed) {
                [blockSelf resetFrame:image];
            };
        }
    }];
}

- (void) resetVist:(NSString *) visit like:(NSString *) like
{
    NSString *showString = [NSString stringWithFormat:kLabelSeeAndFavourateString, visit,like];
    
    if (visit && like) {
        
        NSRange range1 =  [showString rangeOfString:visit];
        NSRange range2 =  [showString rangeOfString:like options:NSBackwardsSearch];
        if (range1.location != NSNotFound && range2.location != NSNotFound) {
            
            self.contentLabel.colorArray = [NSMutableArray arrayWithObjects:
                                            [NSDictionary dictionaryWithObject: [NSValue valueWithRange:range1] forKey:kColorKey],
                                            [NSDictionary dictionaryWithObject: [NSValue valueWithRange:range2] forKey:kColorKey],nil];
        }
        
    }
    self.contentLabel.text = showString;
}

- (void) setContent:(id)content
{
    if (_content != content) {
        [_content release];
        _content = [content retain];
    }
    if (!_content) {
        return;
    }
    
    ListSeiJieItem *item = (ListSeiJieItem *) _content;
    self.userLabel.text = item.username;
    [_timeLabel setText:item.createtime];
    [self resetVist:item.visitcnt like:item.likecnt];
    self.shareLabel.text = item.title;
    [self computeSize];
    [self downloadImage];
    [self enableButtons:YES];
}

- (void) resetVistEx:(NSString *) visit like:(NSString *) like
{
    ListSeiJieItem *listItem = (ListSeiJieItem *) _content;
    listItem.likecnt  = ([like integerValue] > [listItem.likecnt integerValue]) ? like : listItem.likecnt;
    listItem.visitcnt = ([visit integerValue] > [listItem.visitcnt integerValue]) ? visit : listItem.visitcnt;
    ListDetailItem *item = (ListDetailItem *) _detailContent;
    if (item) {
        item.likecnt = listItem.likecnt;
        item.visitcnt = listItem.visitcnt;
    }
    [self resetVist:listItem.visitcnt like:listItem.likecnt];
}

- (void) setDetailContent:(id)detailContent
{
    if (_detailContent != detailContent) {
        [_detailContent release];
        _detailContent = [detailContent retain];
    }
    if (!_detailContent) {
        return;
    }
    
    ListDetailItem *item = (ListDetailItem *) _detailContent;
    [self resetVistEx:item.visitcnt like:item.likecnt];
    
    [_userHeaderView setImageWithURL:[NSURL URLWithString:item.userImg]
                    placeholderImage:_normalImage
                             success:^(UIImage *image)
     {
         dispatch_async(que, ^{
             
             UIImage *TMP = [image imageWithCornerRadius:4];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [_userHeaderView setNormalImageEx:TMP selectedImageEx:TMP];
             });
         });
     }
                             failure:nil];
}

- (void) sendRequestToServer:(int) type
{
    __block  DetailTopView  *blockSelf = self;
    ListSeiJieItem *listItem = (ListSeiJieItem *) _content;
    if (!listItem) {
        return;
    }

    ListUpdateVisitAndLikeRequest *request = [[[ListUpdateVisitAndLikeRequest alloc] initWithDocID:listItem.docid userID:[UserDefaultsManager userId] type:type item:listItem] autorelease] ;
//    request.touserid = listItem.userid;
//    request.tousername = listItem.username;
//    request.username  = [UserDefaultsManager userName];
//    request.target = listItem.img;
//    request.label = listItem.label;
//    
//    request.usertype = listItem.userType;
//    request.title    = listItem.title;
//    request.content  = listItem.content;
//    request.labelnames = listItem.labelname;
    request.orgincreatedate = listItem.createtime;
    
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"update visit and like || content = %@", content);
        ListVisitAndLikeResponse *response = [[[ListVisitAndLikeResponse alloc] initWithJsonString:content] autorelease];
        [blockSelf resetVistEx:response.visitcnt like:response.likecnt];
        
//        服务器端已经记录了喜欢。
//        if (1 == type) {
//            [RecordUtility recored:listItem target:listItem.soureImg label:kEmptyString action:eRecordActionLike];
//        }
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"update visit and like || error = %@", content);
    };
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod stamppic]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (void) enableButtons:(BOOL) flag
{
    self.shareButton.enabled = flag;
//    self.treadButton.enabled = flag;
    self.favourateButton.enabled = flag;
}

- (void) saveImage
{
    [[self imageView] saveCurrentImageToPhoto];
}

- (IBAction)shareAction:(id)sender
{
    ListSeiJieItem *item = (ListSeiJieItem *) _content;
    [[DataTracker sharedInstance] trackEvent:_adapter.imageSharePV
                                   withLabel:item.label
                                    category:TD_EVENT_Category];
    if (self.shareBlock) {
        self.shareBlock(self.imageView.image);
    }
}

- (UIImageView *) imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 340)];
//        _imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kPlaceHolderBGImage]];
        imageHeight = 340;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIView *) contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 315, 320, 105)];
        _contentView.backgroundColor = kClearColor;
    }
    return _contentView;
}

- (UIButton *) userHeaderView
{
    if (!_userHeaderView) {
        _userHeaderView = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 50, 50)];
        _userHeaderView.contentMode = UIViewContentModeScaleAspectFit;
        [_userHeaderView setNormalImageEx:_normalImage selectedImageEx:nil];
        [_userHeaderView addTarget:self action:@selector(userShareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userHeaderView;
}

- (IBAction)userShareAction:(id)sender
{
    if (self.userBlock) {
        self.userBlock(self.content);
    }
}

- (IBAction)actionShow:(id)sender
{
    //[_favourateButton showPopView];
    ListSeiJieItem *item = (ListSeiJieItem *) _content;
    [[DataTracker sharedInstance] trackEvent:_adapter.imageLikePV withLabel:item.label category:TD_EVENT_Category];
    
    UIImageView *popImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(_favourateButton.x+6, _favourateButton.y+5, 10, 10)] autorelease];
    popImageView.image = [UIImage imageNamed:@"detail_red_heart"];
    
    [self.contentView addSubview:popImageView];
    
    UILabel *countLabel = [[[UILabel alloc] initWithFrame:CGRectMake(86, _favourateButton.y-6, 20, 20)] autorelease];
    countLabel.backgroundColor = kClearColor;
    countLabel.text = @"+1";
    countLabel.textColor = kOrangeColor;
    countLabel.font = TNRFontSIZEBIG(kFontSize13);
    
    countLabel.layer.transform = CATransform3DMakeScale(8.0, 8.0, 1.0);
    //countLabel.alpha = 0.6f;
    [self.contentView addSubview:countLabel];
    
    [UIView animateWithDuration:1.0f animations:^
    {
        popImageView.layer.transform = CATransform3DMakeScale(8.0, 8.0, 1.0);
        popImageView.alpha = 0.6f;
        
        countLabel.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        //countLabel.alpha = 1.0f;
    }
                     completion:^(BOOL finished)
    {
        [_favourateButton setEnabled:NO];
        [popImageView removeFromSuperview];
        [countLabel removeFromSuperview];
        //
//        ListSeiJieItem *item = (ListSeiJieItem *) _content;
//        [self resetVist:item.visitcnt like:item.likecnt];
//        NSNumber *likeNum = [NSNumber numberWithInteger:item.likecnt.integerValue+1];
//        NSString *showString = [NSString stringWithFormat:kLabelSeeAndFavourateString, item.visitcnt,likeNum];
//        _contentLabel.text = showString;
    }];
    
    
    [self sendRequestToServer:1];
}

- (UIImageButton *) favourateButton
{
    if (!_favourateButton) {
        _favourateButton = [[UIImageButton buttonWithType:UIButtonTypeCustom] retain];
        _favourateButton.frame = CGRectMake(198, 55, 54, 24);
        [_favourateButton setNormalImage:@"favourate_button" selectedImage:nil];
        [_favourateButton addTarget:self action:@selector(actionShow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favourateButton;
}

//- (UIImageButton *) treadButton
//{
//    if (!_treadButton) {
//        _treadButton = [[UIImageButton buttonWithType:UIButtonTypeCustom] retain];
//        _treadButton.frame = CGRectMake(198, 55, 54, 24);
//        [_treadButton setNormalImage:@"tread_button" selectedImage:nil];
//    }
//    return _treadButton;
//}

- (UIButton *) shareButton
{
    if (!_shareButton) {
        _shareButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _shareButton.frame = CGRectMake(259, 55, 54, 24);
        [_shareButton setNormalImage:@"share_button" selectedImage:nil];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UILabel *) userLabel
{
    if(!_userLabel)
    {
        _userLabel = [[CreateObject titleLabel] retain];
        _userLabel.frame = CGRectMake(60, 30, 180, 20);
        _userLabel.font = TNRFONTSIZE(kFontSize14);
        _userLabel.textColor = kOrangeColor;
        _userLabel.text = kLabelPlaceHolderString;
        _userLabel.numberOfLines = 0;
    }
    return _userLabel;
}

- (UILabel *) timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[CreateObject titleLabel] retain];
        _timeLabel.frame = CGRectMake(245, 30, 67, 20);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = TNRFONTSIZE(kFontSize13);
        _timeLabel.textColor = kLightGrayColor;
        _timeLabel.text = kLabelPlaceHolderString;
        _timeLabel.numberOfLines = 1;
    }
    return _timeLabel;
}

- (UILabel *) shareLabel
{
    if(!_shareLabel)
    {
        _shareLabel = [[CreateObject titleLabel] retain];
        _shareLabel.frame = CGRectMake(5, 51, 310, 0);
        _shareLabel.textAlignment = NSTextAlignmentLeft;
        _shareLabel.font = TNRFONTSIZE(kFontSize13);
        _shareLabel.textColor = kLightGrayColor;
        _shareLabel.numberOfLines = 0;
        _shareLabel.text = kLabelPlaceHolderString;
        _shareLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _shareLabel;
}

- (CustomLabel *) contentLabel
{
    if (!_contentLabel) {
        NSString *showString = [NSString stringWithFormat:kLabelSeeAndFavourateString, @"-",@"-"];
        _contentLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(5,63,125,20)];
        _contentLabel.backgroundColor = kClearColor;
        _contentLabel.customColor     = kOrangeColor;
        _contentLabel.font            = TNRFONTSIZE(kFontSize13);
        _contentLabel.textColor       = kLightGrayColor;
        _contentLabel.text            = showString;
        _contentLabel.textAlignment   = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

@end