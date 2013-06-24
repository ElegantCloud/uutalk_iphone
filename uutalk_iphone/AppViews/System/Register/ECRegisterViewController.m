//
//  ECRegisterViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECRegisterViewController.h"
#import "ECRegisterView.h"
#import "ECUrlConfig.h"
#import "ECConstants.h"
#import "ECConfig.h"
#import "UserBean+UUTalk.h"
#import "ECMainTabController.h"

@interface ECRegisterViewController ()

@end

@implementation ECRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECRegisterView alloc] init]];
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

#pragma mark - button action implementations for ECRegisterUIView
- (void)getValidationCodeByPhoneNumber:(NSString *)phoneNumber {
    NSLog(@"get validation code - number:%@", phoneNumber);
    
    // send request to server to get validation code
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:phoneNumber, @"phone", DEFAULT_COUNTRY_CODE, COUNTRYCODE, nil];
    
    [HttpUtils postRequestWithUrl:RETRIEVE_PHONE_CODE_URL andPostFormat:urlEncoded andParameter:param andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedGetPhoneCode:) andFailedRespSelector:nil];
}

- (void)verifyCode:(NSString *)code {
    NSLog(@"verify code");
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:code, @"code", nil];
    [HttpUtils postRequestWithUrl:CHECK_PHONE_CODE_URL andPostFormat:urlEncoded andParameter:param andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedCheckPhoneCode:) andFailedRespSelector:nil];
}

- (void)finishRegisterWithPwds:(NSArray*)pwds {
    NSLog(@"finish register");
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[pwds objectAtIndex:0], @"password", [pwds objectAtIndex:1], @"password1", CLIENT_SOURCE, @"source", nil];
    
    [HttpUtils postRequestWithUrl:USER_REGISTER_URL andPostFormat:urlEncoded andParameter:param andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedRegister:) andFailedRespSelector:nil];
}

- (void)jumpToLoginView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HTTP Request Callback Methods Implementation

- (void)onFinishedGetPhoneCode:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedGetPhoneCode - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSString *result = [jsonData objectForKey:@"result"];
                NSLog(@"result: %@", result);
                
                if([result isEqualToString:@"0"]) {
                    // get phone code successfully, jump to step 2
                    [self.view performSelector:@selector(switchToStep2View)];
                } else if ([result isEqualToString:@"2"]) {
                    [[[iToast makeText:NSLocalizedString(@"Invalid Phone Number!", "")] setDuration:iToastDurationLong] show];
                } else if ([result isEqualToString:@"3"]) {
                    [[[iToast makeText:NSLocalizedString(@"Existed Phone Number!", "")] setDuration:iToastDurationLong] show];
                } else {
                    goto get_phone_code_error;
                }
            } else {
                goto get_phone_code_error;
            }
            break;
        }
        default:
            goto get_phone_code_error;
            break;
    }
    
    return;
    
get_phone_code_error:
    [[[iToast makeText:NSLocalizedString(@"Error in retrieving validation code, please retry.", "")] setDuration:iToastDurationLong] show];
}

- (void)onFinishedCheckPhoneCode:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedCheckPhoneCode - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSString *result = [jsonData objectForKey:@"result"];
                NSLog(@"result: %@", result);
                
                if([result isEqualToString:@"0"]) {
                    // check phone code successfully, jump to step 3 to fill password
                    [self.view performSelector:@selector(switchToStep3View)];
                } else if ([result isEqualToString:@"2"]) {
                    [[[iToast makeText:NSLocalizedString(@"Wrong Validation Code!", "")] setDuration:iToastDurationLong] show];
                } else if ([result isEqualToString:@"6"]) {
                    [[[iToast makeText:NSLocalizedString(@"code check session timeout", "")] setDuration:iToastDurationLong] show];
                    [self.view performSelector:@selector(switchToStep1View)];
                    
                }
            } else {
                goto check_phone_code_error;
            }
            break;
        }
        default:
            goto check_phone_code_error;
            break;
    }
    
    return;
    
check_phone_code_error:
    [[[iToast makeText:NSLocalizedString(@"Error in checking validation code, please retry.", "")] setDuration:iToastDurationLong] show];
}

- (void)onFinishedRegister:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedRegister - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSString *result = [jsonData objectForKey:@"result"];
                NSLog(@"result: %@", result);
                
                if([result isEqualToString:@"0"]) {
                    NSString *userkey = [jsonData objectForKey:USERKEY];
                    NSLog(@"userkey: %@", userkey);
                    NSString *vosphone = [jsonData objectForKey:VOSPHONE];
                    NSString *vosphonePwd = [jsonData objectForKey:VOSPHONE_PWD];
                    NSString *bindPhone = [jsonData objectForKey:CALLBACK_PHONE_NUMBER];
                    NSString *bindPhoneCountryCode = [jsonData objectForKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
                    
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

                 
                    
                } else if ([result isEqualToString:@"6"]) {
                    [[[iToast makeText:NSLocalizedString(@"register session timeout", "")] setDuration:iToastDurationLong] show];
                    [self.view performSelector:@selector(switchToStep1View)];
                } else {
                    goto finish_register_error;
                }
            } else {
                goto finish_register_error;
            }
            break;
        }
        default:
            goto finish_register_error;
            break;
    }
    
    return;
    
finish_register_error:
    [[[iToast makeText:NSLocalizedString(@"Error in finishing register, please retry.", "")] setDuration:iToastDurationLong] show];
    
}

@end
