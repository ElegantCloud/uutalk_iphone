//
//  ECCallbackNumberSetView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECCallbackNumberSetView.h"
#import "ECConstants.h"

#define PAD         8
#define WIDTH       300

@interface ECCallbackNumberSetView () {
    UITextField *_callbackNumberInput;
}

@end

@implementation ECCallbackNumberSetView
@synthesize callbackNumberInput = _callbackNumberInput;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        self.title = NSLocalizedString(@"Callback Number Setting", "");
        self.backgroundColor = [UIColor whiteColor];
                
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - WIDTH) / 2, 0, WIDTH, 50)];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textColor = [UIColor redColor];
        infoLabel.text = NSLocalizedString(@"bind_number_inform", "");
        infoLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        infoLabel.numberOfLines = 0;
        infoLabel.font = [UIFont fontWithName:CHINESE_FONT size:15];
        
        [self addSubview:infoLabel];
        
        UILabel *callNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoLabel.frame.origin.x, infoLabel.frame.origin.y + infoLabel.frame.size.height + 5, WIDTH, 30)];
        callNumberLabel.text = NSLocalizedString(@"Callback Number:", "");
        callNumberLabel.textColor = [UIColor blackColor];
        callNumberLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        callNumberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:callNumberLabel];
        
        _callbackNumberInput = [self makeTextFieldWithPlaceholder:NSLocalizedString(@"Please input callback number", "") frame:CGRectMake(callNumberLabel.frame.origin.x, callNumberLabel.frame.origin.y + callNumberLabel.frame.size.height, WIDTH, 35) keyboardType:UIKeyboardTypeNumberPad];
        [self addSubview:_callbackNumberInput];
        
        UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        setButton.frame = CGRectMake(_callbackNumberInput.frame.origin.x, _callbackNumberInput.frame.origin.y + _callbackNumberInput.frame.size.height + 15, WIDTH, 35);
        [setButton setTitle:NSLocalizedString(@"Set", "") forState:UIControlStateNormal];
        [setButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateNormal];
        [setButton setBackgroundImage:[[UIImage imageNamed:@"btn_dark_green"] stretchableImageWithLeftCapWidth:9 topCapHeight:9] forState:UIControlStateHighlighted];
        [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [setButton.titleLabel setFont:[UIFont fontWithName:CHINESE_FONT size:16]];
        [setButton addTarget:self action:@selector(clickSetButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setButton];
    }
    return self;
}


- (void)clickSetButton {
    [_callbackNumberInput resignFirstResponder];
    NSString *number = [_callbackNumberInput.text trimWhitespaceAndNewline];
    if (!number || [number isEqualToString:@""]) {
        [[[iToast makeText:NSLocalizedString(@"Please input callback number", "")] setDuration:iToastDurationNormal] show];
        return;
    }
    
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(setCallbackNumber:)]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithSuperView:self];
        hud.labelText = NSLocalizedString(@"Setting callback number…", "");
        [hud showWhileExecuting:@selector(setCallbackNumber:) onTarget:self.viewControllerRef withObject:number animated:YES];
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
