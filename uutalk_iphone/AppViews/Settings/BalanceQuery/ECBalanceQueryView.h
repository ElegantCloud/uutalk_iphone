//
//  ECBalanceQueryView.h
//  uutalk_iphone
//
//  Created by king star on 13-6-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECBaseUIView.h"

@interface ECBalanceQueryView : ECBaseUIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *valueArray;
@end
