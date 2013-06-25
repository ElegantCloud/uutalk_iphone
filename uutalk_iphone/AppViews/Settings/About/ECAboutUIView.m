//
//  ECAboutUIView.m
//  imeeting_iphone
//
//  Created by king star on 12-8-16.
//  Copyright (c) 2012年 elegant cloud. All rights reserved.
//

#import "ECAboutUIView.h"
#import "ECConstants.h"

@interface ECAboutUIView ()
- (void)initUI;
@end

@implementation ECAboutUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.title = NSLocalizedString(@"About", "");
    
    self.backgroundColor = [UIColor whiteColor];
    
    // get UIScreen bounds
    CGRect _screenBounds = [[UIScreen mainScreen] bounds];
    
    // update contacts select container view frame
    self.frame = CGRectMake(_screenBounds.origin.x, _screenBounds.origin.y, _screenBounds.size.width, _screenBounds.size.height - /*statusBar height*/[DisplayScreenUtils statusBarHeight] - /*navigationBar height*/[DisplayScreenUtils navigationBarHeight]);
    
    UIView *descRegion = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 240)];
    descRegion.backgroundColor = [UIColor clearColor];
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((descRegion.frame.size.width - 90) / 2, 20, 40, 40)];
    logoImgView.contentMode = UIViewContentModeScaleAspectFit;
    logoImgView.layer.masksToBounds = YES;
    [logoImgView.layer setCornerRadius:5];
    logoImgView.image = [UIImage imageNamed:@"uutalk"];
    [descRegion addSubview:logoImgView];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *appName = [mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *version = [mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"app name: %@ version: %@", appName, version);
    
    UILabel *appNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoImgView.frame.origin.x + logoImgView.frame.size.width + 10, logoImgView.frame.origin.y + 5, 120, 30)];
    appNameLabel.text = appName;
    appNameLabel.textColor = [UIColor blackColor];
    appNameLabel.font = [UIFont fontWithName:CHINESE_BOLD_FONT size:20];
    appNameLabel.backgroundColor = [UIColor clearColor];
    [descRegion addSubview:appNameLabel];

    
    UILabel *infoTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((descRegion.frame.size.width - 300) / 2, logoImgView.frame.origin.y + logoImgView.frame.size.height + 12, 300, 20)];
    infoTextLabel.textColor = [UIColor colorWithIntegerRed:60 integerGreen:60 integerBlue:60 alpha:1];
    infoTextLabel.text = NSLocalizedString(@"product_description", nil);
    infoTextLabel.font = [UIFont fontWithName:CHINESE_FONT size:15];
    infoTextLabel.textAlignment = UITextAlignmentCenter;
    infoTextLabel.backgroundColor = [UIColor clearColor];
    [descRegion addSubview:infoTextLabel];
    
    UILabel *versionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((descRegion.frame.size.width - 50) / 2 - 16, infoTextLabel.frame.origin.y + infoTextLabel.frame.size.height + 12, 60, 30)];
    versionTitleLabel.textAlignment = UITextAlignmentCenter;
    versionTitleLabel.font = [UIFont fontWithName:CHINESE_FONT size:15];
    versionTitleLabel.backgroundColor = [UIColor clearColor];
    versionTitleLabel.text = NSLocalizedString(@"Version:", nil);
    versionTitleLabel.textColor = infoTextLabel.textColor;
    [descRegion addSubview:versionTitleLabel];
    
    UILabel *versionValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(versionTitleLabel.frame.origin.x + versionTitleLabel.frame.size.width + 2, versionTitleLabel.frame.origin.y, 40, versionTitleLabel.frame.size.height)];
    versionValueLabel.font = versionTitleLabel.font;
    versionValueLabel.backgroundColor = [UIColor clearColor];
    versionValueLabel.textColor = versionTitleLabel.textColor;
    versionValueLabel.text = version;
    [descRegion addSubview:versionValueLabel];
    
    UILabel *serviceQQLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, versionTitleLabel.frame.origin.y + versionTitleLabel.frame.size.height + 5, self.frame.size.width, 60)];
    serviceQQLabel.font = versionTitleLabel.font;
    serviceQQLabel.backgroundColor = [UIColor clearColor];
    serviceQQLabel.textColor = versionTitleLabel.textColor;
    serviceQQLabel.textAlignment = UITextAlignmentCenter;
    serviceQQLabel.numberOfLines = 0;
    serviceQQLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    serviceQQLabel.text = NSLocalizedString(@"Service QQ info", "");
    [descRegion addSubview:serviceQQLabel];
    
    UIButton *freeCallBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSInteger buttonWidth = 180;
    freeCallBt.frame = CGRectMake((self.frame.size.width - buttonWidth) / 2, serviceQQLabel.frame.origin.y + serviceQQLabel.frame.size.height + 5, buttonWidth, 35);
    [freeCallBt setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [freeCallBt setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 90)];
    [freeCallBt setTitle:NSLocalizedString(@"Free Service Call", "") forState:UIControlStateNormal];
    [freeCallBt addTarget:self action:@selector(clickFreeServiceCall) forControlEvents:UIControlEventTouchUpInside];
    [descRegion addSubview:freeCallBt];
    
    [self addSubview:descRegion];
    
    UILabel *aboutText = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 300) / 2 , descRegion.frame.origin.y + descRegion.frame.size.height - 10, 300, self.frame.size.height - descRegion.frame.size.height)];
    aboutText.textAlignment = UITextAlignmentCenter;
    aboutText.numberOfLines = 0;
    aboutText.lineBreakMode = UILineBreakModeCharacterWrap;
    aboutText.text = NSLocalizedString(@"about paragraph", nil);
    aboutText.font = [UIFont fontWithName:CHINESE_FONT size:15];
    aboutText.textColor = [UIColor colorWithIntegerRed:60 integerGreen:60 integerBlue:60 alpha:1];
    aboutText.backgroundColor = [UIColor clearColor];
    [self addSubview:aboutText];
}

- (void)clickFreeServiceCall {
    if ([self validateViewControllerRef:self.viewControllerRef andSelector:@selector(callService)]) {
        [self.viewControllerRef performSelector:@selector(callService)];
    }
}

@end
