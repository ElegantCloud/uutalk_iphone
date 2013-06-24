//
//  ECConstants.h
//  imeeting_iphone
//
//  Created by star king on 12-6-14.
//  Copyright (c) 2012年 elegant cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHINESE_FONT            @"ArialMT"
#define CHINESE_BOLD_FONT       @"Arial-BoldMT"
#define CHARACTER_FONT          @"ArialMT"
#define CHARACTER_BOLD_FONT     @"Arial-BoldMT"


typedef enum CALL_STATE {
    CALLING = 0,
    CALL_ESTABLISHED = 1,
    CALL_DISCONNECTED = 2,
    CALL_FAILED = 3,
    CALL_EARLY = 4
} EC_CALL_STATE;

typedef enum REG_STATE {
    REG_OK = 0,
    REG_FAILED = 1,
    UNREG_OK = 2,
    UNREG_FAILED = 3,
    REGISTERING = 4
} EC_REG_STATE;

// Account CONSTANTS
static NSString *PASSWORD = @"password";
static NSString *USERKEY = @"userkey";
static NSString *USERNAME = @"username";
static NSString *COUNTRYCODE = @"countryCode";
static NSString *CALLBACK_PHONE_NUMBER = @"bindphone";
static NSString *CALLBACK_PHONE_NUMBER_COUNTRY_CODE = @"bindphone_country_code";
static NSString *VOSPHONE = @"vosphone";
static NSString *VOSPHONE_PWD = @"vosphone_pwd";
static NSString *DEFAULT_DIAL_COUNTRY_CODE = @"defaultDialCountryCode";



