//
//  ECSettingViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECSettingViewController.h"
#import "CommonToolkit/CommonToolkit.h"
#import "ECSettingView.h"
#import "ECMoneyGainViewController.h"

@interface ECSettingViewController ()

@end

@implementation ECSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self = [self initWithCompatibleView:[[ECSettingView alloc] init]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
}

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

- (void)jumpToMoneyGain {
    UIViewController *moneyGainController = [[ECMoneyGainViewController alloc] init];
    moneyGainController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moneyGainController animated:YES];
}
@end
