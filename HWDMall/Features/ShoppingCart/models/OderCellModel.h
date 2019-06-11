//
//  OderCellModel.h
//  HWDMall
//
//  Created by stewedr on 2018/10/18.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OderCellModel : NSObject

@property (nonatomic,assign) ConfirmOrderCellType ordercelltype; // 列表类型
@property (nonatomic,copy) NSString *key;
@property (nonatomic,assign) NSInteger shopid; // 店铺
@property (nonatomic,assign) NSInteger isDefault; // 是否是默认地址
@property (nonatomic,strong) NSString *personname; // 收货人姓名
@property (nonatomic,strong) NSString *personPhone; // 收货人手机号
@property (nonatomic,strong) NSString *personAddress; // 收货人地址
@property (nonatomic,assign) CGFloat sectionHeight; // 组头高度
@property (nonatomic,assign) CGFloat sectionFooterHeight; // 组尾高度
@property (nonatomic,assign) CGFloat ordercellHeight; // 高度
@property (nonatomic,copy) NSString *title; // 标题
@property (nonatomic,copy) NSString *contentMes; // 内容
@property (nonatomic,assign) NSInteger goodsCount; // 商品个数
@property (nonatomic,assign) CGFloat yunfei; // 运费
@property (nonatomic,assign) CGFloat totalPrice; // 总价格
@property (nonatomic,copy) NSString *goodsHeadImage; // 商品头像
@property (nonatomic,copy) NSString *goodsName; // 商品名字
@property (nonatomic,copy) NSString *goodsGuige; // 商品规格
@property (nonatomic,copy) NSString *goodsPrice; // 商品价格
@property (nonatomic,copy) NSString *goodsNum;// 商品个数
@property (nonatomic,assign) NSInteger goodsid; // 商品id


@property (nonatomic, assign) NSInteger isVip;
@property (nonatomic, strong) NSString *savedMoney;
@property (nonatomic, strong) NSString *vipPrice;

@property (nonatomic,strong) NSMutableArray * modelMuarr;
@end

NS_ASSUME_NONNULL_END
