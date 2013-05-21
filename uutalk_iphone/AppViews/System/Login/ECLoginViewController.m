//
//  ECLoginViewController.m
//  uutalk_iphone
//
//  Created by king star on 13-5-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECLoginViewController.h"
#import "ECLoginView.h"

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
