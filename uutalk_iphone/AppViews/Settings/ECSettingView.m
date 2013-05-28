//
//  ECSettingView.m
//  uutalk_iphone
//
//  Created by king star on 13-5-28.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECSettingView.h"
#import "ECConstants.h"

static CGFloat CellHeight = 40;
static CGFloat IconWidth = 27;
static CGFloat IconHeight = 27;
static CGFloat NameWidth = 230;
static CGFloat NameHeight = 30;
static CGFloat ArrowWidth = 14;
static CGFloat ArrowHeight = 14;
static CGFloat GAP = 6;
@implementation SettingItemCell

+ (CGFloat)cellHeight {
    return CellHeight;
}

- (id)initWithItem:(NSString *)itemName itemIcon:(UIImage *)icon {
    self = [super init];
    if (self) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(GAP, (CellHeight - IconHeight) / 2, IconWidth, IconHeight)];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.image = icon;
        [self.contentView addSubview:_iconView];
        
        _nameView = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.frame.origin.x + _iconView.frame.size.width + GAP, (CellHeight - NameHeight) / 2, NameWidth, NameHeight)];
        _nameView.text = itemName;
        _nameView.textAlignment = NSTextAlignmentLeft;
        _nameView.textColor = [UIColor blackColor];
        _nameView.font = [UIFont fontWithName:CHINESE_FONT size:16];
        _nameView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameView];
        
        _rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(_nameView.frame.origin.x + _nameView.frame.size.width + GAP, (CellHeight - ArrowHeight) / 2, ArrowWidth, ArrowHeight)];
        _rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
        _rightArrowView.image = [UIImage imageNamed:@"into_icon"];
        [self.contentView addSubview:_rightArrowView];
    }
    return self;
}


@end




#define SECTION_TITLES     [NSArray arrayWithObjects:NSLocalizedString(@"Account", ""), NSLocalizedString(@"Query", ""), NSLocalizedString(@"Setting", ""), NSLocalizedString(@"Help", ""), nil]

#define ACCOUNT_ITEMS      [NSArray arrayWithObjects:NSLocalizedString(@"Money Gain", ""), NSLocalizedString(@"Account Top Up", ""), NSLocalizedString(@"My Suites", ""), NSLocalizedString(@"Password Reset", ""), NSLocalizedString(@"Find Password", ""), NSLocalizedString(@"Sign Out", ""), nil]
#define QUERY_ITEMS        [NSArray arrayWithObjects:NSLocalizedString(@"Balance Query", ""), NSLocalizedString(@"Fee Query", ""), nil]
#define SETTING_ITEMS      [NSArray arrayWithObjects:NSLocalizedString(@"Dial Setting", ""), NSLocalizedString(@"Local Area Code Setting", ""), NSLocalizedString(@"Callback Number Setting", ""), NSLocalizedString(@"Login Setting", ""), nil]
#define HELP_ITEMS         [NSArray arrayWithObjects:NSLocalizedString(@"About", ""), nil]

#define ACCOUNT_ICONS       [NSArray arrayWithObjects:@"money", @"charge", @"suite", @"changepsw", @"getpsw", @"menuexit", nil]
#define QUERY_ICONS         [NSArray arrayWithObjects:@"search_remainmoney", @"zifeichaxun", nil]
#define SETTING_ICONS       [NSArray arrayWithObjects:@"setting_dial", @"setting_countrycode", @"setauthnumber", @"setting_setup", nil]
#define HELP_ICONS          [NSArray arrayWithObjects:@"uutalk", nil]

#define HEADER_HEIGHT   20

@interface ECSettingView () {
    NSArray *_titles;
    NSMutableArray *_sectionArray;
    NSMutableArray *_sectionIconArray;
}
- (void)initUI;

@end

@implementation ECSettingView

- (id)initWithFrame:(CGRect)frame
{
   
    self = [super initWithFrame:frame];
   
    if (self) {
        // Initialization code
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(screenBounds.origin.x, screenBounds.origin.y, screenBounds.size.width, screenBounds.size.height - ([[UIDevice currentDevice] statusBarHeight] + [[UIDevice currentDevice] navigationBarHeight]) - 50);
        
        _titles = SECTION_TITLES;
        _sectionArray = [NSMutableArray arrayWithCapacity:[_titles count]];
        [_sectionArray addObject:ACCOUNT_ITEMS];
        [_sectionArray addObject:QUERY_ITEMS];
        [_sectionArray addObject:SETTING_ITEMS];
        [_sectionArray addObject:HELP_ITEMS];
        
        _sectionIconArray = [NSMutableArray arrayWithCapacity:_titles.count];
        [_sectionIconArray addObject:ACCOUNT_ICONS];
        [_sectionIconArray addObject:QUERY_ICONS];
        [_sectionIconArray addObject:SETTING_ICONS];
        [_sectionIconArray addObject:HELP_ICONS];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _titleView.text = NSLocalizedString(@"more", "");
    self.titleView = _titleView;
    
    self.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    
}

#pragma mark - table view datasource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = [_sectionArray objectAtIndex:section];
    return items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_titles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELLITEM = @"settingitem_cell";
    SettingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLITEM];
    if (!cell) {
        NSArray *items = [_sectionArray objectAtIndex:indexPath.section];
        NSString *name = [items objectAtIndex:indexPath.row];
        NSArray *icons = [_sectionIconArray objectAtIndex:indexPath.section];
        NSString *iconName = [icons objectAtIndex:indexPath.row];
        cell = [[SettingItemCell alloc] initWithItem:name itemIcon:[UIImage imageNamed:iconName]];
    }
    return cell;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SettingItemCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"setting item selected - secion: %d row: %d", indexPath.section, indexPath.row);
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
