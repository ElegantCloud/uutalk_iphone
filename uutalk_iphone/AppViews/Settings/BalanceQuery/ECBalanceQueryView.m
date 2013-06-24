//
//  ECBalanceQueryView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECBalanceQueryView.h"
#import "ECConstants.h"
#import "ECConfig.h"
#import "UserBean+UUTalk.h"


static CGFloat CellHeight = 40;
static CGFloat NameWidth = 130;
static CGFloat NameHeight = 30;
static CGFloat ValueWidth = 160;
static CGFloat GAP = 6;

@interface ItemCell : UITableViewCell {
    UILabel *_nameLabel;
    UILabel *_valueLabel;
}

+ (CGFloat)cellHeight;
- (id)initWithName:(NSString *)name Value:(NSString *)value;
@end

@implementation ItemCell

+ (CGFloat)cellHeight {
    return CellHeight;
}

- (id)initWithName:(NSString *)name Value:(NSString *)value {
    self = [super init];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, (CellHeight - NameHeight) / 2, NameWidth, NameHeight)];
        _nameLabel.text = name;
        _nameLabel.textAlignment = UITextAlignmentRight;
        _nameLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x + _nameLabel.frame.size.width + 4, _nameLabel.frame.origin.y, ValueWidth, NameHeight)];
        _valueLabel.text = value;
        _valueLabel.textAlignment = UITextAlignmentLeft;
        _valueLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.textColor = [UIColor colorWithIntegerRed:0x24 integerGreen:0x70 integerBlue:0xd8 alpha:1];
        [self.contentView addSubview:_valueLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

#define NAME_ARRAY          [NSArray arrayWithObjects:NSLocalizedString(@"Country Code:", ""), NSLocalizedString(@"Mobile:", ""), NSLocalizedString(@"Balance:", ""), nil]

@implementation ECBalanceQueryView {
    NSArray *_names;
}


@synthesize tableView = _tableView;
@synthesize valueArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        _titleView.text = NSLocalizedString(@"Balance Query", "");
        self.titleView = _titleView;
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"more", "") style:UIBarButtonItemStyleDone target:self action:@selector(onBackAction)];

        _names = NAME_ARRAY;
        UserBean *user = [[UserManager shareUserManager] userBean];
        self.valueArray = [NSMutableArray arrayWithObjects:user.countryCode, user.name, NSLocalizedString(@"Querying balance…", ""), nil];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELLITEM = @"item_cell";
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLITEM];
    if (!cell) {
        NSString *name = [_names objectAtIndex:indexPath.row];
        NSString *value = [self.valueArray objectAtIndex:indexPath.row];
        
        cell = [[ItemCell alloc] initWithName:name Value:value];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ItemCell cellHeight];
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
