//
//  ECMainTabController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECMainTabController.h"
#import "ECSettingViewController.h"
#import "CommonToolkit/CommonToolkit.h"
#import "UserBean+UUTalk.h"
#import "SipRegistrationBean.h"
#import "SipUtils.h"
#import "ECConfig.h"
#import "CallRecordHistoryListTabContentViewController.h"
#import "DialTabContentViewController.h"
#import "ContactListTabContentViewController.h"

@interface ECMainTabController ()

@end

@implementation ECMainTabController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIViewController *callRecordController = [[UINavigationController alloc] initWithRootViewController:[[CallRecordHistoryListTabContentViewController alloc] init] andBarTintColor:NAVIGATIONBAR_TINTCOLOR];
        UIViewController *dialTabController = [[DialTabContentViewController alloc] init];
        UIViewController *contactListController = [[UINavigationController alloc] initWithRootViewController:[[ContactListTabContentViewController alloc] init] andBarTintColor:NAVIGATIONBAR_TINTCOLOR];
        UINavigationController *settingController = [[UINavigationController alloc] initWithRootViewController:[[ECSettingViewController alloc] init] andBarTintColor:NAVIGATIONBAR_TINTCOLOR];
        
        [settingController.tabBarItem initWithTabBarSystemItem:UITabBarSystemItemMore tag:3];

        self.viewControllers = [NSArray arrayWithObjects:callRecordController, dialTabController, contactListController, settingController, nil];
        self.selectedViewController = dialTabController;
        
        
        
        [self registerSipAccount];
        
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

- (void)registerSipAccount {
    UserBean *user = [[UserManager shareUserManager] userBean];
    SipRegistrationBean *sipBean = [[SipRegistrationBean alloc] init];
    sipBean.userName = user.vosphone;
    sipBean.password = user.vosphonePwd;
    sipBean.port = SIP_PORT;
    sipBean.realm = SIP_REALM;
    sipBean.serverAddr = SIP_SERVER;
    
    [SipUtils registerSipAccount:sipBean stateChangedProtocolImpl:nil];
}

@end
