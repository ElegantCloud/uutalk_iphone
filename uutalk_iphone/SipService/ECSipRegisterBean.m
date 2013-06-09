//
//  ECSipRegisterBean.m
//  uutalk_iphone
//
//  Created by king star on 13-6-8.
//  Copyright (c) 2013年 king star. All rights reserved.
//

#import "ECSipRegisterBean.h"

@implementation ECSipRegisterBean
@synthesize sipServer = _sipServer;
@synthesize sipUserName = _sipUserName;
@synthesize sipPwd = _sipPwd;
@synthesize sipRealm = _sipRealm;
@synthesize sipPort = _sipPort;

- (id)init {
    self = [super init];
    if (self) {
        self.sipPort = [NSNumber numberWithInt:7788];
    }
    return self;
}

@end
