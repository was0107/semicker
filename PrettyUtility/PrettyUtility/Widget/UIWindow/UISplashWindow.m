//
//  UISplashWindow.m
//  PrettyUtility
//
//  Created by allen.wang on 1/29/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "UISplashWindow.h"
#import "NSObject+Block.h"

@implementation UISplashWindow
@synthesize block = _block;

+(UISplashWindow *) instance
{
    static dispatch_once_t  onceToken;
    static UISplashWindow * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UISplashWindow alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    CGRect screenBound = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:screenBound];
    if (self) {
        // Initialization code
        self.hidden = NO;
        self.windowLevel = UIWindowLevelStatusBar + 100.0f;
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:screenBound] autorelease];
        UIViewController *controller = [[[UIViewController alloc] init] autorelease];
        controller.view.frame = screenBound;
        controller.view.backgroundColor = kClearColor;
        imageView.image = [UIImage imageNamed:iPhone5 ? @"Default-568h" : @"Default"];
        [controller.view addSubview:imageView];
        [self setRootViewController:controller];
        [self becomeKeyWindow];
    }
    return self;
}

- (void)setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
}

- (void) dealloc
{
    self.block = nil;
    [super dealloc];
}

- (void) dissmiss
{
    __block UISplashWindow *blockSelf = self;
    [self performBlock:^{
        blockSelf.block();
        [UIView animateWithDuration:.25
                         animations:^
        {
            blockSelf.alpha = 0.0f;
        }
                         completion:^(BOOL finished)
        {
            [blockSelf resignKeyWindow];
            [blockSelf setHidden:YES];
        }];
    }
            afterDelay:1];
}

@end
