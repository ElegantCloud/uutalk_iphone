//
//  ECSipServiceManager.m
//  uutalk_iphone
//
//  Created by king star on 13-6-7.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECSipServiceManager.h"
#import "pjlib.h"
#import "pjsua.h"
#import "ECConfig.h"

#define PATH_LENGTH	    PJ_MAXPATH

static ECSipServiceManager *instance;
extern pj_bool_t app_restart;


char argv_buf[PATH_LENGTH];
char *argv[] = {""};

@implementation ECSipServiceManager

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

- (void)initSipEngine {
    app_restart = PJ_FALSE;
    if (app_init(1, argv) == PJ_SUCCESS) {
       // init success
        // start pjsua
        pj_status_t status = pjsua_start();
        if (status != PJ_SUCCESS) {
            [self sipEngineInitFailed];
            return;
        }
        
        
        
    } else {
        //TODO: init failed
        [self sipEngineInitFailed];
    }
}

- (void)sipEngineInitFailed {
    app_destroy();
}

- (void)registerSipAccount:(ECSipRegisterBean *)sipRegisterBean {
    char _id[80], registrar[80], realm[80], uname[80], passwd[30];
    NSString *sipUrl = [NSString stringWithFormat:@"sip:%@@%@", sipRegisterBean.sipUserName, sipRegisterBean.sipServer];
    
    NSString *registrarUrl = [NSString stringWithFormat:@"sip:%@:%d", sipRegisterBean.sipServer, sipRegisterBean.sipPort.intValue];
    
    strcpy(_id, [sipUrl cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(registrar, [registrarUrl cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(realm, [sipRegisterBean.sipRealm cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(uname, [sipRegisterBean.sipUserName cStringUsingEncoding:NSUTF8StringEncoding]);
    strcpy(passwd, [sipRegisterBean.sipPwd cStringUsingEncoding:NSUTF8StringEncoding]);
    
    printf("_id= %s, registrar= %s, realm= %s, uname= %s, password= %s", _id, registrar, realm, uname, passwd);
    
    pj_status_t status = register_sip_account(_id, registrar, realm, uname, passwd);
    if (status != PJ_SUCCESS) {
        // add account error
        NSLog(@"sip account add failed");
    } else {
        NSLog(@"sip account registered");
    }
}

- (void)makeCall:(NSString *)number {
    NSString *sipNumberUri = [NSString stringWithFormat:@"sip:%@@%@:%d", number, SIP_SERVER, SIP_PORT];
    make_call([sipNumberUri cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
