//
//  OrderDetaiModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderDetaiResultModel;
@class OrderDetaiAddressModel;
@class OrderDetaiGroupInfoModel;
@class OrderDetaiLogisticsInfoModel;
@class OrderDetaiOrderTimeModel;
@class OrderDetaiOrderTitleModel;
@class OrderDetaiOrderTotalModel;
@class OrderDetaiImageModel;
@class OrderDetaiCartModel;
@class OrderDetaiGoodsModel;

@interface OrderDetaiModel : NSObject

@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) OrderDetaiResultModel * result;
@property (nonatomic, assign) BOOL success;

@end

@interface OrderDetaiResultModel :NSObject
@property (nonatomic, strong) OrderDetaiAddressModel * addressInfo; // 收货地址
@property (nonatomic, strong) NSArray * cart; // 商品(店铺)
@property (nonatomic, strong) OrderDetaiGroupInfoModel * groupInfo;
@property (nonatomic, strong) OrderDetaiLogisticsInfoModel * logisticsInfo; // 物流信息
@property (nonatomic, strong) OrderDetaiOrderTimeModel * orderTime; // 订单信息（时间、支付方式）
@property (nonatomic, strong) OrderDetaiOrderTitleModel * orderTitle;//(订单类型)
@property (nonatomic, strong) OrderDetaiOrderTotalModel * orderTotal;// (运费、实付款。。。)
@end

@interface OrderDetaiAddressModel : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * receiver;

@end

@interface OrderDetaiGroupInfoModel : NSObject
@property (nonatomic, assign) NSInteger groupId; // 拼团id
@property (nonatomic, assign) GroupStatus groupStatus; // 拼团状态
@property (nonatomic, strong) NSArray * imgGroup; // 拼团头像
@property (nonatomic, assign) NSInteger shareNum; // 还需分享人数
@property (nonatomic, assign) NSInteger unpaidCount; // 未付款人数
@end

@interface OrderDetaiLogisticsInfoModel : NSObject
@property (nonatomic, strong) NSString * logisticsContent; // 最新物流信息
@property (nonatomic, assign) NSInteger isSplit; // 是否多个包裹
@property (nonatomic, copy) NSString *shippingCode;// 物流编号
@property (nonatomic, copy) NSString * logisticsTime; // 物流时间秒数
@property (nonatomic, copy) NSString *shippingName;
@end

@interface OrderDetaiOrderTimeModel : NSObject
@property (nonatomic, assign) NSInteger createTime; // 下单时间
@property (nonatomic, assign) NSInteger groupTime; // 拼单时间
@property (nonatomic, strong) NSString * orderSn; // 订单编号
@property (nonatomic, assign) Payway pwName; // 支付方式
@end

@interface OrderDetaiOrderTitleModel : NSObject
@property (nonatomic, assign) NSInteger countdown; // 截止时间
@property (nonatomic, assign) OrderStatus orderStatus; //
@property (nonatomic, assign) OrderType orderType;
@property (nonatomic, assign) NSInteger parentOrderId;
@property (nonatomic,copy) NSString *orderTips; //
@property (nonatomic,assign) NSInteger isPaid;// 是否付款


@end

@interface OrderDetaiOrderTotalModel : NSObject
@property (nonatomic, assign) CGFloat actualPay; // 实付款
@property (nonatomic, assign) CGFloat amount; // 商品总额
@property (nonatomic, assign) CGFloat coin; // 金豆抵用
@property (nonatomic, assign) CGFloat coupon; // 优惠券
@property (nonatomic, assign) CGFloat freight; // 运费
@end

@interface OrderDetaiImageModel : NSObject
@property (nonatomic, strong) NSString * headPic;
@property (nonatomic, assign) NSInteger isLeader;// 是否团长 1是 0不是
@end

@interface OrderDetaiCartModel : NSObject  // 店铺

@property (nonatomic, assign) CGFloat freight; // 运费
@property (nonatomic, strong) NSArray * goods;
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, strong) NSString * shopName;
@property (nonatomic, assign) NSInteger sonOrderId;
@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, assign) CGFloat totalPrice; // 小计金额

@end

@interface OrderDetaiGoodsModel : NSObject
@property (nonatomic, assign) CGFloat finalPrice; // 商品单价
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, strong) NSString * goodsName;
@property (nonatomic, assign) NSInteger goodsNum; // 选择数量
@property (nonatomic, strong) NSString * goodsThumb; // 缩略图
@property (nonatomic, strong) NSString * specKeyName; // 规格
@property (nonatomic, assign) GoodsStatus status;  // 商品状态
@property (nonatomic, assign) CGFloat vipPrice;
@end

