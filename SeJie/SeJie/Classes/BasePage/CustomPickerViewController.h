//
//  CustomPickerViewController.h
// sejieios
//
//  Created by allen.wang on 1/17/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPickerrDelegate <NSObject>


- (void) customImagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo;

@optional
- (void) customImagePickerControllerDidCancel:(UIImagePickerController *)picker;

- (void) rebackFromPhoto:(UIImagePickerController *)picker;

@end

@interface CustomPickerViewController : UIImagePickerController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    id<CustomPickerrDelegate> customDelegate;
    UIButton *_cancelButton;
}
@property (nonatomic, assign)id <CustomPickerrDelegate> customDelegate;

- (void)setCustomImagePickerDelegate : (id<CustomPickerrDelegate> ) theCustomDelegate;
@end
