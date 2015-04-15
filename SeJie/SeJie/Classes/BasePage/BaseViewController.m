//
//  BaseViewController.m
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

@synthesize pageViewId = _pageViewId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = kContentFrame;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackGroundImage]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self reduceMemory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DEBUGLOG(@"memory warning ! -- %@", self.pageViewId);
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_pageViewId);
}

- (void) dealloc
{
    [self reduceMemory];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // DataTracker
    [[DataTracker sharedInstance] beginTrackPage:self.pageViewId];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // DataTracker
    [[DataTracker sharedInstance] endTrackPage:self.pageViewId];
}

@end
