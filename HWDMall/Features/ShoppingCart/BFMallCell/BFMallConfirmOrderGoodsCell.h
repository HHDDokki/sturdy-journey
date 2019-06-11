//
//  BFMallConfirmOrderGoodsCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/27.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMallConfirmOrderGoodsCell : UITableViewCell


- (void)updateCellMesWithHeadUrl:(NSString *)goodshead
                       GoodsName:(NSString *)goodsname
                      GoodsGuige:(NSString *)goodsguige
                      GoodsPrice:(NSString *)goodsprice
                        GoodsNum:(NSString *)goodsnum
                   GoodsVipPrice:(NSString *)vipPrice;


// 订单详情
- (void)updateCellMesWithGoodsImge:(NSString *)goodsimage GoodsName:(NSString *)goodsname GoodsGuige:(NSString *)guige GoodsPrice:(NSString *)goodsprice GoodsCount:(NSString *)count TuikanStatus:(NSString *)tuikuanstatus GoodsVipPrice:(NSString *)vipPrice;



// 订单列表
- (void)updateGoodsMesWithHeadImage:(NSString *)headerurl
                          Goodsname:(NSString *)goodsname
                         Goodsprice:(CGFloat)price
                         GoodsGuige:(NSString *)guige
                           GoodsNum:(NSInteger)goodsnum
                       TuikanStatus:(NSInteger)tuikuanstatus;


@end

NS_ASSUME_NONNULL_END
