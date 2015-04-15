//
//  SheJieAdapterManagerBase.m
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "SheJieAdapterManagerBase.h"


@implementation SheJieAdapterManagerBase
@synthesize currentType      = _currentType;

- (id) initWithSuperView:(UIView *) superView titleView:(UIImageLabel *) titleView
{
    self = [super init];
    if (self) {
        oldType     = eSheJieNormal;
        _currentType= eSheJieNormal;
        _superView  = superView;
        _titleView  = titleView;
    }
    return self;
}

- (id) setNetTableView:(UITableView *) tableView
{
    return self;
}

- (NSString *) getKeyword
{
    return kEmptyString;
}

- (void) setTitleText:(NSString *)title
{
    _titleView.text = title;
}

- (SheJieAdapterBase *) currentAdapter
{
    return [self adapterAt:self.currentType];
}

- (SheJieAdapterBase *) adapterAt:(NSUInteger) type
{
    return nil;
}

- (void) sendRequestToServer
{
    [[self currentAdapter] sendRequestToServer];
}

- (id) changeTypeTo:(int)type
{
    oldType = self.currentType;
    self.currentType = type;
    return self;
}

- (void) exchangeTitle:(NSString *)title showImage:(BOOL)show
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = AnimateTime.NORMAL;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    
    UIImageLabel *newTitleView = [_titleView retain];
    [newTitleView setText:title show:show];
    [[_titleView.superview layer] addAnimation:animation forKey:@"animation"];
    [newTitleView release];
}

@end
