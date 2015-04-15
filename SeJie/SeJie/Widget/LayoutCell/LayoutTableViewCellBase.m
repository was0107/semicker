//
//  LayoutTableViewCellBase.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "LayoutTableViewCellBase.h"
#import "FileManager.h"
#import "SeJieGlobal.h"
#import "NSObject+Block.h"

@implementation CellImageView
@synthesize item = _item;

@end

@implementation LayoutTableViewCellBase
@synthesize layoutType = _layoutType;
@synthesize block = _block;

- (void) setupContentView
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bgColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:kPlaceHolderBGImage]] retain];
    _defaultImage  = [[UIImage imageNamed:kPlaceHolderImage] retain];
    _defaultImage1 = [[UIImage imageNamed:kPlaceHolderImage1] retain];
    
}

- (void) reduceMemory
{
    [self cancelDownloadImgaes];
    TT_RELEASE_SAFELY(_layoutType);
    TT_RELEASE_SAFELY(_block);
    TT_RELEASE_SAFELY(_bgColor);
    TT_RELEASE_SAFELY(_defaultImage);
    TT_RELEASE_SAFELY(_defaultImage1);
    [super reduceMemory];
}

- (void) cancelDownloadImgaes
{
    for (NSUInteger i = 0 ; i < [self.contentView.subviews count]; i++) {
        UIView *view = [self.contentView.subviews objectAtIndex:i];
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            [imageView cancelDownloadImage];
        }
    }
}
- (void) prepareForReuse
{
    [super prepareForReuse];
    [self cancelDownloadImgaes];
}

- (void) setLayoutType:(LayoutCellModelBase *)layoutType
{
    if (_layoutType != layoutType) {
        [_layoutType release];
        _layoutType = [layoutType retain];
        
        [self configureCellContent];
    }
}

- (void) didTaped:(UIGestureRecognizer *)gesture
{
    
}

- (void) configureCellContent
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImage *imageContent = nil;
    for (NSUInteger i = 0 ; i < [self.layoutType count]; i++) {
        LayoutItemBase *item = [[self.layoutType items] objectAtIndex:i];
        
        ListImageItem  *imageItem = (ListImageItem *)item.content;
        CellImageView *imageView = [[[CellImageView alloc] initWithFrame:item.itemRect] autorelease];
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = _bgColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.borderWidth = 0.5f;
        imageView.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:0.5] CGColor];
        imageView.userInteractionEnabled = YES;
        imageView.item = imageItem;
        
        UITapGestureRecognizer *tapGesutre = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTaped:)] autorelease];
        [imageView addGestureRecognizer:tapGesutre];
        
        imageContent = (1 == item.itemDefault) ? _defaultImage :  _defaultImage1;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageItem.img]
                     placeholderImage:imageContent
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (!error) {
                                    imageView.image = [image imageScaledToSizeEx:item.itemRect.size];
                                } else {
                                    imageView.image = imageContent;
                                }
        }];
        [self.contentView addSubview:imageView];
        
    }
}

@end


@implementation LayoutNormalCell

- (void) configureCellContent
{
    [super configureCellContent];
}

- (void) didTaped:(UIGestureRecognizer *)gesture
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .2f;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    CellImageView *imageView = (CellImageView *) gesture.view;
    [imageView.superview bringSubviewToFront:imageView];
    [imageView.layer addAnimation:animation forKey:nil];
    
    __block LayoutNormalCell  *blockSelf = self;
    [self performBlock:^ {
        if (blockSelf.block) {
            blockSelf.block(imageView.item);
        }
    } afterDelay:.2f];
}

@end
