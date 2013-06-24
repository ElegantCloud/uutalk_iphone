//
//  ECDialView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-9.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECDialView.h"

@interface ECDialView () {
    UITextField *_numberInput;
    UIButton *_dialButton;
    UIButton *_hangupButton;
}

@end

@implementation ECDialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(screenBounds.origin.x, screenBounds.origin.y, screenBounds.size.width, screenBounds.size.height - ([DisplayScreenUtils statusBarHeight] + [DisplayScreenUtils navigationBarHeight]) - 50);
        
        _numberInput = [self makeTextFieldWithPlaceholder:@"Input Number" frame:CGRectMake(0, 10, self.frame.size.width, 30) keyboardType:UIKeyboardTypePhonePad];
        _dialButton = [self makeButtonWithTitle:@"Dial" frame:CGRectMake(0, _numberInput.frame.origin.y + _numberInput.frame.size.height + 5, self.frame.size.width, 30)];
        [_dialButton addTarget:self action:@selector(dial) forControlEvents:UIControlEventTouchUpInside];
        
        _hangupButton = [self makeButtonWithTitle:@"Hang up" frame:CGRectMake(0, _dialButton.frame.origin.y + _dialButton.frame.size.height + 5, _dialButton.frame.size.width, _dialButton.frame.size.height)];
        [_hangupButton addTarget:self action:@selector(hangup) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_numberInput];
        [self addSubview:_dialButton];
        [self addSubview:_hangupButton];
        
    }
    return self;
}

- (void)dial {
    NSString *number = [_numberInput.text trimWhitespaceAndNewline];
    if (number == nil || [number isEqualToString:@""]) {
        [[[iToast makeText:@"Number can't be empty"] setDuration:iToastDurationShort] show];
        return;
    }
    
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(dial:)]) {
        [self.viewControllerRef performSelector:@selector(dial:) withObject:number];
    }
}


- (void)hangup {
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(hangup)]) {
        [self.viewControllerRef performSelector:@selector(hangup)];
    }
}

- (void)enableDial {
    [_dialButton setEnabled:YES];
    [_hangupButton setEnabled:NO];
}

- (void)enableHangup {
    [_dialButton setEnabled:NO];
    [_hangupButton setEnabled:YES];
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
