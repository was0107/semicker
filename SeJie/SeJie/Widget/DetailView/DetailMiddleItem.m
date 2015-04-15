//
//  DetailMiddleItem.m
// sejieios
//
//  Created by allen.wang on 1/6/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "DetailMiddleItem.h"
#import "CreateObject.h"
#import "WASImageWithBackgroundView.h"
#import "ListGoodsItem.h"
#import "UIImageView+(ASI).h"
#import "UIButton+extend.h"
#import "UIImage+extend.h"

@interface DetailMiddleItem()
@property (nonatomic, retain) WASImageWithBackgroundView *imageView;
@property (nonatomic, retain) UIButton    *goTipButton;
@property (nonatomic, retain) UILabel     *contentLabel;
@property (nonatomic, retain) UILabel     *fromLabel;
@property (nonatomic, retain) UILabel     *priceLabel;
@end


@implementation DetailMiddleItem
@synthesize imageView           = _imageView;
@synthesize contentLabel        = _contentLabel;
@synthesize fromLabel           = _fromLabel;
@synthesize priceLabel          = _priceLabel;
@synthesize goTipButton         = _goTipButton;
@synthesize content             = _content;
@synthesize itemBlock           = _itemBlock;
@synthesize isDownload          = _isDownload;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        
        _defalutImage = [[[UIImage imageNamed:kGoodsDefalutBGImage] imageWithCornerRadius:4] retain];
        [self addSubview:self.imageView];
        [self addSubview:self.contentLabel];
        [self addSubview:self.fromLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.goTipButton];
        self.isDownload = NO;
        
        UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnItem:)] autorelease];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void) dealloc
{
    if ([self.gestureRecognizers count] > 0) {
        [self removeGestureRecognizer:[self.gestureRecognizers objectAtIndex:0]];
    }
    //    [_imageView cancelDownloadImage];
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_defalutImage);
    TT_RELEASE_SAFELY(_contentLabel);
    TT_RELEASE_SAFELY(_fromLabel);
    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_goTipButton);
    TT_RELEASE_SAFELY(_itemBlock);
    [super dealloc];
}

- (void) setContent:(id)content
{
    if (_content != content)
    {
        _content = content;
        _isDownload = NO;
        ListGoodsItem *item = (ListGoodsItem *) content;
        self.contentLabel.text = item.title;
        self.fromLabel.text = item.source;
        self.priceLabel.text = kPriceFormat(item.price);
    }
}

- (void) downloadImage
{
    if (!_content || _isDownload) {
        return;
    }
    ListGoodsItem *item = (ListGoodsItem *) _content;
    [_imageView setImageWithURL:[NSURL URLWithString:item.img]
               placeholderImage:_defalutImage
                        success:^(UIImage *image)
     {
         _imageView.image = [image imageWithCornerRadius:8.0f];
         _isDownload = YES;
     }
                        failure:^(NSError *error)
     {
         ERRLOG(@"image's URL = %@ , %@",item.img,error);
         _isDownload = NO;
         
     }];
}

- (WASImageWithBackgroundView *) imageView
{
    if (!_imageView) {
        _imageView = [[WASImageWithBackgroundView alloc] initWithFrame:CGRectMake(5, 30, 82, 82)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = _defalutImage;//@"goods_image_bg"
    }
    return _imageView;
}

- (UIButton *) goTipButton
{
    if (!_goTipButton) {
        _goTipButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _goTipButton.frame = CGRectMake(222, 84, 95, 30);
        [_goTipButton setNormalImage:@"go_to_see" hilighted:nil selectedImage:nil];
        [_goTipButton addTarget:self action:@selector(goTipButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goTipButton;
}

- (UILabel *) contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [[CreateObject titleLabel] retain];
        _contentLabel.frame = CGRectMake(95, 28, kFilterViewWidth+10, 40);
        _contentLabel.font = TNRFONTSIZE(kFontSize13);
        _contentLabel.textColor = kGrayColor;
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UILabel *) fromLabel
{
    if(!_fromLabel)
    {
        _fromLabel = [[CreateObject titleLabel] retain];
        _fromLabel.frame = CGRectMake(95, 70, 165, 20);
        _fromLabel.font = TNRFONTSIZE(kFontSize13);
        _fromLabel.textColor = kLightGrayColor;
        _fromLabel.numberOfLines = 1;
    }
    return _fromLabel;
}

- (UILabel *) priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [[CreateObject titleLabel] retain];
        _priceLabel.frame = CGRectMake(95, 92, 165, 20);
        _priceLabel.font = TNRFONTSIZE(kFontSize14);
        _priceLabel.textColor = kOrangeColor;
        _priceLabel.numberOfLines = 1;
    }
    return _priceLabel;
}

- (IBAction)goTipButtonAction:(id)sender
{
    if (self.itemBlock) {
        self.itemBlock(self.content);
    }
}

- (void) didTapOnItem:(UITapGestureRecognizer *) recognizer
{
    [self goTipButtonAction:nil];
}

@end
