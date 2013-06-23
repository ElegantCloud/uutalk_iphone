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
#import "ECConstants.h"
#import "ECBalanceQueryViewController.h"

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

- (void)signOut {
    RIButtonItem *okItem = [RIButtonItem item];
    okItem.label = NSLocalizedString(@"OK", "");
    okItem.action = ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:nil forKey:USERNAME];
        [userDefaults setObject:nil forKey:PASSWORD];
        [userDefaults setObject:nil forKey:VOSPHONE];
        [userDefaults setObject:nil forKey:VOSPHONE_PWD];
        [userDefaults setObject:nil forKey:USERKEY];
        [userDefaults setObject:nil forKey:COUNTRYCODE];
        [userDefaults setObject:nil forKey:DEFAULT_DIAL_COUNTRY_CODE];
        [userDefaults setObject:nil forKey:CALLBACK_PHONE_NUMBER];
        [userDefaults setObject:nil forKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
        
        exit(0);
    };
    RIButtonItem *cancelItem = [RIButtonItem item];
    cancelItem.label = NSLocalizedString(@"Cancel", "");
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UU-Talk Alert", "") message:NSLocalizedString(@"Click OK to logout and exit", "") cancelButtonItem:okItem otherButtonItems:cancelItem, nil] show];
}

- (void)jumpToBalanceQuery {
    ECBalanceQueryViewController *viewCtrl = [[ECBalanceQueryViewController alloc] init];
    [self jumpToViewController:viewCtrl];
}
@end
