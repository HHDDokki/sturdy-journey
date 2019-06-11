//
//  GVUserDefaults+UserConfig.h
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "GVUserDefaults.h"

typedef enum : NSUInteger {
    Usertype_Visitor = 0, // 游客
    Usertype_Common, // 普通用户
    Usertype_Member // 会员
} UserType;

typedef enum : NSUInteger {
    VipType_No = 0, // 不是会员
    VipType_Now, // 现在是会员
    VipType_NotNow, // 曾经是会员
} VipType;

@interface GVUserDefaults (UserConfig)
@property (nonatomic) BOOL isLogin; // 是否登录
@property (nonatomic) BOOL isVip; // 是否是会员
@property (nonatomic) VipType viptype; // 会员类型
@property (nonatomic) UserType userType;
@property (nonatomic) NSString * token; // token
@property (nonatomic) NSString *userId; // 用户id
@property (nonatomic) NSInteger shopcartcount; // 购物车数量
@property (nonatomic) NSString *outUserCode; // 小能userid
@property (nonatomic) NSString *nickname; // 昵称
@property (nonatomic) NSString *headImg; // 头像地址

- (void)cleanInfos;

@end

