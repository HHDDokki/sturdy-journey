//
//  ConfirmOrderViewController.h
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BasePayViewController.h"

@interface ConfirmOrderViewController : BasePayViewController

@property (nonatomic) BOOL isSelecVip;


/**
 创建订单参数

 @param ordertype  OrderType_Mall = 1, // 非活动 OrderType_Kanjia, // 砍价 OrderType_Pintuan // 拼团
 @param buytype  BuyType_shopcart = 1, // 购物车 BuyType_Noshopcart, // 非购物车
 @param sku 商品标识 （当buyType=0时必传）
 @param quantity 商品数量 （当buyType=0时必传）
 @param grouponid 优惠券，非必填
 @param goodsaddress 地址，非必填
 @param usecoin 是否使用待金币，非必填
 @param foundid 拼团ID，非必填（拼团团员必填）
 @param activity 活动ID，非必填（活动订单必填）
 */
- (void)commitOrderMessWith:(OrderType)ordertype
                    BuyType:(BuyType)buytype
                        Sku:(NSInteger)sku
                   Quantity:(NSInteger)quantity
                  Grouponid:(NSInteger)grouponid
                    Address:(NSString *)goodsaddress
                    UseCoin:(BOOL)usecoin
                    Foundid:(NSInteger)foundid
                 Activityid:(NSInteger)activity
                    GoodsID:(NSInteger)goodsid;

@end

