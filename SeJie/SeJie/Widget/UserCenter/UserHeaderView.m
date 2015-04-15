//
//  UserHeaderView.m
// sejieios
//
//  Created by Jarry on 13-1-23.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserHeaderView.h"
#import "UIButton+extend.h"
#import "CreateObject.h"
#import "UIView+extend.h"
#import "UIImageView+(ASI).h"
#import "UIImage+extend.h"
#import "UserDefaultsManager.h"

@implementation UserHeaderView

@synthesize photoImageButton = _photoImageButton;
@synthesize userNameLabel    = _userNameLabel;
@synthesize block            = _block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kClearColor;
                
        [self addSubview:self.photoImageButton];
        [self addSubview:self.userNameLabel];
        
        /*
        NSString *userId = [UserDefaultsManager userId];
        if (userId && userId.length > 0) {
            [self updatePhotoImage:[UserDefaultsManager userIcon]];
        }
         */
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_photoImageButton);
    TT_RELEASE_SAFELY(_userNameLabel);
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super    drawRect:rect];
    
    [[UIImage imageNamed:@"user_cover_bg"] drawInRect:self.bounds];
    
    [[UIImage imageNamed:@"user_line_bg"] drawAsPatternInRect:CGRectMake(66, 104, 2, 16)];
    [[UIImage imageNamed:@"user_round_bg"] drawInRect:CGRectMake(62, 94, 10, 10)];
}

- (void) updatePhotoImage:(NSString *)url
{
    [_photoImageButton sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:_photoImageButton.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            _photoImageButton.image = [image imageWithCornerRadius:40];
        }
    }];
}


- (void) resetPhotoImage
{
    _photoImageButton.image = [[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:40];
}

#pragma mark - Setter and Getter

- (UIImageView *) photoImageButton
{
    if (!_photoImageButton) {
        _photoImageButton = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:kPlaceHolderImage] imageWithCornerRadius:40]];
        _photoImageButton.backgroundColor = kWhiteColor;
        _photoImageButton.frame = CGRectMake(28, 5, 80, 80);
//        [_photoImageButton setNormalImage:kNoPhotoImage hilighted:nil selectedImage:nil];
//        [_photoImageButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _photoImageButton.contentMode = UIViewContentModeCenter;
        _photoImageButton.layer.cornerRadius = 40.0f;
        _photoImageButton.layer.borderColor = [kWhiteColor CGColor];
        _photoImageButton.layer.borderWidth = 2.0f;
        _photoImageButton.layer.masksToBounds = YES;
        _photoImageButton.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)] autorelease];
        [_photoImageButton addGestureRecognizer:gesture];
    }
    return _photoImageButton;
}

- (UILabel *) userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[CreateObject titleLabel] retain];
        _userNameLabel.frame = CGRectMake(80, 88, 180, 20);
        _userNameLabel.font = TNRFontSIZEBIG(kFontSize17);
        _userNameLabel.textColor = kWhiteColor;
        _userNameLabel.text = @"宝贝"; //kLabelPlaceHolderString;
        _userNameLabel.numberOfLines = 0;
    }
    return _userNameLabel;
}

#pragma mark - Actions

- (void) buttonAction:(UIGestureRecognizer *)gesture
{
    if (self.block) {
        self.block(nil);
    }
}


@end
