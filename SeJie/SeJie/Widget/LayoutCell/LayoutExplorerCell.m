//
//  LayoutExplorerCell.m
// sejieios
//
//  Created by allen.wang on 1/4/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "LayoutExplorerCell.h"
#import "ListSeiJieItem.h"
#import "UIImageView+(ASI).h"
#import "LabelsManager.h"

@implementation LayoutExplorerCell


- (void) configureCellContent
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSUInteger i = 0 ; i < [self.layoutType count]; i++) {
        LayoutItemBase *item = [[self.layoutType items] objectAtIndex:i];
        
        ListImageItem  *imageItem = (ListImageItem *)item.content;
        CellImageView *imageView = [[[CellImageView alloc] initWithFrame:item.itemRect] autorelease];
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        //imageView.layer.borderWidth = 2.0f;
        //imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        imageView.userInteractionEnabled = YES;
        imageView.item = imageItem;
        
        UITapGestureRecognizer *tapGesutre = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTaped:)] autorelease];
        [imageView addGestureRecognizer:tapGesutre];
        
        //imageView.image = [UIImage imageNamed:kFirstLevel(imageItem.img)];//[[UIImage imageNamed:imageItem.img] imageScaledToSizeEx:item.itemRect.size];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageItem.img]
                     placeholderImage:[UIImage imageNamed:@"placeholder_image1"]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (!error) {
                                    imageView.image = image;
                                }
                            }];

        
        [self.contentView addSubview:imageView];
    }

}

- (void) didTaped:(UIGestureRecognizer *)gesture
{
    if (self.block) {
        CellImageView *imageView = (CellImageView *) gesture.view;
        ListSeiJieItemBase *itemBase = (ListSeiJieItemBase *)imageView.item;
        if (itemBase) {
            self.block(itemBase.title);
        }
    }
}

@end
