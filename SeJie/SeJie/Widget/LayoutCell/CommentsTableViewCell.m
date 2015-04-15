//
//  CommentsTableViewCell.m
// sejieios
//
//  Created by allen.wang on 1/7/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "CommentsTableViewCell.h"
#import "CreateObject.h"
#import "UIImageView+border.h"

@implementation CommentsTableViewEmptyCell

- (void) setupContentView
{
    self.textLabel.text = @"亲，暂无评论哟";
    self.textLabel.font = TNRFONTSIZE(kFontSize14);
    self.textLabel.textColor = kLightGrayColor;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(8.0f, 5.0f, 100.0f, 25.0f);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGRect bottomRect = CGRectMake(0, rect.size.height - 1, 320, 1);
    [[UIImage imageNamed:@"guang_cell_bottom"] drawAsPatternInRect:bottomRect];
}

@end


@implementation CommentsTableViewCell

@synthesize titleLabel      = _titleLabel;
@synthesize contentLabel    = _contentLabel;
@synthesize timeLabel       = _timeLabel;
@synthesize commentItem     = _commentItem;

- (void) setupContentView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:[self titleLabel]];
    [self addSubview:[self contentLabel]];
    [self addSubview:[self timeLabel]];
    self.imageView.image = [[UIImage imageNamed:kNoPhotoImage] imageWithCornerRadius:4];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView addEffect];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_contentLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_commentItem);
    [super reduceMemory];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5.0f, 5.0f, 50.0f, 50.0f);
    [self.contentLabel setFrameHeight:self.height - 30];
}

- (void)drawRect:(CGRect)rect
{
    [super    drawRect:rect];
    CGRect bottomRect = CGRectMake(0, rect.size.height - 1, 320, 1);
    [[UIImage imageNamed:@"guang_cell_bottom"] drawAsPatternInRect:bottomRect];
}

- (void)setCommentItem:(ListCommentItem *)commentItem
{
    if (_commentItem != commentItem) {
        [_commentItem release];
        _commentItem = [commentItem retain];
        
        self.titleLabel.text = _commentItem.username;
        self.contentLabel.text = _commentItem.text;
        self.timeLabel.text = _commentItem.time;
        
        __block CommentsTableViewCell *blockSelf = self;
        [self.imageView setImageWithURL:[NSURL URLWithString:_commentItem.img]
                       placeholderImage:[[UIImage imageNamed:kNoPhotoImage] imageWithCornerRadius:4]
                                success:^(UIImage *image)
         {
             blockSelf.imageView.image = [image imageWithCornerRadius:8.0f];
         }
                                failure:^(NSError *error)
         {
             ERRLOG(@"image's URL = %@ , %@",_commentItem.img,error);
         }];
    }
}

- (UILabel *) titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[CreateObject titleLabel] retain];
        _titleLabel.frame = CGRectMake(65, 5, 150, 20);
        _titleLabel.font = TNRFONTSIZE(kFontSize14);
        _titleLabel.textColor = kOrangeColor;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *) contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [[CreateObject titleLabel] retain];
        _contentLabel.frame = CGRectMake(65, 23, 250, self.height - 27);
        _contentLabel.font = TNRFONTSIZE(kFontSize13);
        _contentLabel.textColor = kLightGrayColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *) timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[CreateObject titleLabel] retain];
        _timeLabel.frame = CGRectMake(212, 2, 100, 20);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = TNRFONTSIZE(kFontSize13);
        _timeLabel.textColor = kLightGrayColor;
        _timeLabel.numberOfLines = 1;
        //        [_timeLabel setText:@"2012-22-22"];
    }
    return _timeLabel;
}

- (void) testData
{
    [[self titleLabel] setText:@"阿狸"];
    [[self contentLabel] setText:@"据新华社电 “企业职工基本养老保险省级统筹，\
     实现基础养老金全国统筹。”人力资源和社会保障部副部长胡晓义说。据新华社电 \
     “企业职工基本养老保险省级统筹，实现基础养老金全国统筹。”人力资源和社会保障部副部长胡晓义说。"];
    [[self timeLabel] setText:@"2012-2-2"];
}


@end
