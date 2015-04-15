//
//  GuangWaterFlowCell.m
//  micker
//
//  Created by allen.wang on 12/18/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "GuangWaterFlowCell.h"
#import "SeJieGlobal.h"
#import "FileManager.h"
#import "NSString+extend.h"
#import "UIImageView+(ASI).h"
#import "UIView+extend.h"
#import "UILabel+Size.h"
#import "UIImage+extend.h"


static CGFloat targetHeigh  =   140;
static CGFloat targetWidth  =   140;

#define kIphoneCellWidth        150
#define kWaterFlowContentGap    4.0f

@interface GuangWaterFlowCell()
{
    CGSize titleSize;
    CGSize fromSize;
    CGSize cateSize;
    BOOL   isMoved;
}

@end

@implementation GuangWaterFlowCell

@synthesize items               = _items;
@synthesize imageUrl            = _imageUrl;
@synthesize update              = _update;
@synthesize contentsHeight      = _contentsHeight;
@synthesize waterFlowDelegate   = _waterFlowDelegate;
@synthesize columns            = _columns;

- (id)initWithReuseIdentifier:(NSString *)identifier
{
    self = [super initWithReuseIdentifier:identifier];
    if (self) {
        // Initialization code
        self.backgroundColor = kWhiteColor;
        [self setcolumns:2];
        
        //self.layer.borderWidth = 1.0f;
        //self.layer.borderColor = [kPadBorderColor227 CGColor];
        
        self.imageView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.imageView.layer.shadowColor  = [kLightGrayColor CGColor];
        
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin ;
                
        [self.imageView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        CGRect imageFrame   = CGRectMake(kWaterFlowContentGap, kWaterFlowContentGap, _cellWidth, _cellWidth  - 2 * kWaterFlowContentGap);
        
        [self setFrame:CGRectMake(0, 0, _cellWidth, _cellWidth)];
        
        self.imageView.frame = imageFrame;
        
    }
    return self;
}

- (void) dealloc
{
    [self.imageView cancelDownloadImage];
    [self.imageView removeObserver:self forKeyPath:@"frame"];
    TT_RELEASE_SAFELY(_items);
    TT_RELEASE_SAFELY(_imageUrl);
    TT_RELEASE_SAFELY(_update);
    self.waterFlowDelegate = nil;
    [super dealloc];
}


- (void) setcolumns:(NSUInteger)columns
{
    _columns = columns;
    if (_columns == 2) {
        targetHeigh  = targetWidth  = 140;
        _cellWidth   = 150;
    } else {
        targetHeigh  = targetWidth  = 90;
        _cellWidth   = 100;
    }
    
    [self setFrameWidth:_cellWidth];
    [self.imageView setFrameWidth:_cellWidth - 2 * kWaterFlowContentGap];
}


- (void) layoutSubviews
{
    [super layoutSubviews];
}


- (void) didMoveToSuperview
{
    if (self.superview) {
        [self drawElements];
    }
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    [self.favourateLabel setFrameY:self.imageView.height - 14];
//    [self.favourateImageView setFrameY:self.imageView.height - 16];
}

- (void) onMainThread:(NSNumber *) heigt
{
    CGFloat targetH = (2 == _columns) ?  140 : 90;
    CGFloat targetW = (2 == _columns) ?  140 : 90;
    
    NSInteger row    = [[[self layer] valueForKey:CELL_VIEW_ROW_KEY] integerValue];
    NSInteger column = [[[self layer] valueForKey:CELL_VIEW_COLUMN__] integerValue];
    UIImage *sourceImage = self.imageView.image;
    CGSize  sourceSize   = sourceImage.size;
    CGFloat factor       = sourceSize.height/sourceSize.width;
    int imageHeight      = targetW * factor;
    CGFloat distance     = imageHeight - targetH;

    [self setFrameHeight: (imageHeight + kWaterFlowContentGap*2)];
    [self.imageView setFrame:CGRectMake(kWaterFlowContentGap, kWaterFlowContentGap,targetH, imageHeight )];
        
    if (self.update) {
        self.update(column,row,distance, YES);
    }

}

- (void) drawElements
{
    //BOOL flag = YES;//[B5MUtility isWifi];

    [self.imageView setImageWithURLString:_items.img placeholderImage:nil success:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            
            CGFloat imageHeight = targetWidth * image.size.height/image.size.width;
            if (imageHeight > targetWidth*2) {
//                DEBUGLOG(@"--- imageScaledToSizeEx --- height = %f", imageHeight);
                self.imageView.image = [image imageScaledToSizeEx:CGSizeMake(targetWidth, targetWidth*2)];
            }
            else {
                self.imageView.image = image;
            }
            
            [self performSelectorOnMainThread:@selector(onMainThread:) withObject:[NSNumber numberWithFloat:_cellWidth] waitUntilDone:NO];
        });
    } failure:^(NSError *error) {
        [self performSelectorOnMainThread:@selector(onMainThread:) withObject:[NSNumber numberWithFloat:_cellWidth] waitUntilDone:NO];

    }];
}


- (CGFloat ) contentsHeight
{
    return  self.imageView.height + kWaterFlowContentGap * 2.0f;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoved = NO;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoved = YES;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self tapedOnCell];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self tapedOnCell];
}

- (void)cellSelected:(NSInteger)index
{
    if ([self.waterFlowDelegate respondsToSelector:@selector(waterFlowView:didSelectRowAtIndex:)])
    {
        [self.waterFlowDelegate waterFlowView:self didSelectRowAtIndex: index];
    }
}

- (void) tapedOnCell
{
    if (!isMoved) {
        NSInteger index = [[[self layer] valueForKey:CELL_VIEW_INDEX_KEY] integerValue];;
        [self cellSelected:index];
    }
}


@end
