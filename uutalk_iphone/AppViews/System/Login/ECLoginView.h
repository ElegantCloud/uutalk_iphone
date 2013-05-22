//
//  ECLoginView.h
//  uutalk_iphone
//
//  Created by king star on 13-5-21.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECBaseUIView.h"

@interface ECLoginView : ECBaseUIView {
    UITextField *_userNameInput;
    UITextField *_pwdInput;
    
    UISwitch *_autoLoginSwitch;

    UIButton *_loginButton;
    
    BOOL _useSavedPwd;
}

@end
