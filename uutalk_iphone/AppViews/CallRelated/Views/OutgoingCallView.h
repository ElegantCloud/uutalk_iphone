//
//  OutgoingCallView.h
//  ChineseTelephone
//
//  Created by Ares on 13-5-31.
//  Copyright (c) 2013年 richitec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SipCallMode.h"

#import "SipInviteStateChangedProtocol.h"

#import "ISipProtocol.h"

#import <CommonToolkit/CommonToolkit.h>

@interface OutgoingCallView : UIView <SipInviteStateChangedProtocol, ABPeoplePickerNavigationControllerDelegate> {
    // sip voice call is established
    BOOL _mSipVoiceCallIsEstablished;
    
    // sip call callee and phone
    NSString *_mCallee;
    NSString *_mSipCallPhone;
    
    // sip protocol implementation
    id<ISipProtocol> _mSipImplementation;
    
    // sip call duration and its timer
    long _mSipCallDuration;
    NSTimer *_mSipCallDurationTimer;
    
    // callback sip voice call http request finished and failed response selector
    SEL _mCallbackSipVoiceCallHttpReqFinishedRespSelector;
    SEL _mCallbackSipVoiceCallHttpReqFailedRespSelector;
    
    // is hanguping
    BOOL _mIsHanguping;
    
    // present subviews
    // header view
    // callee label
    UILabel *_mCalleeLabel;
    // call status label
    UILabel *_mCallStatusLabel;
    
    // center views
    // call controller grid view
    UIView *_mCallControllerGridView;
    // keyboard grid view
    UIView *_mKeyboardGridView;
    // callback view
    UIView *_mCallbackView;
    
    // footer view
    // footer view
    UIView *_mFooterView;
    // hangup button
    UIButton *_mHangupButton;
    // hide keyboard button
    UIButton *_mHideKeyboardButton;
    // back for waiting callback call button
    UIButton *_mBack4waitingCallbackCallButton;
}

@property (nonatomic, readonly) SEL callbackSipVoiceCallHttpReqFinishedRespSelector;
@property (nonatomic, readonly) SEL callbackSipVoiceCallHttpReqFailedRespSelector;

// set outgoing call sip call mode and callee
- (void)setCallMode:(SipCallMode)callMode callee:(NSString *)callee phone:(NSString *)phone;

// set sip protocol implementation
- (void)setSipImplementation:(id<ISipProtocol>)sipImplementation;

@end
