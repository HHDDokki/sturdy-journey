//
//  ThirdMacros.h
//  HWDMall
//
//  Created by stewedr on 2018/10/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

//友盟统计SDK的key
#define kUmengKey @""

//友盟分享
//--微信
//#define kSocial_WX_ID       @"wx5849309e0a11c971" // 正式环境
#define kSocial_WX_ID    @"wx89717bd12d427d90"
#define kSocial_WX_Secret @"3b166441481e0678d9ce1b402fcdab82"
#define kSocial_WX_Url @"http://www.umeng.com/social"
//--QQ
#define kSocial_QQ_ID  @""
#define kSocial_QQ_Secret @""
#define kSocial_QQ_Url @""
//--新浪微博
#define kSocial_Sina_Account @""
#define kSocial_Sina_RedirectURL @""

#pragma mark -- 微信登录
#pragma mark -- 微信官方接口
#define WxForAccess_token @"https://api.weixin.qq.com/sns/oauth2/access_token"
#define WxForRefresh_token @"https://api.weixin.qq.com/sns/oauth2/refresh_token"
#define WxForAccess_tokenIsUseful @"https://api.weixin.qq.com/sns/auth?access_token"
#define WXForUserInfo @"https://api.weixin.qq.com/sns/userinfo"

#define WXKey_appid @"appid"
#define WXKey_secret @"secret"
#define WXKey_code @"code"
#define WXKey_grant_type @"grant_type"
#define WXKey_grant_typevalue @"authorization_code"

#endif /* ThirdMacros_h */
