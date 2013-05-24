//
//  ECRegisterView.h
//  uutalk_iphone
//
//  Created by king star on 13-5-23.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECBaseUIView.h"

@interface ECRegisterView : ECBaseUIView {
    UITextField *_mUserNameInput;
    UITextField *_mPwdInput;
    UITextField *_mPwdConfirmInput;
    UITextField *_mValidateCodeInput;
    
    UIView *_mStep1View; // view for getting phone code
    UIView *_mStep2View; // view for verifying phone code
    UIView *_mStep3View; // view for inputing password
}

- (void)switchToStep1View;
- (void)switchToStep2View;
- (void)switchToStep3View;

@end
