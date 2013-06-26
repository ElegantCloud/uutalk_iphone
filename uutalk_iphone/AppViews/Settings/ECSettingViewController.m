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
#import "ECAboutViewController.h"
#import "ECCallbackNumberSetViewController.h"
#import "ECDialSettingViewController.h"
#import "ECUUTalkCardChargeViewController.h"
#import "UserBean+UUTalk.h"
#import "ECConfig.h"

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
//    UIViewController *topupController = [[ECTopupViewController alloc] init];
    UIViewController *viewCtrl = [[ECUUTalkCardChargeViewController alloc] init];
    [self jumpToViewController:viewCtrl];
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
        NSLog(@"sign out account");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:USERNAME];
        [userDefaults removeObjectForKey:PASSWORD];
        [userDefaults removeObjectForKey:VOSPHONE];
        [userDefaults removeObjectForKey:VOSPHONE_PWD];
        [userDefaults removeObjectForKey:USERKEY];
        [userDefaults removeObjectForKey:COUNTRYCODE];
        [userDefaults removeObjectForKey:DEFAULT_DIAL_COUNTRY_CODE];
        [userDefaults removeObjectForKey:CALLBACK_PHONE_NUMBER];
        [userDefaults removeObjectForKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
        [NSUserDefaults resetStandardUserDefaults];
        
        
        UserBean *user = [[UserBean alloc] init];
        [[UserManager shareUserManager] setUserBean:user];
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

- (void)jumpToAbout {
    ECAboutViewController *viewCtrl = [[ECAboutViewController alloc] init];
    [self jumpToViewController:viewCtrl];
}

- (void)jumpToCallbackNumberSet {
    ECCallbackNumberSetViewController *viewCtrl = [[ECCallbackNumberSetViewController alloc] init];
    [self jumpToViewController:viewCtrl];
}

- (void)jumpToDialSetting {
    ECDialSettingViewController *viewCtrl = [[ECDialSettingViewController alloc] init];
    [self jumpToViewController:viewCtrl];
}
@end
