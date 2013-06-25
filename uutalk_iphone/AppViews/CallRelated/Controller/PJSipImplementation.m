//
//  PJSipImplementation.m
//  ChineseTelephone
//
//  Created by Ares on 13-6-7.
//  Copyright (c) 2013年 richitec. All rights reserved.
//

#import "PJSipImplementation.h"
#import "ECSipServiceManager.h"


@implementation PJSipImplementation

- (id)init{
    self = [super init];
    if (self) {
        // init sip implementation protocol implementation using self
        _mSipImplementationProtocolImpl = self;
    }
    return self;
}

// ISipProtocol
- (void)registerSipAccount:(SipRegistrationBean *)sipAccount stateChangedProtocolImpl:(id<SipRegistrationStateChangedProtocol>)sipRegistrationStateChangedProtocolImpl{
    NSLog(@"PJSipImplementation - registerSipAccount, sip account = %@ and sip registration state changed protocol implementation = %@", sipAccount, sipRegistrationStateChangedProtocolImpl);
    ECSipServiceManager *ssm = [ECSipServiceManager shareSipServiceManager];
    [ssm registerSipAccount:sipAccount];
    ssm.registerListener = sipRegistrationStateChangedProtocolImpl;
    
}

- (void)unregisterSipAccount:(id<SipRegistrationStateChangedProtocol>)sipRegistrationStateChangedProtocolImpl{
    NSLog(@"PJSipImplementation - unregisterSipAccount, sip registration state changed protocol implementation = %@", sipRegistrationStateChangedProtocolImpl);
    
    //
}

- (void)muteSipVoiceCall{
    NSLog(@"PJSipImplementation - muteSipVoiceCall");
    
    [[ECSipServiceManager shareSipServiceManager] muteSipVoice:YES];
}

- (void)unmuteSipVoiceCall{
    NSLog(@"PJSipImplementation - unmuteSipVoiceCall");

    [[ECSipServiceManager shareSipServiceManager] muteSipVoice:NO];
}

- (void)sendDTMF:(NSString *)dtmfCode{
    NSLog(@"PJSipImplementation - sendDTMF - dtmf code = %@", dtmfCode);
    const char *digits = [dtmfCode cStringUsingEncoding:NSUTF8StringEncoding];
    char digit = digits[0];
    [[ECSipServiceManager shareSipServiceManager] sendDTMF:digit];
}

- (BOOL)initSipEngine {
    return [[ECSipServiceManager shareSipServiceManager] initSipEngine];
}

- (void)destroySipEngine{
    NSLog(@"PJSipImplementation - destroySipEngine");
    [[ECSipServiceManager shareSipServiceManager] destroySipEngine];
    
}

// SipImplementationProtocol
- (BOOL)makeSipVoiceCall:(NSString *)calleeName phone:(NSString *)calleePhone stateChangedProtocolImpl:(id<SipInviteStateChangedProtocol>)stateChangedProtocolImpl{
    NSLog(@"PJSipImplementation - makeSipVoiceCall - callee name = %@, callee phone = %@ and state changed protocol implementation = %@", calleeName, calleePhone, stateChangedProtocolImpl);
    ECSipServiceManager *ssm = [ECSipServiceManager shareSipServiceManager];
    ssm.callListener = stateChangedProtocolImpl;
    return [ssm makeCall:calleePhone];

}

- (BOOL)hangupSipVoiceCall{
    NSLog(@"PJSipImplementation - hangupSipVoiceCall");
    [[ECSipServiceManager shareSipServiceManager] hangup];
    return YES;
}

@end
