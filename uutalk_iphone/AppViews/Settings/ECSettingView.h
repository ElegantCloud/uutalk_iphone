//
//  ECSettingView.h
//  uutalk_iphone
//
//  Created by king star on 13-5-28.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECBaseUIView.h"

@interface SettingItemCell : UITableViewCell {
    UIImageView *_iconView;
    UILabel *_nameView;
    UIImageView *_rightArrowView;
}

+ (CGFloat)cellHeight;
- (id)initWithItem:(NSString*)itemName itemIcon:(UIImage*)icon;
@end


@interface ECSettingView : ECBaseUIView <UITableViewDataSource, UITableViewDelegate>

@end
