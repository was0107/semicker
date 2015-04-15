//
//  SearchViewController.m
// sejieios
//
//  Created by Jarry on 13-1-5.
//  Copyright (c) 2013年 allen.wang. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBarView.h"
#import "UIButton+extend.h"

@interface SearchViewController ()

@property (nonatomic, retain) SearchBarView   *searchBarView;

@end

@implementation SearchViewController

@synthesize keyword = _keyword;
@synthesize completeBlock = _completeBlock;
@synthesize cancelBlock = _cancelBlock;
@synthesize searchBarView = _searchBarView;

#pragma mark - base

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pageViewId = TD_PAGE_SEJIE_SEARCH_INPUT;
    
    [[self titleLabel] setText:kTitleSearchString];
    
    [self.titleView addSubview:[self leftButton]];
    [self.titleView addSubview:[self rightButton]];
    
    [self.view addSubview:[self searchBarView]];
    [self.searchBarView showAutoFillList];
    
    /*UITapGestureRecognizer *tapGestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)] autorelease];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: tapGestureRecognizer];*/
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.searchBarView.searchField becomeFirstResponder];
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_completeBlock);
    TT_RELEASE_SAFELY(_cancelBlock);
    TT_RELEASE_SAFELY(_searchBarView);
    [super reduceMemory];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setKeyword:(NSString *)keyword
{
    _keyword = [keyword copy];
    
    if (_searchBarView) {
        [_searchBarView.searchField setText:keyword];
    }
}

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
//        [leftButton setImage:[UIImage imageNamed:kMainBackIconImage] forState:UIControlStateNormal];
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    
    return leftButton;
}

- (UIButton *) rightButton
{
    UIButton *rightButton = [super rightButton];
    if (rightButton) {
        [rightButton setFrame:kHeaderDoneFrame];
        [rightButton setNormalImage:kMainDoneIconImage selectedImage:kMainDoneSelIconImage];
    }
    
    return rightButton;
}

#pragma mark - actions

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (IBAction)rightButtonAction:(id)sender
{
    // Search Text PV
    [[DataTracker sharedInstance] trackEvent:TD_EVENT_SEARCH_TEXT_PV
                                   withLabel:_searchBarView.searchField.text
                                    category:TD_EVENT_Category];
    [self startSearch:_searchBarView.searchField.text];
}

- (void) startSearch:(NSString *)keyword
{
    if (keyword.length == 0) {
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.completeBlock) {
        self.completeBlock(keyword);
    }
}

-(void)tapAction:(id)sender
{
    [_searchBarView activateSearchField:NO];
}

#pragma mark - init

- (SearchBarView *) searchBarView
{
    if (!_searchBarView) {
        _searchBarView = [[SearchBarView alloc] initWithFrame:kSearchBarFrame];
        [_searchBarView initAutoFillList:self.view history:YES backColor:nil];
        _searchBarView.completeBlock = ^ (id content)
        {
            [self startSearch:content];
        };
    }
    return _searchBarView;
}



@end
