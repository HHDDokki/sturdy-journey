//
//  ShoppingCartModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShoppingcartGoodsModel;

@interface ShoppingCartModel : NSObject
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSArray * result;
@property (nonatomic, assign) BOOL success;
@end

@interface ShoppingcartGoodsModel : NSObject
@property (nonatomic, assign) NSInteger addTime;
@property (nonatomic, strong) NSString * barCode;
@property (nonatomic, assign) NSInteger cartId; // 购物车id
@property (nonatomic, assign) NSInteger delFlag;
@property (nonatomic, assign) NSInteger goodsId; // 商品id
@property (nonatomic, strong) NSString * goodsName; // 商品名字
@property (nonatomic, assign) NSInteger goodsNum; // 商品数量
@property (nonatomic, assign) CGFloat goodsPrice; // 商品价格
@property (nonatomic, strong) NSString * goodsSn;
@property (nonatomic, strong) NSString * goodsThumb; // 商品缩略图
@property (nonatomic, assign) NSInteger isFirst;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) CGFloat marketPrice;
@property (nonatomic, assign) CGFloat memberPrice;
@property (nonatomic, assign) NSInteger selected; // 是否选中
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, assign) NSInteger shopId; // 店铺id
@property (nonatomic, strong) NSString * shopName; // 店铺名字
@property (nonatomic, assign) NSInteger sku;
@property (nonatomic, strong) NSString * specKey; // 规格
@property (nonatomic, strong) NSString * specKeyName; // 规格
@property (nonatomic, assign) ShopingCartGoodsStatus status; // 商品状态
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) CGFloat normalSinglePrice;
@property (nonatomic, assign) CGFloat vipSinglePrice;

@end

