//
//  ECSipServiceManager.m
//  uutalk_iphone
//
//  Created by king star on 13-6-7.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECSipServiceManager.h"
#import "CommonToolkit/iToast.h"
#import "pjlib.h"
#import "pjsua.h"
#import "ECConfig.h"


#define PATH_LENGTH	    PJ_MAXPATH

static ECSipServiceManager *instance;
extern pj_bool_t app_restart;


char argv_buf[PATH_LENGTH];
char *argv[] = {""};

@implementation ECSipServiceManager
@synthesize callListener;
@synthesize registerListener;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (ECSipServiceManager *)shareSipServiceManager {
    @synchronized(self) {
        if (instance == nil ) {
            instance = [[ECSipServiceManager alloc] init];
        }
    }
    return instance;
}

- (BOOL)initSipEngine {
    app_restart = PJ_FALSE;
    if (app_init(1, argv) == PJ_SUCCESS) {
       // init success
        // start pjsua
        pj_status_t status = pjsua_start();
        if (status != PJ_SUCCESS) {
            [self destroySipEngine];
            return NO;
        }
        
        
        return YES;
    } else {
        //TODO: init failed
        [self destroySipEngine];
        return NO;
    }
}

- (void)destroySipEngine {
    app_destroy();
}

- (void)registerSipAccount:(SipRegistrationBean *)sipRegisterBean {
    char _id[80], registrar[80], realm[80], uname[80], passwd[30];
    NSString *sipUrl = [NSString stringWithFormat:@"sip:%@@%@", sipRegisterBean.userName, sipRegisterBean.serverAddr];
    
    NSString *registrarUrl = [NSString stringWithFormat:@"sip:%@:%d", sipRegisterBean.serverAddr, sipRegisterBean.port];
    
    strcpy(_id, [sipUrl cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(registrar, [registrarUrl cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(realm, [sipRegisterBean.realm cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(uname, [sipRegisterBean.userName cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(passwd, [sipRegisterBean.password cStringUsingEncoding:NSUTF8StringEncoding]);
    
    printf("_id= %s, registrar= %s, realm= %s, uname= %s, password= %s", _id, registrar, realm, uname, passwd);
    
    pj_status_t status = register_sip_account(_id, registrar, realm, uname, passwd);
    if (status != PJ_SUCCESS) {
        // add account error
        NSLog(@"sip account add failed");
    } else {
        NSLog(@"sip account registered");
    }
}

- (BOOL)makeCall:(NSString *)number {
    NSString *sipNumberUri = [NSString stringWithFormat:@"sip:%@@%@:%d", number, SIP_SERVER, SIP_PORT];
    pj_status_t result = make_call([sipNumberUri cStringUsingEncoding:NSUTF8StringEncoding]);
    if (result != PJ_SUCCESS) {
        [self performSelectorOnMainThread:@selector(onCallStateChange:) withObject:[NSNumber numberWithInt:CALL_FAILED] waitUntilDone:NO];
        return NO;
    }
    return YES;
}

- (void)hangup {
    pjsua_call_hangup_all();
}

- (void)onCallStateChange:(NSNumber *)state {
    EC_CALL_STATE call_state = [state intValue];
    
    switch (call_state) {
        case CALLING: {
//            [[[iToast makeText:@"Calling"] setDuration:iToastDurationNormal] show];
            [self.callListener onCallInitializing];
        }
            break;
        case CALL_ESTABLISHED: {
//            [[[iToast makeText:@"Call Established"] setDuration:iToastDurationNormal] show];
            [self.callListener onCallSpeaking];
        }
            break;
        case CALL_DISCONNECTED: {
//            [[[iToast makeText:@"Call Disconnected"] setDuration:iToastDurationNormal] show];
            [self.callListener onCallTerminated];
        }
            break;
        case CALL_FAILED: {
//            [[[iToast makeText:@"Call failed"] setDuration:iToastDurationNormal] show];
            [self.callListener onCallFailed];
        }
            break;
        case CALL_EARLY: {
//            [[[iToast makeText:@"Call early"] setDuration:iToastDurationNormal] show];
            [self.callListener onCallEarlyMedia];
        }
            break;
        default:
            break;
    }
}

- (void)onRegistrationStateChange:(NSNumber *)regState {
    EC_REG_STATE reg_state = [regState intValue];
    switch (reg_state) {
        case REG_OK:
            [self.registerListener onRegisterSuccess];
            NSLog(@"REG OK");
            break;
        case REG_FAILED:
            [self.registerListener onRegisterFailed];
            NSLog(@"REG FAILED");
            break;
            
        case UNREG_OK:
            break;
            
        case UNREG_FAILED:
            break;
            
        case REGISTERING:
            break;
        default:
            break;
    }
}
@end
