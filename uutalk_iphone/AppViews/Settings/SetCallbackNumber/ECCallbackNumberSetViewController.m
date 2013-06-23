//
//  ECCallbackNumberSetViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECCallbackNumberSetViewController.h"
#import "ECCallbackNumberSetView.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECConfig.h"
#import "ECUrlConfig.h"

@interface ECCallbackNumberSetViewController () {
    NSString *_currentCallbackNumber;
    NSString *_currentCallbackNumberCountryCode;
}

@end

@implementation ECCallbackNumberSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECCallbackNumberSetView alloc] init]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithSuperView:self.view];
    hud.labelText = NSLocalizedString(@"Getting callback number", "");
    [hud showWhileExecuting:@selector(loadCallbackNumber) onTarget:self withObject:nil animated:YES];
}

- (void)loadCallbackNumber {
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.countryCode, COUNTRYCODE, nil];
    [HttpUtil postSignatureRequestWithUrl:GET_CALLBACK_NUMBER_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedGetCallbackNumber:) andFailedRespSelector:nil];
}

- (void)onFinishedGetCallbackNumber:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedGetCallbackNumber - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSString *phone = [jsonData objectForKey:CALLBACK_PHONE_NUMBER];
                
                ECCallbackNumberSetView *view = (ECCallbackNumberSetView *)self.view;
                [view.callbackNumberInput setText:phone];
            }
        }
            break;
        default: {
            [[[iToast makeText:NSLocalizedString(@"Get callback failed", "")] setDuration:iToastDurationNormal] show];
        }
            break;
    }

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

- (void)setCallbackNumber:(NSString *)number {
    _currentCallbackNumber = number;
    _currentCallbackNumberCountryCode = DEFAULT_COUNTRY_CODE;
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.countryCode, COUNTRYCODE, number, @"bindphone", DEFAULT_COUNTRY_CODE, @"bindphone_country_code", nil];
    [HttpUtil postSignatureRequestWithUrl:SET_CALLBACK_NUMBER_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedSetCallbackNumber:) andFailedRespSelector:nil];
    
}

- (void)onFinishedSetCallbackNumber:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedSetCallbackNumber - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            UserBean *user = [[UserManager shareUserManager] userBean];
            user.callbackPhoneNumber = _currentCallbackNumber;
            user.callbackPhoneNumberCountryCode = _currentCallbackNumberCountryCode;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:user.callbackPhoneNumber forKey:CALLBACK_PHONE_NUMBER];
            [userDefaults setObject:user.callbackPhoneNumberCountryCode forKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
            [[[iToast makeText:NSLocalizedString(@"Callback number set successfully", "")] setDuration:iToastDurationNormal] show];
            
        }
            break;
        default: {
            [[[iToast makeText:NSLocalizedString(@"server_error", "")] setDuration:iToastDurationNormal] show];
        }
            break;
    }

}
@end
