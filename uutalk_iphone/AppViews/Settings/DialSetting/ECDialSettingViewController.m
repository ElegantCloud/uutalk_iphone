//
//  ECDialSettingViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-6-24.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECDialSettingViewController.h"
#import "ECDialSettingView.h"

@interface ECDialSettingViewController ()

@end

@implementation ECDialSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [self initWithCompatibleView:[[ECDialSettingView alloc] init]];
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

@end
