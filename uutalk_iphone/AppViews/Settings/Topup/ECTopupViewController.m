//
//  ECTopupViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECTopupViewController.h"
#import "ECTopupView.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECUrlConfig.h"
#import "ECUUTalkCardChargeViewController.h"

@interface ECTopupViewController ()

@end

@implementation ECTopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECTopupView alloc] init]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getBalance];
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

- (void)getBalance {
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.countryCode, COUNTRYCODE, nil];
    [HttpUtils postSignatureRequestWithUrl:BALANCE_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:asynchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedGetBalance:) andFailedRespSelector:@selector(onNetworkFailed:)];
}

- (void)onFinishedGetBalance:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedGetBalance - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSNumber *balance = [jsonData objectForKey:@"balance"];
                NSString *balanceStr = [NSString stringWithFormat:@"%.2f %@", balance.doubleValue, NSLocalizedString(@"yuan", "")];
                
                ECTopupView *topupView = (ECTopupView*)self.view;
                topupView.balanceLabel.text = balanceStr;
            }
            
        }
            
            break;
            
        default:
            
            break;
    }

}

- (void)onNetworkFailed:(ASIHTTPRequest *)pRequest {
}

- (void)jumpToUUTalkCardCharge {
    ECUUTalkCardChargeViewController *viewController = [[ECUUTalkCardChargeViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
