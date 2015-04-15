//
//  CustomPickerViewController.m
// sejieios
//
//  Created by allen.wang on 1/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "CustomPickerViewController.h"
#import "UIButton+extend.h"
#import "UIView+extend.h"

@implementation CustomPickerViewController
@synthesize customDelegate ;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        self.allowsEditing = NO;
        self.sourceType = sourceType;
        self.delegate   = self;
    }
    return self;
}

- (void)setCustomImagePickerDelegate : (id<CustomPickerrDelegate> ) theCustomDelegate
{
    customDelegate = theCustomDelegate;
}

-(UIView *)findView:(UIView *)aView withName:(NSString *)name{
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc])
        return aView;
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++)
    {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findView:subView withName:name];
        if (subView)
            return subView;
    }
    return nil;
}

-(void)addSomeElements:(UIViewController *)viewController{
    //Add the motion view here, PLCameraView and picker.view are both OK
    UIView *PLCameraView=[self findView:viewController.view withName:@"PLCameraView"];
    
    //Get Bottom Bar
    UIView *bottomBar=[self findView:PLCameraView withName:@"PLCropOverlayBottomBar"];
    
    //Get ImageView For Camera
    UIImageView *bottomBarImageForCamera = [bottomBar.subviews objectAtIndex:1];
    
    //Get Button 1
    UIButton *cancelButton=[bottomBarImageForCamera.subviews objectAtIndex:1];
    
    [cancelButton setFrameWidth:cancelButton.height];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = cancelButton.frame;
    [customButton setNormalImage:@"camera_cancel" selectedImage:nil];
    [customButton setBackgroundImage:nil selectedImage:nil clickImage:nil];
    [bottomBarImageForCamera insertSubview:customButton belowSubview:cancelButton];
    [customButton addTarget:self action:@selector(customCancel:) forControlEvents:UIControlEventTouchUpInside];

    if (cancelButton ) {
        _cancelButton = cancelButton;
        cancelButton.alpha = 0;
    }

    //Add a button for open album
    UIButton *album = [UIButton buttonWithType:UIButtonTypeCustom];
    [album setImage:[UIImage imageNamed:@"camera_photo"] forState:UIControlStateNormal];
    [album setFrame:CGRectMake(270, cancelButton.frame.origin.y, cancelButton.frame.size.width, cancelButton.frame.size.height)];
    [album addTarget:self action:@selector(showAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBarImageForCamera addSubview:album];
}

- (IBAction)customCancel:(id)sender
{
    [_cancelButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)showAlbum:(UIButton *) sender
{
    UIViewController *viewController = (UIViewController *)customDelegate;
    CustomPickerViewController *imagePicker = [[CustomPickerViewController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setCustomImagePickerDelegate:customDelegate];
    [viewController dismissViewControllerAnimated:NO completion:nil];
    [viewController.navigationController presentViewController:imagePicker animated:YES completion:nil];
    [imagePicker release];
}

- (void) enableAllButtons:(UIView *) subView
{
    for (UIView *view1 in subView.subviews )
    {
        if([view1 isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *) view1;
            button.enabled = YES;
        }
        [self enableAllButtons:view1];
    }
}

- (void) enableButtons:(UIViewController *)viewController
{
    [self enableAllButtons:viewController.view];
}

#pragma mark - UIImagePickerController

#pragma mark - UINavigationController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self addSomeElements:viewController];
    [self enableButtons:viewController];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIViewController *viewController = (UIViewController *)customDelegate;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    if([viewController respondsToSelector:@selector(customImagePickerController:didFinishPickingImage:editingInfo:)]){
        [customDelegate customImagePickerController:picker didFinishPickingImage:image editingInfo:editingInfo];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIViewController *viewController = (UIViewController *)customDelegate;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    if([viewController respondsToSelector:@selector(hersImagePickerControllerDidCancel:)]){
        [customDelegate customImagePickerControllerDidCancel:picker];
    } else {
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera ) {
            [picker dismissViewControllerAnimated:YES completion:nil];
        } else {
            
            if( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] )
            {
                [picker dismissModalViewControllerAnimated:NO];
                if ([viewController respondsToSelector:@selector(rebackFromPhoto:)])
                    [customDelegate rebackFromPhoto:picker];
            }
            else
            {
                [picker dismissViewControllerAnimated:YES completion:nil ];
            }
        }
    }
    
}

@end
