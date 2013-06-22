//
//  ECUrlConfig.h
//  imeeting_iphone
//
//  Created by star king on 12-6-8.
//  Copyright (c) 2012年 elegant cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_ADDR                 @"http://www.uu-talk.com/uutalk"
#define RETRIEVE_PHONE_CODE_URL     [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/user/getPhoneCode"]
#define CHECK_PHONE_CODE_URL        [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/user/checkPhoneCode"]
#define USER_REGISTER_URL           [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/user/regUser"]
#define USER_LOGIN_URL              [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/user/login"]
#define GET_PWD_URL              [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/user/getUserPwd"]
#define BALANCE_URL                 [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/accountBalance"]
#define CARD_CHARGE_URL             [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/cardCharge"]
#define MODIFY_PWD_URL              [NSString stringWithFormat:@"%@%@", SERVER_ADDR, @"/profile/changePwd"]