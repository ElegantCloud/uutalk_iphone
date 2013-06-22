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
#import "ECTopupViewController.h"
#import "ECModifyPasswordViewController.h"
#import "ECFindPasswordViewController.h"

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

- (void)jumpToViewController:(UIViewController *)viewController {
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)jumpToMoneyGain {
    UIViewController *moneyGainController = [[ECMoneyGainViewController alloc] init];
    [self jumpToViewController:moneyGainController];
}

- (void)jumpToTopup {
    UIViewController *topupController = [[ECTopupViewController alloc] init];
    [self jumpToViewController:topupController];
}

- (void)jumpToModifyPassword {
    UIViewController *viewCtrl = [[ECModifyPasswordViewController alloc] init];
    [self jumpToViewController:viewCtrl];
}

- (void)jumpToFindPassword {
    ECFindPasswordViewController *viewCtrl = [[ECFindPasswordViewController alloc] init];
    [viewCtrl setFromSetting:YES];
    [self jumpToViewController:viewCtrl];
}
@end
