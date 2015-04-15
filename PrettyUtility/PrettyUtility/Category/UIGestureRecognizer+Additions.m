//
//  UIGestureRecognizer+Additions.h
//  micker
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "UIGestureRecognizer+Additions.h"

B5M_FIX_CATEGORY_BUG(UIGestureRecognizerAdditions)


@implementation UIGestureRecognizer (Additions)

- (void)end {
    BOOL currentStatus = self.enabled;
    self.enabled = NO;
    self.enabled = currentStatus;
}

- (BOOL)hasRecognizedValidGesture {
    return (self.state == UIGestureRecognizerStateChanged || self.state == UIGestureRecognizerStateBegan);
}

@end
