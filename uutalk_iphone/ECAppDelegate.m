//
//  ECAppDelegate.m
//  uutalk_iphone
//
//  Created by king star on 13-5-20.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECAppDelegate.h"
#import "CommonToolkit/CommonToolkit.h"
#import "ECLoginViewController.h"
#import "ECConstants.h"
#import "UserBean+UUTalk.h"
#import "ECConfig.h"
#import "ECMainTabController.h"
#import "ECSipServiceManager.h"

@implementation ECAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL result = [[ECSipServiceManager shareSipServiceManager] initSipEngine];
    
    if (result == NO) {
        // sip engine init failed, alert and exit
        RIButtonItem *cancelItem = [RIButtonItem item];
        cancelItem.label = NSLocalizedString(@"Exit", "");
        cancelItem.action = ^{exit(0);};
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UU-Talk Alert", "") message:NSLocalizedString(@"Fail to init phone engine, need exit.", "") cancelButtonItem:cancelItem otherButtonItems:nil, nil] show];
        return NO;
    }
    
    [self loadAccount];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    BOOL needLogin = [self isNeedLogin];
    if (needLogin) {
        self.window.rootViewController = [[AppRootViewController alloc] initWithPresentViewController:[[ECLoginViewController alloc] init] andMode:navigationController];
    } else {
        self.window.rootViewController = [[AppRootViewController alloc] initWithPresentViewController:[[ECMainTabController alloc] init] andMode:normalController];
    }
        
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - account operations

- (void)loadAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:USERNAME];
    NSString *password = [userDefaults objectForKey:PASSWORD];
    NSString *userkey = [userDefaults objectForKey:USERKEY];
    NSString *countryCode = [userDefaults objectForKey:COUNTRYCODE];
    NSString *dialCountryCode = [userDefaults objectForKey:DEFAULT_DIAL_COUNTRY_CODE];
    NSString *vosphone = [userDefaults objectForKey:VOSPHONE];
    NSString *vosphonePwd = [userDefaults objectForKey:VOSPHONE_PWD];
    NSString *callbackPhoneNumber = [userDefaults objectForKey:CALLBACK_PHONE_NUMBER];
    NSString *callbackPhoneNumberCountryCode = [userDefaults objectForKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
    
    UserBean *userBean = [[UserManager shareUserManager] userBean];
    userBean.name = username;
    userBean.password = password;
    if (password) {
        userBean.autoLogin = YES;
    } else {
        userBean.autoLogin = NO;
    }
    userBean.userKey = userkey;
    userBean.countryCode = countryCode;
    if (!dialCountryCode || [dialCountryCode isEqualToString:@""]) {
        userBean.defaultDialCountryCode = DEFAULT_COUNTRY_CODE;
    } else {
        userBean.defaultDialCountryCode = dialCountryCode;
    }
    userBean.vosphone = vosphone;
    userBean.vosphonePwd = vosphonePwd;
    userBean.callbackPhoneNumber = callbackPhoneNumber;
    userBean.callbackPhoneNumberCountryCode = callbackPhoneNumberCountryCode;
    
    NSLog(@"load account: %@", userBean.description);
}

- (BOOL)isNeedLogin {
    BOOL flag = NO;
    UserBean *userBean = [[UserManager shareUserManager] userBean];
    if (!userBean.name || !userBean.password || !userBean.userKey) {
        flag = YES;
    }
    
    return flag;
}



@end
