//
//  CountryCodeManager.h
//  uutalk_iphone
//
//  Created by king star on 13-5-24.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryCodeManager : NSObject
+ (CountryCodeManager*)shareCountryCodeManager;
+ (BOOL)hasCountryCodePrefix:(NSString*)number;
@end
