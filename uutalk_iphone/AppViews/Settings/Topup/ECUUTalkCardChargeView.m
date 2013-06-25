//
//  ECUUTalkCardChargeView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECUUTalkCardChargeView.h"
#import "ECConstants.h"

#define INPUT_WIDTH     290
#define INPUT_HEIGHT    30

@interface ECUUTalkCardChargeView () {
    UITextField *_cardNumberInput;
    UITextField *_cardPasswordInput;
}

@end

@implementation ECUUTalkCardChargeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        
        self.title = NSLocalizedString(@"UU-Talk Card", "");
        self.backgroundColor = [UIColor whiteColor];
        
        
        _cardNumberInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"please input card number", "") frame:CGRectMake((self.frame.size.width - INPUT_WIDTH) / 2, 40, INPUT_WIDTH, INPUT_HEIGHT) keyboardType:UIKeyboardTypeNumberPad];
        [self addSubview:_cardNumberInput];
        
        _cardPasswordInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"please input card password", "") frame:CGRectMake(_cardNumberInput.frame.origin.x, _cardNumberInput.frame.origin.y + _cardNumberInput.frame.size.height + 5, _cardNumberInput.frame.size.width, _cardNumberInput.frame.size.height) keyboardType:UIKeyboardTypeDefault];
        _cardPasswordInput.secureTextEntry = YES;
        [self addSubview:_cardPasswordInput];
        
        UIButton *topupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topupButton.frame = CGRectMake(_cardPasswordInput.frame.origin.x, _cardPasswordInput.frame.origin.y + _cardPasswordInput.frame.size.height + 10, _cardPasswordInput.frame.size.width, _cardPasswordInput.frame.size.height);
        [topupButton setTitle:NSLocalizedString(@"Top Up", "") forState:UIControlStateNormal];
        [topupButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateNormal];
        [topupButton setBackgroundImage:[[UIImage imageNamed:@"btn_dark_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateHighlighted];
        [topupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        topupButton.titleLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        [topupButton addTarget:self action:@selector(clickTopup) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topupButton];
    }
    return self;
}


- (void)clickTopup {
    [_cardNumberInput resignFirstResponder];
    [_cardPasswordInput resignFirstResponder];
    
    NSString *cardNumber = [_cardNumberInput.text trimWhitespaceAndNewline];
    NSString *cardPassword = [_cardPasswordInput.text trimWhitespaceAndNewline];
    
    if (!cardNumber || [cardNumber isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"please input card number", "")] setDuration:iToastDurationNormal] show];
        return;
    }
   
    if (!cardPassword || [cardPassword isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"please input card password", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(doCardChargeCardInfo:)]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithSuperView:self];
        hud.labelText = NSLocalizedString(@"charging_now", "");
        NSDictionary *cardInfo = [NSDictionary dictionaryWithObjectsAndKeys:cardNumber, @"cardNumber", cardPassword, @"cardPassword", nil];
        [hud showWhileExecuting:@selector(doCardChargeCardInfo:) onTarget:self.viewControllerRef withObject:cardInfo animated:YES];
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
