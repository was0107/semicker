//
//  UIView+BaseKit.m
//  micker
//
//  Created by allen.wang on 9/24/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIView+BaseKit.h"

B5M_FIX_CATEGORY_BUG(UIViewPrivate)

@interface UIView (Private)

- (NSMutableArray *)findTextFieldsAndStopAtFirst:(BOOL)stopAtFirst;

@end

@implementation UIView (BaseKit)

- (UIView *)findFirstResponder {
    if ([self isFirstResponder]) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (nil != firstResponder) {
            return firstResponder;
        }
    }
    
    return nil;
}


- (id)findFirstTextField {
    NSArray *fields = [self findTextFieldsAndStopAtFirst:YES];
    if (fields.count == 1) {
        return [fields lastObject];
    }
    return nil;
}


- (NSArray *)findTextFields {
    return [self findTextFieldsAndStopAtFirst:NO];
}

- (void)show {
    self.alpha = 1;
}

- (void)hide {
    self.alpha = 0;
}


- (void)toggle {
    self.alpha = (self.alpha > 0) ? 0 : 1;
}

- (void)fadeInWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    }];
}

- (void)fadeOutWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    }];
}

- (void)fadeOutAndRemoveFromSuperviewWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark -
#pragma mark Private

- (NSMutableArray *)findTextFieldsAndStopAtFirst:(BOOL)stopAtFirst {
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    
    [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if (YES == stopAtFirst && 1 == fields.count) {
            *stop = YES;
        }
        
        if ([subView isKindOfClass:[UITextField class]] || [subView isKindOfClass:[UITextView class]]) {
            [fields addObject:subView];
        } else {
            NSArray *fieldsFounded = [subView findTextFieldsAndStopAtFirst:stopAtFirst];
            [fields addObjectsFromArray:fieldsFounded];
        }
    }];
    
    return fields;
}
@end
