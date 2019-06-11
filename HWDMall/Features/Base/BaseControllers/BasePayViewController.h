//
//  BasePayViewController.h
//  HWDMall
//
//  Created by 肖旋 on 2018/11/12.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "BaseViewController.h"

@interface BasePayViewController : BaseViewController

//用户取消支付
@property (nonatomic, assign) BOOL isCanceled;

/**
 调取支付
 
 @param orderNo 订单编号
 @param paymentMethod 支付方式，1微信、2支付宝
 */
- (void)payWithOrderNo:(NSString *)orderNo
         paymentMethod:(NSString *)paymentMethod;


/**
 调取购买会员支付

 @param orderNo 订单编号
 @param paymentMethod 支付方式，1微信、2支付宝
 */
- (void)payWithOrderVipNo:(NSString *)orderNo paymentMethod:(NSString *)paymentMethod;
/**
 支付回调
 
 @param success YES成功 NO失败
 @param channel 支付方式，1微信、2支付宝
 */
- (void)paySuccess:(BOOL)success channel:(NSString *)channel;

/**
 支付宝支付

 @param orderString 签名后的订单请求串
 @param success web支付成功回调（这是网页支付回调，APP支付回调在）
 @param failure web支付失败回调
 */
- (void)alipayPayWithOrder:(NSString *)orderString
                   success:(void (^)(void))success
                   failure:(void (^)(void))failure;

/**
 微信支付

 @param payReq 微信支付request对象
 */
- (void)wechatPayWithPayReq:(PayReq *)payReq;

/**
 微信支付回调

 @param success YES成功 NO失败
 */
- (void)wechatPaySuccess:(BOOL)success;

@end
