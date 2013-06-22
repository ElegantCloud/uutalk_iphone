//
//  ECFindPasswordViewController.h
//  uutalk_iphone
//
//  Created by king star on 13-6-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECFindPasswordViewController : UIViewController

- (void)setFromSetting:(BOOL)flag;
- (void)findPasswordWithNumber:(NSString *)number;
@end
