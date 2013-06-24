//
//  ECFindPasswordView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECFindPasswordView.h"
#import "ECConstants.h"


#define FORM_WIDTH    270
#define FORM_HEIGHT   150
#define INPUT_FIELD_WIDTH   250
#define INPUT_FIELD_HEIGHT  35
#define BUTTON_WIDTH  250
#define BUTTON_HEIGHT 35

@interface ECFindPasswordView () {
    UITextField *_mobileNumberInput;
}

@end

@implementation ECFindPasswordView
@synthesize fromSetting = _fromSetting;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        _titleView.text = NSLocalizedString(@"Find Password", "");
        self.titleView = _titleView;
        self.backgroundImg = [UIImage imageNamed:@"bg"];
               
        UIView *formView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - FORM_WIDTH) / 2, 30, FORM_WIDTH, FORM_HEIGHT)];
        formView.backgroundColor = [UIColor colorWithIntegerRed:0x87 integerGreen:0xce integerBlue:0xff alpha:0.5];
        [formView.layer setCornerRadius:6];
        [self addSubview:formView];
        
        _mobileNumberInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"input phone number", "") frame:CGRectMake((formView.frame.size.width - INPUT_FIELD_WIDTH) / 2, 30, INPUT_FIELD_WIDTH, INPUT_FIELD_HEIGHT) keyboardType:UIKeyboardTypeNumberPad];
        [formView addSubview:_mobileNumberInput];
        
        UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
        findButton.frame = CGRectMake(_mobileNumberInput.frame.origin.x, _mobileNumberInput.frame.origin.y + _mobileNumberInput.frame.size.height + 10, BUTTON_WIDTH, BUTTON_HEIGHT);
        [findButton setTitle:NSLocalizedString(@"Find Password", "") forState:UIControlStateNormal];
        [findButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [findButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateNormal];
        [findButton setBackgroundImage:[[UIImage imageNamed:@"btn_dark_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateHighlighted];
        [findButton.titleLabel setFont:[UIFont fontWithName:CHINESE_FONT size:16]];
        [findButton addTarget:self action:@selector(clickFindPassword) forControlEvents:UIControlEventTouchUpInside];
        [formView addSubview:findButton];
        
        [_mobileNumberInput becomeFirstResponder];
    }
    return self;
}

- (void)setFromSetting:(BOOL)fromSetting {
    _fromSetting = fromSetting;
    NSString *leftBarButtonTitle = NSLocalizedString(@"login", "");
    if (fromSetting) {
        leftBarButtonTitle = NSLocalizedString(@"more", "");
    }
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:leftBarButtonTitle style:UIBarButtonItemStyleDone target:self
                                                             action:@selector(onBackAction)];
}

- (void)clickFindPassword {
    [_mobileNumberInput resignFirstResponder];
    NSString *number = [[_mobileNumberInput text] trimWhitespaceAndNewline];
    if (!number || [number isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"input phone number", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(findPasswordWithNumber:)]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithSuperView:self];
        hud.labelText = NSLocalizedString(@"Processing", "");
        [hud showWhileExecuting:@selector(findPasswordWithNumber:) onTarget:self.viewControllerRef withObject:number animated:YES];
    }
}

- (void)onBackAction {
    if (!_fromSetting) {
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.viewControllerRef.navigationController.view cache:YES];
        [self.viewControllerRef.navigationController popViewControllerAnimated:NO];
        [UIView commitAnimations];
    } else {
        [super onBackAction];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
