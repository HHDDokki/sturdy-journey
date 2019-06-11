//
//  MyOrderDetailController.h
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BasePayViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderDetailController : BasePayViewController // 我的订单详情



@property (nonatomic,copy) NSString * orderSign; // 订单号

/**
 更新订单UI

 @param parentid 母订单号
 @param orderid 子订单号 单店铺订单必填，多店铺订单为空
 @param ordertype 订单类型
 @param orderstatus 订单状态
 */
- (void)updateOrderDetailMesWithParentOrderID:(NSInteger)parentid
                                   SonOrderID:(NSInteger)orderid
                                    OrderType:(OrderType)ordertype
                                  OrderStatus:(OrderStatus)orderstatus;

@end

NS_ASSUME_NONNULL_END
