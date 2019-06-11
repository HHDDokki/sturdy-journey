//
//  GVUserDefaults+UserConfig.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "GVUserDefaults+UserConfig.h"

@implementation GVUserDefaults (UserConfig)
@dynamic isLogin;
@dynamic isVip;
@dynamic token;
@dynamic userType;
@dynamic userId;
@dynamic shopcartcount;
@dynamic viptype;
@dynamic outUserCode;
@dynamic nickname;
@dynamic headImg;

- (void)cleanInfos {
    self.isLogin = NO;
    self.isVip = NO;
    self.token = nil;
    self.userType = 0;
    self.userId = nil;
    self.shopcartcount = 0;
    self.viptype = 0;
    self.outUserCode = nil;
    self.nickname = nil;
    self.headImg = nil;
}

@end
