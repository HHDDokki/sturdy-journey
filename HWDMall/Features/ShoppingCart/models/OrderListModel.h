//
//  OrderListModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/12.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@class OrderlistResultModel;
@class OrderlistShopModel;
@class OrderlistGoodsModel;

@interface OrderListModel : BaseModel
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSArray * result;

@end

@interface OrderlistResultModel : BaseModel
@property (nonatomic, strong) NSString * orderSn; // 订单号
@property (nonatomic, assign) OrderStatus orderStatus; // 订单状态
@property (nonatomic, assign) OrderType orderType; // 订单类型
@property (nonatomic, assign) NSInteger parentOrderId;
@property (nonatomic,assign) NSInteger isPaid; // 是否付款
@property (nonatomic, strong) NSArray * shop;
@property (nonatomic, assign) NSInteger totalNum; // 共计数量
@property (nonatomic,assign) NSInteger needNum; // 需要几人
@property (nonatomic,assign) NSInteger unpaidCount; // 差几人
@property (nonatomic, assign) CGFloat totalPrice; // 实付金额
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic,assign) NSInteger isSplit; // 是否多个包裹（判断跳转）
@property (nonatomic,copy) NSString *shippingCode; // 物流编号
@property (nonatomic,assign) NSInteger countdown; // 倒计时
@property (nonatomic,assign) NSInteger groupId; // 拼团id
@property (nonatomic,copy) NSString *timeSourceName; // 倒计时数据源
@property (nonatomic,assign) BOOL isTimeout; // 是否超时
@property (nonatomic, strong) NSString *shippingName; //物流公司名称
@property (nonatomic, assign) NSInteger endTime;


@end

@interface OrderlistShopModel : BaseModel // 店铺
@property (nonatomic, assign) CGFloat freight; // 运费
@property (nonatomic, strong) NSArray * goods;
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, strong) NSString * shopName;
@property (nonatomic, assign) NSInteger sonOrderId;
@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, assign) CGFloat totalPrice;
@end

@interface OrderlistGoodsModel : BaseModel // 商品
@property (nonatomic, assign) CGFloat finalPrice;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, strong) NSString * goodsName;
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, strong) NSString * goodsThumb;//商品缩略图，String
@property (nonatomic, strong) NSString * specKeyName; //商品规格，String
@property (nonatomic, assign) NSInteger  status; //商品状态，int，1退款中，2退款成功，空没有此项

@end
