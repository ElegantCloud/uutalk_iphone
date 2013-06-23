//
//  ECFindPasswordViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECFindPasswordViewController.h"
#import "ECFindPasswordView.h"
#import "ECConstants.h"
#import "ECUrlConfig.h"
#import "ECConfig.h"

@interface ECFindPasswordViewController ()

@end

@implementation ECFindPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECFindPasswordView alloc] init]];
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

- (void)setFromSetting:(BOOL)flag {
    ECFindPasswordView *view = (ECFindPasswordView *)self.view;
    view.fromSetting = flag;
}

- (void)findPasswordWithNumber:(NSString *)number {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:number, USERNAME, DEFAULT_COUNTRY_CODE, COUNTRYCODE, nil];
    [HttpUtil postRequestWithUrl:GET_PWD_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:synchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedFindPassword:) andFailedRespSelector:nil];
    
}

- (void)onFinishedFindPassword:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedFindPassword - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200:
        case 201: {
            RIButtonItem *okItem = [RIButtonItem item];
            okItem.label = NSLocalizedString(@"OK", "");
            okItem.action = ^{
                ECFindPasswordView *view = (ECFindPasswordView*)self.view;
                [view onBackAction];
            };
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"UU-Talk Alert", "") message:NSLocalizedString(@"Find Password Successfully, login in login page", "") cancelButtonItem:okItem otherButtonItems:nil, nil] show];
        }
            break;
        default:
            [[[iToast makeText:NSLocalizedString(@"phone_number_not_exist", "")] setDuration:iToastDurationNormal] show];
            break;
    }
}


@end
