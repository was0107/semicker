//
//  ViewController.m
//  comprettyios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ViewController.h"

#import "MainViewController.h"
#import "SearchViewController.h"
#import "SejieUpdateControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
//    WASContainer *container = [[WASContainer alloc] initWithFrame:kContentFrame];
//    
//    for (NSUInteger i = 0 ; i < 10; i++) {
//        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20 * (i + 1))];
//        view1.backgroundColor = [UIColor redColor];
//        [container add:view1];
//    }
//    [self.view addSubview:container];
//    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80, 200, 48, 44);
//    button.backgroundColor = kRedColor;
    [button setTitle:@"磁 贴" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(160, 200, 60, 44);
//    button2.backgroundColor = kRedColor;
    [button2 setTitle:@"瀑布流" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    self.view.backgroundColor = kGrayColor;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)go:(id)sender
{
    MainViewController *controller = [[[MainViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)testButton:(id)sender
{
//    WaterFlowViewController *controller = [[[WaterFlowViewController alloc] init] autorelease];
        
    SearchViewController *controller = [[[SearchViewController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
