//
//  UserBean+UUTalk.h
//  uutalk_iphone
//
//  Created by king star on 13-5-22.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <CommonToolkit/CommonToolkit.h>

@interface UserBean (UUTalk)
@property BOOL autoLogin;
@property (retain) NSString *countryCode;
@property (retain) NSString *callbackPhoneNumber;
@property (retain) NSString *callbackPhoneNumberCountryCode;
@property (retain) NSString *vosphone;
@property (retain) NSString *vosphonePwd;
@property (retain) NSString *defaultDialCountryCode;
@end
