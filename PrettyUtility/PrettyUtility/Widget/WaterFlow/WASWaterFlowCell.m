//
//  WASWaterFlowCell.m
//  micker
//
//  Created by allen.wang on 8/15/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASWaterFlowCell.h"
//#import "UIImageView+(ASI).h"

NSString *WASWaterFlowCellIsSelected   = @"WASWaterFlowCellIsSelected";

@interface WASWaterFlowCell()
{
   __block UIImageView *_imageView;
}

@end

@implementation WASWaterFlowCell
@synthesize indexPath       = _indexPath;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize imageView       = _imageView;
@synthesize borderView      = _borderView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super init])
	{
		self.reuseIdentifier = reuseIdentifier;
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _imageView.userInteractionEnabled = YES;
//        _imageView.layer.borderWidth  = 2.0f;
//        [_imageView.layer setMasksToBounds:NO];
//        _imageView.layer.shadowOffset = CGSizeMake(1, 0);
//        [_imageView.layer setShadowOpacity:0.5];
//        [_imageView.layer setShadowRadius:1.0];
        
        [self addSubview:self.imageView];
        
        _borderView = [[UIView alloc] initWithFrame:self.bounds];
        _borderView.backgroundColor = [UIColor clearColor];
        _borderView.layer.borderWidth = 1.0f;
        _borderView.layer.borderColor = [[UIColor colorWithRed:227/255.0f green:227/255.0f blue:230/255.0f alpha:1.0f] CGColor];
        [self addSubview:_borderView];

	}
	
	return self;
}

- (void)dealloc
{
//    [self.imageView cancelDownloadImage];
    [_indexPath release], _indexPath = nil;
    [_reuseIdentifier release], _reuseIdentifier = nil;
    [_imageView release], _imageView = nil;
    [_borderView release], _borderView = nil;
    [super dealloc];
}

- (void) prepareForReuse
{
//    return;
//    [self.imageView cancelDownloadImage];
//    self.imageView.image = [UIImage imageNamed:kWaterFlowBgDefault];
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _borderView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

@end
