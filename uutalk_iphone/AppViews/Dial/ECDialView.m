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
}

@end

@implementation ECDialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(screenBounds.origin.x, screenBounds.origin.y, screenBounds.size.width, screenBounds.size.height - ([[UIDevice currentDevice] statusBarHeight] + [[UIDevice currentDevice] navigationBarHeight]) - 50);
        
        _numberInput = [self makeTextFieldWithPlaceholder:@"Input Number" frame:CGRectMake(0, 10, self.frame.size.width, 30) keyboardType:UIKeyboardTypePhonePad];
        UIButton *dialButton = [self makeButtonWithTitle:@"Dial" frame:CGRectMake(0, _numberInput.frame.origin.y + _numberInput.frame.size.height + 5, self.frame.size.width, 30)];
        [dialButton addTarget:self action:@selector(dial) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_numberInput];
        [self addSubview:dialButton];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
