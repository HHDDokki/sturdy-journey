//
//  OrderDetailManager.h
//  HWDMall
//
//  Created by stewedr on 2018/11/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderDetaiModel;
@class OrderDetaiResultModel;

@interface OrderDetailManager : NSObject

/**
 根据返回的数据、订单状态、订单类型进行UI排版

 @param model 订单数据模型
 @param type 订单类型
 @param status 订单状态
 @return UI排版数组
 */
- (NSArray *)setOrderDetailUIWithModel:(OrderDetaiResultModel *)model
                             OrderType:(OrderType)type
                           OrderStatus:(OrderStatus)status;
@end


