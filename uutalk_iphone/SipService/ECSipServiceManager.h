//
//  ECSipServiceManager.h
//  uutalk_iphone
//
//  Created by king star on 13-6-7.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSipRegisterBean.h"

@interface ECSipServiceManager : NSObject

+ (ECSipServiceManager *)shareSipServiceManager;

- (void)initSipEngine;

- (void)registerSipAccount:(ECSipRegisterBean *)sipRegisterBean;
- (void)makeCall:(NSString *)number;
@end
