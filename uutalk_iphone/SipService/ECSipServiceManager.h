//
//  ECSipServiceManager.h
//  uutalk_iphone
//
//  Created by king star on 13-6-7.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSipRegisterBean.h"
#import "ECConstants.h"

@interface ECSipServiceManager : NSObject

+ (ECSipServiceManager *)shareSipServiceManager;

- (BOOL)initSipEngine;

- (void)registerSipAccount:(ECSipRegisterBean *)sipRegisterBean;
- (void)makeCall:(NSString *)number;
- (void)hangup;
- (void)onCallStateChange:(NSNumber *)state;
@end
