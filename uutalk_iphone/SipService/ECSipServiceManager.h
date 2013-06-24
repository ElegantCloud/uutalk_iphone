//
//  ECSipServiceManager.h
//  uutalk_iphone
//
//  Created by king star on 13-6-7.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SipRegistrationBean.h"
#import "ECConstants.h"
#import "SipInviteStateChangedProtocol.h"
#import "SipRegistrationStateChangedProtocol.h"

@interface ECSipServiceManager : NSObject
@property id<SipInviteStateChangedProtocol> callListener;
@property id<SipRegistrationStateChangedProtocol> registerListener;

+ (ECSipServiceManager *)shareSipServiceManager;

- (BOOL)initSipEngine;
- (void)destroySipEngine;
- (void)registerSipAccount:(SipRegistrationBean *)sipRegisterBean;
- (BOOL)makeCall:(NSString *)number;
- (void)hangup;
- (void)onCallStateChange:(NSNumber *)state;
- (void)onRegistrationStateChange:(NSNumber *)regState;
@end
