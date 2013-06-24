//
//  ECBalanceQueryViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECBalanceQueryViewController.h"
#import "ECBalanceQueryView.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECUrlConfig.h"

@interface ECBalanceQueryViewController ()

@end

@implementation ECBalanceQueryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECBalanceQueryView alloc] init]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadBalance];
}

- (void)loadBalance {
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.countryCode, COUNTRYCODE, nil];
    [HttpUtils postSignatureRequestWithUrl:BALANCE_QUERY_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:asynchronous andProcessor:self andFinishedRespSelector:@selector(onFinishedLoadBalance:) andFailedRespSelector:@selector(onFailToLoadBalance:)];
}

- (void)onFinishedLoadBalance:(ASIHTTPRequest *)pRequest {
    NSLog(@"onFinishedLoadBalance - request url = %@, responseStatusCode = %d, responseStatusMsg = %@", pRequest.url, [pRequest responseStatusCode], [pRequest responseStatusMessage]);
    
    int statusCode = pRequest.responseStatusCode;
    
    switch (statusCode) {
        case 200: {
            NSDictionary *jsonData = [[[NSString alloc] initWithData:pRequest.responseData encoding:NSUTF8StringEncoding] objectFromJSONString];
            if (jsonData) {
                NSNumber *balance = [jsonData objectForKey:@"balance"];
                NSString *balanceStr = [NSString stringWithFormat:@"%.2f %@", balance.doubleValue, NSLocalizedString(@"yuan", "")];
                
                ECBalanceQueryView *view = (ECBalanceQueryView*)self.view;
                [view.valueArray setObject:balanceStr atIndexedSubscript:2];
                [view.tableView reloadData];
            } else {
                ECBalanceQueryView *view = (ECBalanceQueryView*)self.view;
                [view.valueArray setObject:NSLocalizedString(@"Fail to query", "") atIndexedSubscript:2];
                [view.tableView reloadData];
            }
        }
            break;
        default: {
            ECBalanceQueryView *view = (ECBalanceQueryView*)self.view;
            [view.valueArray setObject:NSLocalizedString(@"Fail to query", "") atIndexedSubscript:2];
            [view.tableView reloadData];
        }
            break;
    }
}

- (void)onFailToLoadBalance:(ASIHTTPRequest *)pRequest {
    ECBalanceQueryView *view = (ECBalanceQueryView*)self.view;
    [view.valueArray setObject:NSLocalizedString(@"Fail to query", "") atIndexedSubscript:2];
    [view.tableView reloadData];
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

@end
