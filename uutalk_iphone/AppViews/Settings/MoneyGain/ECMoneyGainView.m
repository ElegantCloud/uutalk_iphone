//
//  ECMoneyGainView.m
//  uutalk_iphone
//
//  Created by king star on 13-5-29.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECMoneyGainView.h"
#import "ECConstants.h"

#define MARGIN  5

@interface ECMoneyGainView () {
    UIView *_boardView;
    UILabel *_infoBoardLabel;
    UIView *_inviteSectionView;
    UILabel *_inviteSummaryLabel;
}

@end

@implementation ECMoneyGainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _titleView.text = NSLocalizedString(@"Money Gain", "");
    self.titleView = _titleView;
    self.backgroundColor = [UIColor whiteColor];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    _infoBoardLabel = [[UILabel alloc] init];
    NSString* info = @"To design a data object class, first examine the app’s functionality to discover what units of data it needs to handle. For example, you might consider defining a bird class and a bird-sighting class. But to keep this tutorial as simple as possible, you’ll define a single data object class—a bird-sighting class—that contains properties that represent a bird name, a sighting location, and a date.";
    _infoBoardLabel.font = [UIFont fontWithName:CHINESE_FONT size:15];
    _infoBoardLabel.lineBreakMode = UILineBreakModeWordWrap;
    _infoBoardLabel.numberOfLines = 0;
    _infoBoardLabel.backgroundColor = [UIColor whiteColor];
    _infoBoardLabel.textColor = [UIColor redColor];
    
    _boardView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 0, 0)];
    _boardView.backgroundColor = [UIColor whiteColor];
    _boardView.layer.masksToBounds = YES;
    _boardView.layer.cornerRadius = 6.0;
    _boardView.layer.borderColor = [[UIColor grayColor] CGColor];
    _boardView.layer.borderWidth = 1;
    [_boardView addSubview:_infoBoardLabel];
    
    [self setInfoBoard:info];
    
    _inviteSectionView = [[UIView alloc] init];
    _inviteSectionView.backgroundColor = [UIColor clearColor];
    _inviteSectionView.frame = CGRectMake(0, _boardView.frame.origin.y + _boardView.frame.size.height, self.frame.size.width, 300);
    
    _inviteSummaryLabel = [[UILabel alloc] initWithFrame:CGRectMake((_inviteSectionView.frame.size.width - 300) / 2, 5, 300, 30)];
    _inviteSummaryLabel.text = @"A Boolean value that determines";
    _inviteSummaryLabel.textColor = [UIColor blueColor];
    _inviteSummaryLabel.font = [UIFont fontWithName:CHINESE_FONT size:15];
    _inviteSummaryLabel.textAlignment = UITextAlignmentCenter;
    [_inviteSectionView addSubview:_inviteSummaryLabel];
    
    UILabel *shareDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, _inviteSummaryLabel.frame.origin.y + _inviteSummaryLabel.frame.size.height + MARGIN * 2, 200, 30)];
    shareDescLabel.text = NSLocalizedString(@"Plese Choose Share Method", "");
    shareDescLabel.font = [UIFont fontWithName:CHINESE_FONT size:17];
    shareDescLabel.textColor = [UIColor blackColor];
    [_inviteSectionView addSubview:_inviteSummaryLabel];
    
    
    [scrollView addSubview:_boardView];
    [scrollView addSubview:_inviteSectionView];
    
    scrollView.contentSize = CGSizeMake(self.frame.size.width, _inviteSummaryLabel.frame.origin.y + _inviteSectionView.frame.size.height + 10);
    [self addSubview:scrollView];
}

- (void)setInfoBoard:(NSString *)info {
    if (info) {
        _infoBoardLabel.text = info;
        CGSize constraint = CGSizeMake(280, 20000);
        CGSize size = [_infoBoardLabel.text sizeWithFont:_infoBoardLabel.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        _boardView.frame = CGRectMake(_boardView.frame.origin.x, _boardView.frame.origin.y, size.width + 10, size.height + 10);
        _boardView.center = CGPointMake(self.center.x, _boardView.center.y);
        _infoBoardLabel.frame = CGRectMake(0, 0, size.width, size.height);
        _infoBoardLabel.center = CGPointMake(_boardView.frame.size.width / 2, _boardView.frame.size.height / 2);
    } else {
        _boardView.frame = CGRectMake(_boardView.frame.origin.x, _boardView.frame.origin.y, 0, 0);
        [_boardView setHidden:YES];
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
