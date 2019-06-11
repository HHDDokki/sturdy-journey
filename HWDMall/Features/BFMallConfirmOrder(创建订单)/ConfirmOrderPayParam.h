//
//  ConfirmOrderPayParam.h
//  HWDMall
//
//  Created by HandC1 on 2019/1/8.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderPayParam : NSObject

//@property (nonatomic, strong) NSMutableDictionary *attributeDic;

@property (nonatomic,copy) NSString * sonOrderSign; // 子订单
@property (nonatomic,copy) NSString * parentorderid; // 父订单
@property (nonatomic,assign) NSInteger goodsid; // 商品id
@property (nonatomic,assign) NSInteger groupid;// 拼团id
@property (nonatomic,assign) OrderType ordertype; // 订单类型
@property (nonatomic,assign) BOOL isUnpack;

@property (nonatomic,copy) NSString * ordersign; // 子订单
@property (nonatomic,assign) CGFloat totoalmoney;
@property (nonatomic,assign) Payway payway;

@end

NS_ASSUME_NONNULL_END
