//
//  ECModifyPasswordView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECModifyPasswordView.h"
#import "ECConstants.h"

#define PAD             5
#define INPUT_WIDTH     300
#define INPUT_HEIGHT    30

@interface ECModifyPasswordView () {
    UITextField *_oldPwdInput;
    UITextField *_newPwdInput;
    UITextField *_confirmPwdInput;
}

@end

@implementation ECModifyPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        _titleView.text = NSLocalizedString(@"Password Reset", "");
        self.titleView = _titleView;
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"more", "") style:UIBarButtonItemStyleDone target:self action:@selector(onBackAction)];
        
        _oldPwdInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"Please input old password", "") frame:CGRectMake((self.frame.size.width - INPUT_WIDTH) / 2, PAD, INPUT_WIDTH, INPUT_HEIGHT) keyboardType:UIKeyboardTypeDefault];
        _oldPwdInput.secureTextEntry = YES;
        [self addSubview:_oldPwdInput];
        
        _newPwdInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"Please input new password", "") frame:CGRectMake(_oldPwdInput.frame.origin.x, _oldPwdInput.frame.origin.y + _oldPwdInput.frame.size.height + PAD, INPUT_WIDTH, INPUT_HEIGHT) keyboardType:UIKeyboardTypeDefault];
        _newPwdInput.secureTextEntry = YES;
        [self addSubview:_newPwdInput];
        
        _confirmPwdInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"Please input confirmation password", "") frame:CGRectMake(_oldPwdInput.frame.origin.x, _newPwdInput.frame.origin.y + _newPwdInput.frame.size.height + PAD, INPUT_WIDTH, INPUT_HEIGHT) keyboardType:UIKeyboardTypeDefault];
        _confirmPwdInput.secureTextEntry = YES;
        [self addSubview:_confirmPwdInput];
        
        UIButton *modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        modifyButton.frame = CGRectMake(_confirmPwdInput.frame.origin.x, _confirmPwdInput.frame.size.height + _confirmPwdInput.frame.origin.y + PAD * 2, INPUT_WIDTH, INPUT_HEIGHT);
        [modifyButton setTitle:NSLocalizedString(@"Modify", "") forState:UIControlStateNormal];
        [modifyButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateNormal];
        [modifyButton setBackgroundImage:[[UIImage imageNamed:@"btn_dark_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateHighlighted];
        [modifyButton.titleLabel setFont:[UIFont fontWithName:CHINESE_FONT size:16]];
        [modifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [modifyButton addTarget:self action:@selector(clickModify) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:modifyButton];
        
    }
    return self;
}

- (void)clickModify {
    [_oldPwdInput resignFirstResponder];
    [_newPwdInput resignFirstResponder];
    [_confirmPwdInput resignFirstResponder];
    
    NSString *oldPwd = [_oldPwdInput.text trimWhitespaceAndNewline];
    NSString *newPwd = [_newPwdInput.text trimWhitespaceAndNewline];
    NSString *confirmPwd = [_confirmPwdInput.text trimWhitespaceAndNewline];
    
    if (!oldPwd || [oldPwd isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"Please input old password", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    if (!newPwd || [newPwd isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"Please input new password", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    if (!confirmPwd || [confirmPwd isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"Please input confirmation password", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    if (![confirmPwd isEqualToString:newPwd]) {
        [[[iToast makeText:NSLocalizedString(@"Confirmation Password is different with new password", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    NSArray *params = [NSArray arrayWithObjects:oldPwd, newPwd, confirmPwd, nil];
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(modifyPassword:)]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithSuperView:self];
        hud.labelText = NSLocalizedString(@"Processing", "");
        [hud showWhileExecuting:@selector(modifyPassword:) onTarget:self.viewControllerRef withObject:params animated:YES];
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
