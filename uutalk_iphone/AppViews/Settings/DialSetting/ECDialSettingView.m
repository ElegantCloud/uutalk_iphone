//
//  ECDialSettingView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-24.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECDialSettingView.h"

@interface ECDialSettingView () {
    UISegmentedControl *_segment;
}


@end

@implementation ECDialSettingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        _titleView.text = NSLocalizedString(@"Dial Setting", "");
        self.titleView = _titleView;
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"more", "") style:UIBarButtonItemStyleDone target:self action:@selector(onBackAction)];
        
        NSArray *items = [NSArray arrayWithObjects:NSLocalizedString(@"Always dial via network", ""), NSLocalizedString(@"Always dial by callback", ""), NSLocalizedString(@"Manual", ""), NSLocalizedString(@"Callback in 3G, Dial via network in WIFI", ""), nil];
        
        _segment = [[UISegmentedControl alloc] initWithItems:items];
        _segment.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
        
        NSArray *arr = [_segment subviews];
        for (int i = 0; i < [arr count]; i++) {
            UIView *v = (UIView*) [arr objectAtIndex:i];
            NSArray *subarr = [v subviews];
            for (int j = 0; j < [subarr count]; j++) {
                if ([[subarr objectAtIndex:j] isKindOfClass:[UILabel class]]) {
                    UILabel *l = (UILabel*) [subarr objectAtIndex:j];
                    l.transform = CGAffineTransformMakeRotation(- M_PI / 2.0);
                }
            }
        }
        
        [self addSubview:_segment];
    }
    return self;
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
