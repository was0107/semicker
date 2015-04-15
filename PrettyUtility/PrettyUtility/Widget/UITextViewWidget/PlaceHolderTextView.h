//
//  PlaceHolderTextView.h
//  PrettyUtility
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView

@property (nonatomic, retain)   UILabel *placeHolderLabel;
@property (nonatomic, copy)     NSString *placeholder;


-(void)textChanged:(NSNotification*)notification;

@end
