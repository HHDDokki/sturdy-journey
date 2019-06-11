//
//  ConfirmOrderController.h
//  HWDMall
//
//  Created by stewedr on 2018/12/4.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BasePayViewController.h"

@interface ConfirmOrderController : BasePayViewController

@property (nonatomic,copy) NSString * sonOrderSign; // 子订单
@property (nonatomic,copy) NSString * parentorderid; // 父订单
@property (nonatomic,assign) NSInteger goodsid; // 商品id
@property (nonatomic,assign) NSInteger groupid;// 拼团id
@property (nonatomic,assign) OrderType ordertype; // 订单类型
@property (nonatomic,assign) BOOL isUnpack;
- (void)updateMesWithOrderSign:(NSString *)ordersign
                    TotalMoney:(CGFloat)totalmoney
                        PayWay:(Payway)payway;

@end

