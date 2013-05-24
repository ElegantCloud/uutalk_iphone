//
//  ECRegisterViewController.h
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonToolkit/CommonToolkit.h"

@interface ECRegisterViewController : UIViewController
/*
 * send phone number to server to retrieve validation code
 */
- (void)getValidationCodeByPhoneNumber:(NSString*)phoneNumber;

/**
 * send validation code to server to verify
 */
- (void)verifyCode:(NSString*)code;

/*
 * finish register
 */
- (void)finishRegisterWithPwds:(NSArray*)pwds;
@end
