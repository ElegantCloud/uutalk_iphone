//
//  ECTopupView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECTopupView.h"
#import "ECConstants.h"

#define PAD     8
@implementation ECTopupView
@synthesize balanceLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [[UIDevice currentDevice] navigationBarHeight]);
        _titleView.text = NSLocalizedString(@"Account Top Up", "");
        self.titleView = _titleView;
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"more", "") style:UIBarButtonItemStyleDone target:self action:@selector(onBackAction)];
        
        UIView *balanceRegionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        balanceRegionView.backgroundColor = [UIColor colorWithIntegerRed:0xfa integerGreen:0xea integerBlue:0xa9 alpha:1];
        [self addSubview:balanceRegionView];

        UILabel *balanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(PAD, 0, 88, 40)];
        balanceTitleLabel.text = NSLocalizedString(@"Balance:", "");
        balanceTitleLabel.textAlignment = UITextAlignmentLeft;
        balanceTitleLabel.textColor = [UIColor blackColor];
        balanceTitleLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        balanceTitleLabel.backgroundColor = [UIColor clearColor];
        [balanceRegionView addSubview:balanceTitleLabel];
        
        self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(balanceTitleLabel.frame.origin.x + balanceTitleLabel.frame.size.width + 2, balanceTitleLabel.frame.origin.y, 100, balanceTitleLabel.frame.size.height)];
        self.balanceLabel.backgroundColor = [UIColor clearColor];
        self.balanceLabel.textColor = [UIColor blackColor];
        self.balanceLabel.font = [balanceTitleLabel font];
        [balanceRegionView addSubview:self.balanceLabel];
        
        UILabel *topupMethodDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(PAD, balanceRegionView.frame.origin.y + balanceRegionView.frame.size.height + 10, 300, 40)];
        topupMethodDescLabel.backgroundColor = [UIColor clearColor];
        topupMethodDescLabel.textColor = [UIColor colorWithIntegerRed:0x24 integerGreen:0x70 integerBlue:0xd8 alpha:1];
        topupMethodDescLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        topupMethodDescLabel.text = NSLocalizedString(@"Please select top-up method", "");
        [self addSubview:topupMethodDescLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, topupMethodDescLabel.frame.origin.y + topupMethodDescLabel.frame.size.height, self.frame.size.width, 1)];
        line.backgroundColor = [UIColor colorWithIntegerRed:0xe0 integerGreen:0xe0 integerBlue:0xe0 alpha:1];
        [self addSubview:line];
        
        UIButton *uutalkCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        uutalkCardButton.frame = CGRectMake(0, line.frame.origin.y + line.frame.size.height, self.frame.size.width, 50);
        [uutalkCardButton setImage:[UIImage imageNamed:@"uutalk_charge_card"] forState:UIControlStateNormal];
        [uutalkCardButton setBackgroundColor:[UIColor clearColor]];
        [uutalkCardButton setBackgroundImage:[[UIImage imageNamed:@"btn_gray"] stretchableImageWithLeftCapWidth:8 topCapHeight:8] forState:UIControlStateHighlighted];
        [uutalkCardButton addTarget:self action:@selector(clickUUtalkCardCharge) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:uutalkCardButton];
        
        UIView *line2 = [[UIView alloc] init];
        line2.frame = CGRectMake(line.frame.origin.x, uutalkCardButton.frame.origin.y + uutalkCardButton.frame.size.height, line.frame.size.width, line.frame.size.height);
        line2.backgroundColor = line.backgroundColor;
        [self addSubview:line2];
    }
    return self;
}


- (void)clickUUtalkCardCharge {
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(jumpToUUTalkCardCharge)]) {
        [self.viewControllerRef performSelector:@selector(jumpToUUTalkCardCharge)];
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
