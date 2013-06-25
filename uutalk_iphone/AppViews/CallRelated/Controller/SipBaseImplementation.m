//
//  SipBaseImplementation.m
//  ChineseTelephone
//
//  Created by Ares on 13-6-7.
//  Copyright (c) 2013年 richitec. All rights reserved.
//

#import "SipBaseImplementation.h"

#import "OutgoingCallViewController.h"

#import "OutgoingCallView.h"

#import <CommonToolkit/CommonToolkit.h>
#import "ECConfig.h"
#import "UserBean+UUTalk.h"
#import "ECConstants.h"
#import "ECUrlConfig.h"

@interface SipBaseImplementation ()

// before make sip voice call
- (UIViewController *)beforeMakeSipVoiceCall:(NSString *)calleeName phone:(NSString *)calleePhone callMode:(SipCallMode)callMode sponsorViewController:(UIViewController *)sponsorViewController;

// request callback sip voice call
- (BOOL)requestCallbackSipVoiceCall:(NSString *)calleeName phone:(NSString *)calleePhone processorViewController:(UIViewController *)processorViewController;

// after make sip voice call
- (void)afterMakeSipVoiceCall:(BOOL)makeCallResult stateChangedProtocolImpl:(id<SipInviteStateChangedProtocol>)stateChangedProtocolImpl;

@end

@implementation SipBaseImplementation

- (void)updateSipVoiceCallDuration:(long)duration{
    // open Chinese telephone database and checked it
    FMDatabase *_ChineseTelehoneDatabase = [FMDatabase databaseWithPath:[APP_DOCUMENTSPATH stringByAppendingPathComponent:CHINESETELEPHONE_DATABASENAME]];
    if ([_ChineseTelehoneDatabase open]) {
        // update call record call duration which in call records table
        if ([_ChineseTelehoneDatabase executeUpdate:[NSString stringWithFormat:UPDATECALLRECORDDURATIONSTATEMENT, CALLRECORDS_TABLENAME, CALLRECORDSTABLE_DUDATION_FIELDNAME, CALLRECORDSTABLE_ROWID_FIELDNAME], [NSNumber numberWithLong:duration], [NSNumber numberWithLongLong:_mSipVoiceCallLogId]]) {
        }
        else {
            NSLog(@"update call record duration failed, call log id = %lld", _mSipVoiceCallLogId);
        }
    }
    else {
        NSLog(@"open Chinese telephone database failed for update call record duration");
    }
    
    // close Chinese telephone database
    [_ChineseTelehoneDatabase close];
}

#define PHONE_NUMBER_FILTER_PREFIX           [NSArray arrayWithObjects:@"17909", @"11808", @"12593", @"17951", @"17911", nil]

// ISipProtocol
- (void)makeSipVoiceCall:(NSString *)callee phone:(NSString *)phone callMode:(SipCallMode)callMode fromViewController:(UIViewController *)sponsorViewController{
    
    // remove the specified prefix
    for (NSString *prefix in PHONE_NUMBER_FILTER_PREFIX) {
        NSRange range = [phone rangeOfString:prefix];
        if (range.location == 0) {
            if (range.length < phone.length) {
                phone = [phone substringFromIndex:range.length];
            }
        }
    }

    if (![phone isEqualToString:SERVICE_NUMBER]) {
        if ([phone rangeOfString:@"00"].location == 0 && phone.length > 2) {
            phone = [phone substringFromIndex:2];
        } else {
            UserBean *user = [[UserManager shareUserManager] userBean];
            if ([phone rangeOfString:user.defaultDialCountryCode].location != 0) {
                phone = [NSString stringWithFormat:@"%@%@", user.defaultDialCountryCode, phone];
            }
        }
    }
    
    
    // before make sip voice call
    UIViewController *_outgoingCallViewController = [self beforeMakeSipVoiceCall:callee phone:phone callMode:callMode sponsorViewController:sponsorViewController];
    
    // define sip invite state changed protocol implementation
    id<SipInviteStateChangedProtocol> _sipInviteStateChangedImplementation;
    
    // check call mode and get make sip voice call result
    BOOL _makeSipVoiceCallResult = NO;
    switch (callMode) {
        case CALLBACK:
            // request callback sip voice call
            _makeSipVoiceCallResult = [self requestCallbackSipVoiceCall:callee phone:phone processorViewController:_outgoingCallViewController];
            break;
            
        case DIRECT_CALL:
        default:
            // set outgoing call view controller sip implementation 
            [((OutgoingCallViewController *)_outgoingCallViewController) setSipImplementation:self];
            
            // make a sip voice call using sip implementation
            _makeSipVoiceCallResult = [_mSipImplementationProtocolImpl makeSipVoiceCall:callee phone:phone stateChangedProtocolImpl:_sipInviteStateChangedImplementation = [((OutgoingCallViewController *)_outgoingCallViewController) getSipInviteStateChangedImplementation]];
            break;
    }
    
    // after make sip voice call
    [self afterMakeSipVoiceCall:_makeSipVoiceCallResult stateChangedProtocolImpl:_sipInviteStateChangedImplementation];
}

- (BOOL)hangupSipVoiceCall:(long)callDuration{
    NSLog(@"SipBaseImplementation - hangupSipVoiceCall");
    // after hangup current sip voice call, update current sip voice call
    // call record duration
    [self updateSipVoiceCallDuration:callDuration];
    
    // hangup current sip voice call using sip implementation
    return [_mSipImplementationProtocolImpl hangupSipVoiceCall];
}

- (void)setSipVoiceCallUsingLoudspeaker{
    NSLog(@"SipBaseImplementation - setSipVoiceCallUsingLoudspeaker");
    
    UInt32 route = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof(route), &route);
    
}

- (void)setSipVoiceCallUsingEarphone{
    NSLog(@"SipBaseImplementation - setSipVoiceCallUsingEarphone");
    UInt32 route = kAudioSessionOverrideAudioRoute_None;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof(route), &route);
    //
}

// inner extension
- (UIViewController *)beforeMakeSipVoiceCall:(NSString *)calleeName phone:(NSString *)calleePhone callMode:(SipCallMode)callMode sponsorViewController:(UIViewController *)sponsorViewController{
    // insert sip voice call log
    // open Chinese telephone database and checked it
    FMDatabase *_ChineseTelehoneDatabase = [FMDatabase databaseWithPath:[APP_DOCUMENTSPATH stringByAppendingPathComponent:CHINESETELEPHONE_DATABASENAME]];
    if ([_ChineseTelehoneDatabase open]) {
        // insert one call record record to call records table
        if ([_ChineseTelehoneDatabase executeUpdate:[NSString stringWithFormat:INSERTCALLRECORD2CALLRECORDSTABLESTATEMENT, CALLRECORDS_TABLENAME, CALLRECORDSTABLE_NAME_FIELDNAME, CALLRECORDSTABLE_PHONE_FIELDNAME, CALLRECORDSTABLE_DATE_FIELDNAME, CALLRECORDSTABLE_DUDATION_FIELDNAME, CALLRECORDSTABLE_FLAGS_FIELDNAME], calleeName, calleePhone, [NSDate date], [NSNumber numberWithInt:0], [NSNumber numberWithInt:CALLBACK == callMode ? CALLBACKCALL_CALLRECORDSFLAG : OUTGOINGCALL_CALLRECORDSFLAG]]) {
            
            // save current insert sip voice call log id
            _mSipVoiceCallLogId = _ChineseTelehoneDatabase.lastInsertRowId;
        }
        else {
            NSLog(@"insert new call record failed");
        }
    }
    else {
        NSLog(@"open Chinese telephone database failed for insert new call record");
    }
    
    // close Chinese telephone database
    [_ChineseTelehoneDatabase close];
    
    // create and init outgoing call view controller
    OutgoingCallViewController *_outgoingCallViewController = [[OutgoingCallViewController alloc] init];
    
    // set outgoing call sip call mode, phone and its ownnership
    [_outgoingCallViewController setCallMode:callMode phone:calleePhone ownnership:calleeName];
    
    // goto outgoing call view controller
    [sponsorViewController presentModalViewController:_outgoingCallViewController animated:YES];
    
    return _outgoingCallViewController;
}

- (BOOL)requestCallbackSipVoiceCall:(NSString *)calleeName phone:(NSString *)calleePhone processorViewController:(UIViewController *)processorViewController{
    // get callback sip voice call http request processor
    id _callbackSipVoiceCallHttpReqProcessor = [(OutgoingCallViewController *)processorViewController getCallbackSipVoiceCallRequestProcessor];
    
    UserBean *user = [[UserManager shareUserManager] userBean];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:calleePhone, @"callee", user.countryCode, COUNTRYCODE, user.vosphone, @"vosPhoneNumber", user.vosphonePwd, @"vosPhonePassword", nil];

    // send callback sip voice call http request
    [HttpUtils postSignatureRequestWithUrl:CALLBACK_URL andPostFormat:urlEncoded andParameter:params andUserInfo:nil andRequestType:asynchronous andProcessor:_callbackSipVoiceCallHttpReqProcessor andFinishedRespSelector:((OutgoingCallView *)_callbackSipVoiceCallHttpReqProcessor).callbackSipVoiceCallHttpReqFinishedRespSelector andFailedRespSelector:((OutgoingCallView *)_callbackSipVoiceCallHttpReqProcessor).callbackSipVoiceCallHttpReqFailedRespSelector];
    return YES;
}

- (void)afterMakeSipVoiceCall:(BOOL)makeCallResult stateChangedProtocolImpl:(id<SipInviteStateChangedProtocol>)stateChangedProtocolImpl{
    // check make call result and update call failed call record with call log id
    if (!makeCallResult) {
        // check sip invite state changed protocol implementation
        if (nil != stateChangedProtocolImpl) {
            // sip voice call failed
            [stateChangedProtocolImpl onCallFailed];
        }
    }
}

@end
