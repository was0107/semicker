//
//  FrontCoverViewController.m
// sejieios
//
//  Created by allen.wang on 1/25/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "FrontCoverViewController.h"
#import "FrontCoverViewController_Private.h"
#import "UIImageView+(ASI).h"
#import "UIView+extend.h"
#import "UserDefaultsManager.h"
#import "FrontCoverImages.h"
#import "UIImage+extend.h"


static NSUInteger BeginTag = 1008;

@implementation FrontCoverViewController
@synthesize scrollView  = _scrollView;
@synthesize contents    = _contents;
@synthesize tipImageView= _tipImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:kTitleSetFrontCoverString show:NO];
    [self.titleView addSubview:[self leftButton]];
    [self.view addSubview:[self scrollView]];
    
    
    self.contents = [[FrontCoverImages instance] AllImages];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_contents);
    TT_RELEASE_SAFELY(_tipImageView);
    [super reduceMemory];
}

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    return leftButton;
}

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *) scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kContentWithBarFrame];
    }
    return _scrollView;
}

- (void) downloadImageURL:(NSString *) imageString withImageView:(UIImageView *) imageView
{
    if (!imageString || ! imageString) {
        return;
    }
    [imageView setImageWithURL:[NSURL URLWithString:imageString]
                       success:^(UIImage *image)
     {
         imageView.image = [image imageWithCornerRadius:4];
     }
                       failure:nil];
}

- (void) sendRequestToServer
{
    [WASBaseServiceFace serviceWithMethod:[URLMethod modifyinfo]
                                     body:nil//[modifyRequest toJsonString]
                                    onSuc:^(id content)
     {
         DEBUGLOG(@"modify info success = %@", content);
     }
                                 onFailed:nil
                                  onError:nil];
}

- (UIImageView *) tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 16, 16)];
        _tipImageView.image = [UIImage imageNamed:kTopFilterImageSelectImage];
    }
    return _tipImageView;
}

- (void) changeCover:(NSUInteger ) index
{
    [self.tipImageView removeFromSuperview];
    UIImageView *imageView = (UIImageView *)[[self scrollView] viewWithTag:(BeginTag + index)];
    if (imageView) {
        [imageView addSubview:self.tipImageView];
    }
}

- (void) setContents:(NSMutableArray *)contents
{
    if (_contents != contents) {
        [_contents release];
        _contents = [contents retain];
        
        [[self scrollView] emptySubviews];
        
        NSUInteger col = ([_contents count] + 2)/3 ;
        
        for (NSUInteger i = 0 ; i < col ; i++) {
            NSInteger total = MIN([_contents count] - 3 * i , 3);
            for (NSUInteger j = 0 ; j < total ; j++) {
                CGRect rect = CGRectMake(5 + 105 * j, 5 + 105 * i, 100, 100);
                
                UIImageView *imagView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
                imagView.tag = BeginTag + 3 * i + j;
                imagView.userInteractionEnabled = YES;
                imagView.backgroundColor = kWhiteColor;
                UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTaped:)] autorelease];
                [imagView addGestureRecognizer:gesture];
                
                [self downloadImageURL:[_contents objectAtIndex:3*i+j] withImageView:imagView];
                [[self scrollView] addSubview:imagView];
            }
        }
        [self changeCover:[[FrontCoverImages instance] indexURL]];
        [self.scrollView setContentSize:CGSizeMake(320, col * 105 + 5)];
    }
}

- (void)didTaped:(UIGestureRecognizer *) recognizer
{
    UIImageView *imageView = (UIImageView *)recognizer.view;
    [self changeCover:(imageView.tag - BeginTag)];
    [[FrontCoverImages instance] saveIndex:imageView.tag - BeginTag];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
