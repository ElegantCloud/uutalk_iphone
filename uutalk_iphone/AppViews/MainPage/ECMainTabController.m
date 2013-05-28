//
//  ECMainTabController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECMainTabController.h"
#import "ECSettingViewController.h"
#import "ECDialContentViewController.h"

@interface ECMainTabController ()

@end

@implementation ECMainTabController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIViewController *dialTabController = [[ECDialContentViewController alloc] init];
        UINavigationController *settingController = [[UINavigationController alloc] initWithRootViewController:[[ECSettingViewController alloc] init]];
        [dialTabController.tabBarItem initWithTitle:NSLocalizedString(@"dial", "") image:[UIImage imageNamed:@"tab_dial"] tag:2];
        [settingController.tabBarItem initWithTitle:NSLocalizedString(@"more", "") image:[UIImage imageNamed:@"tab_more"] tag:4];
        self.viewControllers = [NSArray arrayWithObjects:dialTabController, settingController, nil];
        self.selectedViewController = settingController;
        
    }
    return self;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [super viewWillAppear:animated];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
