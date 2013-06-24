//
//  ECModifyPasswordViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECModifyPasswordViewController.h"
#import "ECModifyPasswordView.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECUrlConfig.h"

@interface ECModifyPasswordViewController () {
    NSString *_currentNewPwd;
}


@end

@implementation ECModifyPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECModifyPasswordView alloc] init]];
    }
    return self;
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


- (void)modifyPassword:(NSArray *)pwds {
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSString *oldPwd = [pwds objectAtIndex:0];
    NSString *newPwd = [pwds objectAtIndex:1];
    NSString *confirmPwd = [pwds objectAtIndex:2];
    _currentNewPwd = newPwd;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.countryCode, COUNTRYCODE, [oldPwd md5], @"oldPwd", newPwd, @"newPwd", confirmPwd, @"newPwdConfirm", nil];
    [HttpUtils postSignatureRequestWithUrl:MODIFY_PWD_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedModifyPwd:) andFailedRespSelector:nil];
}

- (void)onFinishedModifyPwd:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedModifyPwd - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSString *userkey = [jsonData objectForKey:USERKEY];
                UserBean *user = [[UserManager shareUserManager] userBean];
                [user setPassword:[_currentNewPwd md5]];
                [user setUserKey:userkey];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:user.userKey forKey:USERKEY];
                if (user.autoLogin) {
                    [userDefaults setObject:user.password forKey:PASSWORD];
                }
                
                RIButtonItem *okItem = [RIButtonItem item];
                okItem.label = NSLocalizedString(@"OK", "");
                okItem.action = ^{[self.navigationController popViewControllerAnimated:YES];};
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UU-Talk Alert", "") message:NSLocalizedString(@"Password is changed!", "") cancelButtonItem:okItem otherButtonItems:nil, nil] show];
            }
        }
            break;
        case 401:
            [[[iToast makeText:NSLocalizedString(@"auth_not_pass", "")] setDuration:iToastDurationNormal] show];
            break;
        case 400:
            [[[iToast makeText:NSLocalizedString(@"new_psw_error", "")] setDuration:iToastDurationNormal] show];
            break;
        default:
            [[[iToast makeText:NSLocalizedString(@"server_error", "")] setDuration:iToastDurationNormal] show];
            break;
        
       
    }
}
@end
