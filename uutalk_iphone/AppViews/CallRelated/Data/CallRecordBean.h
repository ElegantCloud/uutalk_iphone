//
//  CallRecordBean.h
//  ChineseTelephone
//
//  Created by Ares on 13-6-19.
//  Copyright (c) 2013年 richitec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonToolkit/CommonToolkit.h>

// call record call type
typedef NS_ENUM(NSInteger, CallRecordCallType){
    // outgoing call, incoming call, missed incoming call, callback call
    OUTGOINGCALL = OUTGOINGCALL_CALLRECORDSFLAG, INCOMINGCALL, MISSED_INCOMINGCALL, CALLBACKCALL = CALLBACKCALL_CALLRECORDSFLAG
};

@interface CallRecordBean : NSObject

// call record row id
@property (nonatomic, assign) sqlite_int64 rowId;
// call record call name
@property (nonatomic, retain) NSString *name;
// call record call phone
@property (nonatomic, retain) NSString *phone;
// call record call date
@property (nonatomic, retain) NSDate *date;
// call record call duration
@property (nonatomic, assign) long duration;
// call record call type
@property (nonatomic, assign) CallRecordCallType callType;

// get call record call type name with call type
+ (NSString *)getCallTypeName:(CallRecordCallType)callType;

// get call record call type image with call type
+ (UIImage *)getCallTypeImage:(CallRecordCallType)callType;

@end
