//
//  CreateObject.m
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "CreateObject.h"


@implementation CreateObject

+ (UITableView *) plainTableView
{
    return [[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] autorelease];
}

+ (UIImageView *) imageView:(NSString *) image
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:image]] autorelease];
}

+ (UIView *) view
{
    return (UIView *)createOBjectMarco(@"UIView");
}

+ (UIButton *) button
{
    return (UIButton *)createOBjectMarco(@"UIButton");
}

+ (UILabel *) label
{
    return (UILabel *)createOBjectMarco(@"UILabel");
}

+ (UILabel *) titleLabel
{
    UILabel *label  = (UILabel *)createOBjectMarco(@"UILabel");
    label.font = TNRFontSIZEBIG(kFontSize14);
    label.backgroundColor = kClearColor;
    label.textColor = kBlackColor;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
    
}
@end
