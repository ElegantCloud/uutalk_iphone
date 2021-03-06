//
//  ECBaseUIView.m
//  imeeting_iphone
//
//  Created by star king on 12-6-8.
//  Copyright (c) 2012年 elegant cloud. All rights reserved.
//

#import "ECBaseUIView.h"
#import "ECConstants.h"

@implementation ECBaseUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(screenBounds.origin.x, screenBounds.origin.y, screenBounds.size.width, screenBounds.size.height);
        // set background color
        self.backgroundColor = [UIColor whiteColor];
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 38)];
        _titleView.font = [UIFont fontWithName:CHINESE_BOLD_FONT size:20];
        _titleView.textAlignment = UITextAlignmentCenter;
        _titleView.textColor = [UIColor whiteColor];
        _titleView.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (UITextField*)makeTextFieldWithPlaceholder:(NSString *)placeholder frame:(CGRect)frame keyboardType:(UIKeyboardType)keyboardType {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textColor = [UIColor blackColor];
    // set style
    textField.borderStyle = UITextBorderStyleRoundedRect;
    // auto correction
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    // default display text
    textField.placeholder = placeholder;
    // set font
    textField.font = [UIFont systemFontOfSize:14.0];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // set keyboard done button
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // keyboard type
    textField.keyboardType = keyboardType;
    // set delegate
    textField.delegate = self;
    return textField;
}

- (UIButton*)makeButtonWithTitle:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (UILabel*)makeLabel:(NSString *)text frame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor colorWithIntegerRed:79 integerGreen:79 integerBlue:79 alpha:1];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (UIBarButtonItem *)makeBarButtonItem:(NSString *)title backgroundImg:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = frame;
    barButton.titleLabel.font = [UIFont fontWithName:CHINESE_BOLD_FONT size:13];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setBackgroundImage:image forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView: barButton];
}

#pragma mark - UITextFieldDelegate methods implementation
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)onBackAction {
    if (self.viewControllerRef) {
        [self.viewControllerRef.navigationController popViewControllerAnimated:YES];
    }
}

@end
