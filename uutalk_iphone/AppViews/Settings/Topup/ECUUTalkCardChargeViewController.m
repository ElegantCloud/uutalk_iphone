//
//  ECUUTalkCardChargeViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECUUTalkCardChargeViewController.h"
#import "ECUUTalkCardChargeView.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECUrlConfig.h"

@interface ECUUTalkCardChargeViewController ()

@end

@implementation ECUUTalkCardChargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECUUTalkCardChargeView alloc] init]];
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

- (void)doCardChargeCardInfo:(NSDictionary *)cardInfo {
    NSString *cardNumber = [cardInfo objectForKey:@"cardNumber"];
    NSString *cardPassword = [cardInfo objectForKey:@"cardPassword"];
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:cardNumber, @"pin", cardPassword, @"password", user.countryCode, COUNTRYCODE, nil];
    [HttpUtil postSignatureRequestWithUrl:CARD_CHARGE_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:asynchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedTopup:) andFailedRespSelector:nil];
    
    
}

- (void)onFinishedTopup:(ASIHTTPRequest *) pRequest {
    NSLog(@"onFinishedTopup - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            RIButtonItem *okItem = [RIButtonItem item];
            okItem.label = NSLocalizedString(@"OK", "");
            okItem.action = ^{[self.navigationController popViewControllerAnimated:YES];};
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UU-Talk Alert", "") message:NSLocalizedString(@"Top up successfully", "") cancelButtonItem:okItem otherButtonItems:nil, nil] show];
            
        }
            
            break;
        case 404:
            [[[iToast makeText:NSLocalizedString(@"charge_failed_no_account_exist", "")] setDuration:iToastDurationNormal] show];
            break;
        case 400:
            [[[iToast makeText:NSLocalizedString(@"charge_failed_invalid_card_number", "")] setDuration:iToastDurationNormal] show];
            break;
        case 409:
            [[[iToast makeText:NSLocalizedString(@"card_already_used", "")] setDuration:iToastDurationNormal] show];
            break;
        default:
            [[[iToast makeText:NSLocalizedString(@"charge_failed", "")] setDuration:iToastDurationNormal] show];
            break;
    }
}
@end
