//
//  ECDialSettingView.m
//  uutalk_iphone
//
//  Created by king star on 13-6-24.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECDialSettingView.h"
#import "ECConstants.h"
#import "SipCallDialModeSelector.h"

static CGFloat CellHeight = 40;
static CGFloat NameWidth = 240;
static CGFloat NameHeight = 30;
static CGFloat ValueWidth = 80;
static CGFloat GAP = 6;

@interface DialItemCell : UITableViewCell {
    UILabel *_nameLabel;
    UILabel *_valueLabel;
}
- (void)setItemName:(NSString *)name;
- (void)setItemSelected:(BOOL)selected;

+ (CGFloat)cellHeight;
- (id)initWithName:(NSString *)name Selected:(BOOL)selected;
@end

@implementation DialItemCell

+ (CGFloat)cellHeight {
    return CellHeight;
}

- (id)initWithName:(NSString *)name Selected:(BOOL)selected {
    self = [super init];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, (CellHeight - NameHeight) / 2, NameWidth, NameHeight)];
        _nameLabel.text = name;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = UITextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont fontWithName:CHINESE_FONT size:16];
        [self.contentView addSubview:_nameLabel];
        
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x + _nameLabel.frame.size.width + 20, _nameLabel.frame.origin.y, ValueWidth, NameHeight)];
        _valueLabel.text = @"√";
        _valueLabel.font = [UIFont fontWithName:CHINESE_BOLD_FONT size:16];
        _valueLabel.textColor = [UIColor blackColor];
        _valueLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_valueLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        [self setItemSelected:selected];
        
    }
    return self;
}

- (void)setItemName:(NSString *)name {
    _nameLabel.text = name;
}

- (void)setItemSelected:(BOOL)selected {
    NSLog(@"set selected: %d", selected);
    if (selected) {
        [_valueLabel setHidden:NO];
    } else {
        [_valueLabel setHidden:YES];
    }
}

@end




@interface ECDialSettingView () {
    NSArray *_items;
    NSMutableArray *_selectedArray;
    UITableView *_tableView;
}


@end

@implementation ECDialSettingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [DisplayScreenUtils navigationBarHeight]);
        self.title = NSLocalizedString(@"Dial Setting", "");
        self.backgroundColor = [UIColor whiteColor];
                
        _items = [NSArray arrayWithObjects:NSLocalizedString(@"Always dial via network", ""), NSLocalizedString(@"Always dial by callback", ""), NSLocalizedString(@"Manual", ""), NSLocalizedString(@"Auto Select", ""), nil];
        
        _selectedArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil];

        SipCallDialModeSelectPattern dialPattern = [SipCallDialModeSelector getSipCallDialModeSelectPattern];
        switch (dialPattern) {
            case DIRECT_DIAL_DEFAULT:
                [_selectedArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:0];
                break;
            case CALLBACK_DEFAULT:
                [_selectedArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:1];
                break;
            case MANUAL_SELECT:
                [_selectedArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:2];
                break;
            case AUTO_SELECT:
                [_selectedArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:3];
                break;
            default:
                break;
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self addSubview:_tableView];
     
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELLITEM = @"item_cell";
    DialItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLITEM];
    NSString *name = [_items objectAtIndex:indexPath.row];
    NSNumber *selected = [_selectedArray objectAtIndex:indexPath.row];
    NSLog(@"item %d selected %@", indexPath.row, selected);
    if (!cell) {
        NSLog(@"cell is nil, create new one");
        cell = [[DialItemCell alloc] initWithName:name Selected:[selected boolValue]];
    } else {
        NSLog(@"use old cell");
        [cell setItemName:name];
        [cell setItemSelected:[selected boolValue]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DialItemCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = _selectedArray.count;
    for (NSInteger i = 0; i < count; i++) {
        if (i == indexPath.row) {
            [_selectedArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:indexPath.row];
        } else {
            [_selectedArray setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
        }
    }
    NSString *name = [_items objectAtIndex:indexPath.row];
    if ([name isEqualToString:NSLocalizedString(@"Always dial via network", "")]) {
        [SipCallDialModeSelector setSipCallDialModeSelectPattern:DIRECT_DIAL_DEFAULT];
    } else if ([name isEqualToString:NSLocalizedString(@"Always dial by callback", nil)]) {
        [SipCallDialModeSelector setSipCallDialModeSelectPattern:CALLBACK_DEFAULT];
    } else if ([name isEqualToString:NSLocalizedString(@"Manual", "")]) {
        [SipCallDialModeSelector setSipCallDialModeSelectPattern:MANUAL_SELECT];
    } else {
        [SipCallDialModeSelector setSipCallDialModeSelectPattern:AUTO_SELECT];
    }
    
    [_tableView reloadData];
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
