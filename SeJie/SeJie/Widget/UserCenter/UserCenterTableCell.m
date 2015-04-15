//
//  UserCenterTableCell.m
// sejieios
//
//  Created by Jarry on 13-1-24.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCenterTableCell.h"
#import "UIView+extend.h"
#import "UserDefaultsManager.h"
#import "UIImageView+WebCache.h"
#import "UIImage+extend.h"


#define     kUserRecordStartString      @"%@：开启了色界，我的世界"
#define     kUserRecordLikeString       @"%@：喜欢了1张图片"
#define     kUserRecordShareString      @"%@：分享了1张图片"
#define     kUserRecordCommentString    @"%@：评论了1张图片"
#define     kUserRecordUploadString     @"%@：上传照片"
#define     kUserRecordPhotoString      @"%@：更换了头像"
#define     kUserRecordCoverString      @"%@：更换了封面"


@implementation UserCenterEmptyCell

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIImage imageNamed:kShareNoContentBGImage] drawInRect:CGRectMake(40, 25, 240, 70)];
}

@end

@implementation UserCenterTableCell

@synthesize timeLabel   = _timeLabel;
@synthesize actionLabel = _actionLabel;
@synthesize actionImageView   = _actionImageView;
@synthesize actionView  = _actionView;
@synthesize commentLabel = _commentLabel;
@synthesize recordItem  = _recordItem;
@synthesize photoImage  = _photoImage;
@synthesize block       = _block;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = kClearColor;
                
        UIView *timeView = [[[UIView alloc] initWithFrame:CGRectMake(10, 6, 48, 18)] autorelease];
        [timeView addBackgroundStretchableImage:@"user_time_bg" leftCapWidth:15 topCapHeight:0];
        [timeView addSubview:self.timeLabel];
        [self addSubview:timeView];
        
//        UIImageView *circleImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_cell_circle"]] autorelease];
//        circleImage.frame = CGRectMake(62, 10, 10, 10);
//        [self addSubview:circleImage];
        
        [self addSubview:self.actionLabel];
        [self addSubview:self.actionView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_actionLabel);
    TT_RELEASE_SAFELY(_actionImageView);
    TT_RELEASE_SAFELY(_actionView);
    TT_RELEASE_SAFELY(_commentLabel);
    TT_RELEASE_SAFELY(_photoImage);
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIImage imageNamed:@"user_line_bg"] drawInRect:CGRectMake(66, 0, 2, self.height)];
    [[UIImage imageNamed:@"user_cell_circle"] drawInRect:CGRectMake(62, 10, 10, 10)];
    
    if (self.recordItem.actionId == eRecordActionStart) {
        [[UIImage imageNamed:kShareBottomBGImage] drawInRect:CGRectMake(37, 118, 60, 12)];
    }

}

- (UILabel *) timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 18)];
        _timeLabel.backgroundColor = kClearColor;
        _timeLabel.text = @"30分钟前";
        _timeLabel.textColor = kGrayColor;
        _timeLabel.font = TNRFONTSIZE(kFontSize10);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UILabel *) actionLabel
{
    if (!_actionLabel) {
        _actionLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(80, 8, 220, 18)];
        _actionLabel.backgroundColor = kClearColor;
        _actionLabel.text = @"我：开启了色界，我的世界";
        _actionLabel.textColor = kBlackColor;
        _actionLabel.customColor = kGrayColor;
        _actionLabel.font = TNRFontSIZEBIG(kFontSize14);
        //_actionLabel.textAlignment = NSTextAlignmentCenter;
        
        _actionLabel.colorArray = [NSMutableArray arrayWithObjects:
                                   [NSDictionary dictionaryWithObject:[NSValue valueWithRange:NSMakeRange(0, 2)] forKey:kColorKey],nil];
    }
    return _actionLabel;
}

- (UIImageView *) actionImageView
{
    if (!_actionImageView) {
        _actionImageView = [[UIImageView alloc] init];
        _actionImageView.contentMode = UIViewContentModeScaleAspectFit;
        _actionImageView.userInteractionEnabled = YES;
        
        [[_actionImageView setFrameX:0.5f] setFrameY:0.5f];
                
        UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionImageView:)] autorelease];
        [_actionImageView addGestureRecognizer:gesture];
    }
    return _actionImageView;
}

- (UIImageView *) photoImage
{
    if (!_photoImage) {
        _photoImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:40]];
        _photoImage.backgroundColor = kWhiteColor;
        _photoImage.frame = CGRectMake(110, 60, 80, 80);
        _photoImage.layer.cornerRadius = 40.0f;
        _photoImage.layer.borderColor = [kWhiteColor CGColor];
        _photoImage.layer.borderWidth = 2.0f;
        _photoImage.layer.masksToBounds = YES;
        _photoImage.userInteractionEnabled = YES;
        _photoImage.hidden = YES;
    }
    return _photoImage;
}

- (UIView *) actionView
{
    if (!_actionView) {
        _actionView = [[UIView alloc] init];
        [[_actionView setFrameX:80] setFrameY:35];
        
        _actionView.hidden = YES;
        
        [_actionView addSubview:self.actionImageView];
        [_actionView addSubview:self.photoImage];
        [_actionView addSubview:self.commentLabel];
    }
    return _actionView;
}

- (CustomLabel *) commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[CustomLabel alloc] init];
        _commentLabel.backgroundColor = kClearColor;
        _commentLabel.text = @"";
        _commentLabel.textColor = kDarkGrayColor;
        _commentLabel.font = TNRFONTSIZE(kFontSize13);
        _commentLabel.hidden = YES;
        
        _actionLabel.customColor = kGrayColor;
        _actionLabel.colorArray = [NSMutableArray arrayWithObjects:
                                   [NSDictionary dictionaryWithObject:[NSValue valueWithRange:NSMakeRange(0, 2)] forKey:kColorKey],nil];
    }
    return _commentLabel;
}

- (void) updateCellData:(UserRecordItem *)item
{
    _actionImageView.image = nil;
    
    if (!item) {
        return;
    }
    
    self.recordItem = item;
    //
    [self.actionLabel setText:[self getActionString:item]];
    //
    [self.timeLabel setText:item.time];
    //
    if (item.targetUrl && item.targetUrl.length > 0) {
        _actionView.hidden = NO;
        _actionView.backgroundColor = kWhiteColor;
        _actionView.layer.borderWidth = 1.5f;
        _actionView.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        CGFloat width = 300; //[item imageHeight];
        CGFloat height = [item imageHeight];
        if (item.actionId == eRecordActionComment) {
            height = [item imageHeight] - 25;
            [_commentLabel setFrame:CGRectMake(5, height+5, width-10, 20)];
            [_commentLabel setText:[NSString stringWithFormat:@"我：%@", item.comment]];
            _commentLabel.hidden = NO;
        }
        else {
            _commentLabel.hidden = YES;
        }
        
        CGSize size = CGSizeMake(width-0.5f, height-0.5f);
        [_actionImageView setFrameSize:size];
        [[_actionView setFrameX:10] setFrameSize:CGSizeMake(width, [item imageHeight])];
        
        if (item.actionId != eRecordActionIcon) {
            _photoImage.hidden = YES;
            [_photoImage sd_setImageWithURL:[NSURL URLWithString:item.targetUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    _actionImageView.image = [image imageScaledToSizeEx:size];
                }
            }];
            
        }
        else {
            _photoImage.hidden = NO;
            
            [_photoImage sd_setImageWithURL:[NSURL URLWithString:item.targetUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    _photoImage.image = image;// [image imageWithCornerRadius:40];
                    
                    [_actionImageView sd_setImageWithURL:[NSURL URLWithString:[UserDefaultsManager userCoverIcon]]
                                        placeholderImage:nil
                                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (!error) {
                            _actionImageView.image = [image imageScaledToSizeEx:size];
                        }
                    }];
                }
            }];
        }
    }
    else if (item.actionId == eRecordActionStart) {
        _commentLabel.hidden = YES;
        _photoImage.hidden = YES;
        _actionView.hidden = NO;
        _actionView.backgroundColor = kClearColor;
        _actionView.layer.borderWidth = 0.0f;
        _actionImageView.image = [UIImage imageNamed:@"user_start"];
        [_actionImageView setFrameSize:_actionImageView.image.size];
        [_actionView setFrameX:80];
    }
}

- (NSString *) getActionString:(UserRecordItem *)item
{
    NSString *userID = [UserDefaultsManager userId];
    NSString *userName = [item.userid isEqualToString:userID] ? @"我" : item.username;
    
    switch (item.actionId) {
            
        case eRecordActionStart:
            
            return [NSString stringWithFormat:kUserRecordStartString, userName];
            
        case eRecordActionLike:
            
            return [NSString stringWithFormat:kUserRecordLikeString, userName];
            
        case eRecordActionShare:
            
            return [NSString stringWithFormat:kUserRecordShareString, userName];
            
        case eRecordActionUpload:
            
            return [NSString stringWithFormat:kUserRecordUploadString, userName];
            
        case eRecordActionComment:
            
            return [NSString stringWithFormat:kUserRecordCommentString, userName];
            
        case eRecordActionIcon:
            
            return [NSString stringWithFormat:kUserRecordPhotoString, userName];
            
        case eRecordActionCover:
            
            return [NSString stringWithFormat:kUserRecordCoverString, userName];
            
        default:
            break;
    }
    
    return @"";
}


- (void) actionImageView:(UITapGestureRecognizer *) gesutre
{
    if (self.recordItem
        && (self.recordItem.actionId==eRecordActionLike || self.recordItem.actionId==eRecordActionShare
            || self.recordItem.actionId==eRecordActionComment)
        && self.block) {
        self.block(self.recordItem);
    }
}


@end
