//
//  ECLoginViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECLoginViewController.h"
#import "ECLoginView.h"
#import "ECUrlConfig.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECMainTabController.h"
#import "ECRegisterViewController.h"
@interface ECLoginViewController ()

@end

@implementation ECLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self = [self initWithCompatibleView:[[ECLoginView alloc] init]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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

- (void)login {
    NSLog(@"do login");
    UserBean *userBean = [[UserManager shareUserManager] userBean];
    
    // validate user account
    NSString *pwd = userBean.password;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userBean.name, @"loginName", pwd, @"loginPwd", userBean.countryCode, COUNTRYCODE, nil];
    
    // send request
    [HttpUtil postRequestWithUrl:USER_LOGIN_URL andPostFormat:urlEncoded andParameter:param andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedLogin:) andFailedRespSelector:nil];

}

- (void)onFinishedLogin:(ASIHTTPRequest*)pRequest {
    NSLog(@"onFinishedLogin - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSString *result = [jsonData objectForKey:@"result"];
                NSLog(@"result: %@", result);
                
                if([result isEqualToString:@"0"]) {
                    // login successfully
                    NSString *userkey = [jsonData objectForKey:USERKEY];
                    NSLog(@"userkey: %@", userkey);
                    NSString *vosphone = [jsonData objectForKey:VOSPHONE];
                    NSString *vosphonePwd = [jsonData objectForKey:VOSPHONE_PWD];
                    NSString *bindPhone = [jsonData objectForKey:CALLBACK_PHONE_NUMBER];
                    NSString *bindPhoneCountryCode = [jsonData objectForKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
                    
                    
                    // save the account info
                    UserBean *userBean = [[UserManager shareUserManager] userBean];
                    userBean.userKey = userkey;
                    userBean.vosphone = vosphone;
                    userBean.vosphonePwd = vosphonePwd;
                    userBean.callbackPhoneNumber = bindPhone;
                    userBean.callbackPhoneNumberCountryCode = bindPhoneCountryCode;
                    
                    NSLog(@"userbean: %@", userBean.description);
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:userBean.name forKey:USERNAME];
                    if (userBean.autoLogin) {
                        [userDefaults setObject:userBean.password forKey:PASSWORD];
                    } else {
                        [userDefaults removeObjectForKey:PASSWORD];
                    }
                    
                    [userDefaults setObject:userBean.userKey forKey:USERKEY];
                    [userDefaults setObject:userBean.countryCode forKey:COUNTRYCODE];
                    [userDefaults setObject:userBean.vosphone forKey:VOSPHONE];
                    [userDefaults setObject:userBean.vosphonePwd forKey:VOSPHONE_PWD];
                    [userDefaults setObject:userBean.callbackPhoneNumber forKey:CALLBACK_PHONE_NUMBER];
                    [userDefaults setObject:userBean.callbackPhoneNumberCountryCode forKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];

                    // jump to main view
                    [self.navigationController pushViewController:[[ECMainTabController alloc] init] animated:YES];
                } else if ([result isEqualToString:@"1"] || [result isEqualToString:@"2"]) {
                    // login failed
                    [[[iToast makeText:NSLocalizedString(@"Wrong phone number or password", "")] setDuration:iToastDurationLong] show];
                } else {
                    goto login_error;
                }
            } else {
                goto login_error;
            }
            break;
        }
        default:
            goto login_error;
            break;
    }
    
    return;
    
login_error:
    [[[iToast makeText:NSLocalizedString(@"Error in login, please retry.", "")] setDuration:iToastDurationLong] show];
    
}

- (void)jumpToRegisterView {
    ECRegisterViewController *regController = [[ECRegisterViewController alloc] init];
    
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
    [self.navigationController pushViewController:regController animated:NO];
    [UIView commitAnimations];
  }
@end
