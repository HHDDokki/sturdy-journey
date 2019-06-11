//
//  ConfirmAndCreatOrderModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ConfirmAndCreatorderResultModel;
@class ConfirmAndCreatOrderliseModel;
@class ConfirmAndCreatOrderGoodsListModel;
@class ConfirmUserVipPriceModel;

@interface ConfirmAndCreatOrderModel : NSObject

@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) ConfirmAndCreatorderResultModel * result;
@property (nonatomic, assign) BOOL success;

@end

@interface ConfirmAndCreatorderResultModel : NSObject
@property (nonatomic,strong) NSString *orderSn; // 订单号
@property (nonatomic,assign) NSInteger orderId; // 子订单号
@property (nonatomic, assign) CGFloat coinPrice;// 待金币扣减金额
@property (nonatomic, assign) CGFloat couponPriceSys;// 优惠券扣减金额
@property (nonatomic, assign) CGFloat goodsPrice; // 商品总价
@property (nonatomic, assign) NSInteger isCanDeliver; // 是否能配送  1 可配送，0 不可配送
@property (nonatomic, assign) CGFloat orderAmount; // 实付金额
@property (nonatomic, strong) NSArray * orderList; // 商户订单
@property (nonatomic, assign) OrderType promType; // 订单类型
@property (nonatomic, assign) CGFloat shippingPrice; //运费
@property (nonatomic, assign) CGFloat totalAmount; //订单总价
@property (nonatomic, assign) CGFloat savePrice; //vip可省
@property (nonatomic, assign) NSInteger isVipUser;
@property (nonatomic, assign) NSInteger userCoin; //可使用待金币数量
@property (nonatomic, assign) CGFloat userCoinPrice; //可使用待金币金额
@property (nonatomic,assign) CGFloat freight;
@property (nonatomic, strong) NSDictionary *userVipPrice;



@end

@interface ConfirmAndCreatOrderliseModel : NSObject  // 店铺
@property (nonatomic, assign) CGFloat coinPrice;
@property (nonatomic,copy) NSString *orderSn; // 子订单
@property (nonatomic,assign) NSInteger orderId; // 子订单号
@property (nonatomic, assign) CGFloat couponPriceSys;
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, assign) CGFloat goodsPrice;
@property (nonatomic, assign) CGFloat orderAmount;
@property (nonatomic, strong) NSArray * orderGoodsList;
@property (nonatomic, assign) NSInteger promType;
@property (nonatomic, assign) CGFloat shippingPrice; // 价格
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic,assign) NSInteger orderPromId; // 拼团id
@property (nonatomic, strong) NSString * shopName;
@property (nonatomic, assign) CGFloat totalAmount;
@property (nonatomic,assign) CGFloat freight;

@end


@interface ConfirmAndCreatOrderGoodsListModel : NSObject // 商品model
@property (nonatomic, assign) CGFloat coinPrice;
@property (nonatomic, assign) CGFloat couponPriceSys;
@property (nonatomic, assign) CGFloat finalPrice;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, strong) NSString * goodsName;
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, assign) CGFloat goodsPrice;
@property (nonatomic, strong) NSString * goodsSn;
@property (nonatomic, strong) NSString * goodsThumb;
@property (nonatomic, assign) CGFloat normalPrice;
@property (nonatomic, assign) NSInteger promType;
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, assign) NSInteger sku;
@property (nonatomic, strong) NSString * specKey;
@property (nonatomic, strong) NSString * specKeyName;
@property (nonatomic, assign) NSInteger orderId;

@property (nonatomic, assign) NSInteger isVip;
@property (nonatomic, assign) NSInteger promPriceSys;
@property (nonatomic, assign) CGFloat subtotal;
@property (nonatomic, assign) CGFloat vipPrice;

@end


@interface ConfirmUserVipPriceModel : NSObject

@property (nonatomic, assign) CGFloat createTime;
@property (nonatomic, assign) CGFloat deadline;
@property (nonatomic, assign) CGFloat normalPrice;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) CGFloat updateTime;
@property (nonatomic, assign) CGFloat vipPrice;

@end

