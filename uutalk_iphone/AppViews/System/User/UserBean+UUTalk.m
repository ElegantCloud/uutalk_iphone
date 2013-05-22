//
//  UserBean+UUTalk.m
//  uutalk_iphone
//
//  Created by king star on 13-5-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "UserBean+UUTalk.h"
#import "ECConstants.h"

@implementation UserBean (UUTalk)
- (void)setAutoLogin:(BOOL)autoLogin {
    [self.extensionDic setObject:[NSNumber numberWithBool:autoLogin] forKey:@"autologin"];
}

- (BOOL)autoLogin {
    BOOL autologin = NO;
    NSNumber * ret = [self.extensionDic objectForKey:@"autologin"];
    if (ret) {
        autologin = ret.boolValue;
    }
    
    return autologin;
}

- (void)setCountryCode:(NSString *)countryCode {
    if (countryCode) {
        [self.extensionDic setObject:countryCode forKey:COUNTRYCODE];
    }
}

- (NSString *)countryCode {
    return [self.extensionDic objectForKey:COUNTRYCODE];
}

- (void)setCallbackPhoneNumber:(NSString *)callbackPhoneNumber {
    if (callbackPhoneNumber) {
        [self.extensionDic setObject:callbackPhoneNumber forKey:CALLBACK_PHONE_NUMBER];
    }
}

- (NSString *)callbackPhoneNumber {
    return [self.extensionDic objectForKey:CALLBACK_PHONE_NUMBER];
}

- (void)setCallbackPhoneNumberCountryCode:(NSString *)callbackPhoneNumberCountryCode {
    if (callbackPhoneNumberCountryCode) {
        [self.extensionDic setObject:callbackPhoneNumberCountryCode forKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
    }
}

- (NSString *)callbackPhoneNumberCountryCode {
    return [self.extensionDic objectForKey:CALLBACK_PHONE_NUMBER_COUNTRY_CODE];
}

- (void)setVosphone:(NSString *)vosphone {
    if (vosphone) {
        [self.extensionDic setObject:vosphone forKey:VOSPHONE];
    }
}

- (NSString *)vosphone {
    return [self.extensionDic objectForKey:VOSPHONE];
}

- (void)setVosphonePwd:(NSString *)vosphonePwd {
    if (vosphonePwd) {
        [self.extensionDic setObject:vosphonePwd forKey:VOSPHONE_PWD];
    }
}

- (NSString *)vosphonePwd {
    return [self.extensionDic objectForKey:VOSPHONE_PWD];
}

- (void)setDefaultDialCountryCode:(NSString *)defaultDialCountryCode {
    if (defaultDialCountryCode) {
        [self.extensionDic setObject:defaultDialCountryCode forKey:DEFAULT_DIAL_COUNTRY_CODE];
    }
}

- (NSString *)defaultDialCountryCode {
    return [self.extensionDic objectForKey:DEFAULT_DIAL_COUNTRY_CODE];
}
@end
