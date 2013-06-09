//
//  ECDialContentViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECDialContentViewController.h"
#import "ECDialView.h"
#import "ECSipServiceManager.h"
@interface ECDialContentViewController ()

@end

@implementation ECDialContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECDialView alloc] init]];
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

- (void)dial:(NSString *)number {
    [[ECSipServiceManager shareSipServiceManager] makeCall:number];
}
@end
