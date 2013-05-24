//
//  CountryCodeManager.m
//  uutalk_iphone
//
//  Created by king star on 13-5-24.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "CountryCodeManager.h"
#import "ECConfig.h"

static CountryCodeManager *instance;

@implementation CountryCodeManager

+ (CountryCodeManager*)shareCountryCodeManager {
    if (instance == nil) {
        instance = [[CountryCodeManager alloc] init];
    }
    return instance;
}

+ (BOOL)hasCountryCodePrefix:(NSString*)number {
    NSArray *countryCodes = COUNTRY_CODES;
    BOOL ret = NO;
    for (NSString *prefix in countryCodes) {
        if ([number hasPrefix:prefix]) {
            ret = YES;
            break;
        }
    }
    return ret;
}

@end
