//
//  ECLoginView.m
//  uutalk_iphone
//
//  Created by king star on 13-5-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECLoginView.h"
#import "ECConstants.h"
#import "UserBean+UUTalk.h"
#import "ECConfig.h"

#define LOGIN_FORM_WIDTH    270
#define LOGIN_FORM_HEIGHT   300
#define INPUT_FIELD_WIDTH   250
#define INPUT_FIELD_HEIGHT  35
#define LOGIN_BUTTON_WIDTH  250
#define LOGIN_BUTTON_HEIGHT 40
#define SWITCH_WDITH        50
#define SWITCH_HEIGHT       30
#define GAP                 8
#define REG_USER_BUTTON_WIDTH   120
#define REG_USER_BUTTON_HEIGHT  28
#define FIND_PWD_BUTTON_WIDTH   100
#define PWD_MASK            @"#@1d~`*)"

@implementation ECLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         _useSavedPwd = YES;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundImg = [UIImage imageNamed:@"bg"];

    UIView *loginFormView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - LOGIN_FORM_WIDTH) / 2, 30, LOGIN_FORM_WIDTH, LOGIN_FORM_HEIGHT)];
    loginFormView.backgroundColor = [UIColor colorWithIntegerRed:0x87 integerGreen:0xce integerBlue:0xff alpha:0.5];
    [loginFormView.layer setCornerRadius:6];
        
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((loginFormView.frame.size.width - 180) / 2 , 10, 180, 40)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:CHINESE_FONT size:25];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"Welcome to use uutalk", "");
    [loginFormView addSubview:titleLabel];
    
    _userNameInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"input phone number", "") frame:CGRectMake((loginFormView.frame.size.width - INPUT_FIELD_WIDTH) / 2, titleLabel.frame.origin.y + titleLabel.frame.size.height + GAP, INPUT_FIELD_WIDTH, INPUT_FIELD_HEIGHT) keyboardType:UIKeyboardTypeNumberPad];
    [_userNameInput addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [loginFormView addSubview:_userNameInput];
    
    _pwdInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"input password", "") frame:CGRectMake(_userNameInput.frame.origin.x, _userNameInput.frame.origin.y + _userNameInput.frame.size.height + GAP, INPUT_FIELD_WIDTH, INPUT_FIELD_HEIGHT) keyboardType:UIKeyboardTypeDefault];
    _pwdInput.secureTextEntry = YES;
    [_pwdInput addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [loginFormView addSubview:_pwdInput];
    
    UILabel *autoLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(_pwdInput.frame.origin.x, _pwdInput.frame.origin.y + _pwdInput.frame.size.height + GAP, 160, SWITCH_HEIGHT)];
    autoLoginLabel.font = [UIFont fontWithName:CHINESE_FONT size:15];
    autoLoginLabel.text = NSLocalizedString(@"auto login", "");
    autoLoginLabel.backgroundColor = [UIColor clearColor];
    [loginFormView addSubview:autoLoginLabel];
    
    _autoLoginSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(autoLoginLabel.frame.origin.x + autoLoginLabel.frame.size.width + 10, autoLoginLabel.frame.origin.y, SWITCH_WDITH, SWITCH_HEIGHT)];
    _autoLoginSwitch.on = YES;
    [loginFormView addSubview:_autoLoginSwitch];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake((loginFormView.frame.size.width - LOGIN_BUTTON_WIDTH) / 2, autoLoginLabel.frame.origin.y + autoLoginLabel.frame.size.height + GAP, LOGIN_BUTTON_WIDTH, LOGIN_BUTTON_HEIGHT);
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 9, 9, 9)] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"btn_dark_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 9, 9, 9)] forState:UIControlStateHighlighted];
    [_loginButton setTitle:NSLocalizedString(@"login", "") forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [loginFormView addSubview:_loginButton];
    
    UIButton *newUserRegButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newUserRegButton.frame = CGRectMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y + _loginButton.frame.size.height + 12, REG_USER_BUTTON_WIDTH, REG_USER_BUTTON_HEIGHT);
    [newUserRegButton setBackgroundColor:[UIColor clearColor]];
    [newUserRegButton setTitle:NSLocalizedString(@"new user", "") forState:UIControlStateNormal];
    [newUserRegButton.titleLabel setFont:[UIFont fontWithName:CHINESE_FONT size:14]];
    [newUserRegButton setTitleColor:[UIColor colorWithIntegerRed:0xff integerGreen:0x45 integerBlue:0 alpha:1] forState:UIControlStateNormal];
    [newUserRegButton setTitleColor:[UIColor colorWithIntegerRed:0x48 integerGreen:0x76 integerBlue:0xff alpha:1] forState:UIControlStateHighlighted];
    [newUserRegButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [newUserRegButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [loginFormView addSubview:newUserRegButton];
    
       
    UIButton *findPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findPwdButton.frame = CGRectMake(_loginButton.frame.origin.x + _loginButton.frame.size.width - FIND_PWD_BUTTON_WIDTH, newUserRegButton.frame.origin.y, FIND_PWD_BUTTON_WIDTH, REG_USER_BUTTON_HEIGHT);
    [findPwdButton setBackgroundColor:[UIColor clearColor]];
    [findPwdButton setTitle:NSLocalizedString(@"find pwd", "") forState:UIControlStateNormal];
    [findPwdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [findPwdButton setTitleColor:[UIColor colorWithIntegerRed:0x48 integerGreen:0x76 integerBlue:0xff alpha:1] forState:UIControlStateHighlighted];
    findPwdButton.titleLabel.font = [UIFont fontWithName:CHINESE_FONT size:14];
    [findPwdButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

    [loginFormView addSubview:findPwdButton];
    
    [self addSubview:loginFormView];
    
    //##### set user info in the view
    UserBean *userBean = [[UserManager shareUserManager] userBean];
    _userNameInput.text = userBean.name;
    if (userBean.password == nil || [userBean.password isEqualToString:@""]) {
        _pwdInput.text = nil;
    } else {
        _pwdInput.text = PWD_MASK;
    }
    _autoLoginSwitch.on = userBean.autoLogin;

}

- (void)textFieldValueChanged:(UITextField*)textField {
    NSLog(@"text field value changed");
    _useSavedPwd = NO;
}

- (void)loginAction {
    NSString *phoneNumber = [_userNameInput.text trimWhitespaceAndNewline];
    NSString *pwd = [_pwdInput.text trimWhitespaceAndNewline];
    BOOL autoLogin = _autoLoginSwitch.on;
    
    [_userNameInput resignFirstResponder];
    [_pwdInput resignFirstResponder];
    
    if (!phoneNumber || [phoneNumber isEqualToString:@""]) {
        NSLog(@"phone number is null");
        [[[iToast makeText:NSLocalizedString(@"please input phone number first", "")] setDuration:iToastDurationLong] show];
        return;
    }
    
    if (!pwd || [pwd isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"please input password", "")] setDuration:iToastDurationLong] show];
        return;
        
    }
    
    UserBean *ub = [[UserManager shareUserManager] userBean];
    if (!_useSavedPwd) {        
        [[UserManager shareUserManager] setUser:phoneNumber andPassword:pwd];
        UserBean *userBean = [[UserManager shareUserManager] userBean];
        userBean.countryCode = DEFAULT_COUNTRY_CODE;
    }
    ub.autoLogin = autoLogin;
    
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(login)]) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithSuperView:self];
        [hud setLabelText:NSLocalizedString(@"Logining", "")];
        [hud showWhileExecuting:@selector(login) onTarget:self.viewControllerRef withObject:nil animated:YES];
        
    }
}

- (void)registerAction {
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(jumpToRegisterView)]) {
        [self.viewControllerRef performSelector:@selector(jumpToRegisterView)];
    }

}

@end
