//
//  UpdateTotalPriceModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCartModel.h"

@class UpdateTotalResultModel;
@class UpdateShopModel;

@interface UpdateTotalPriceModel : NSObject
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) UpdateTotalResultModel * result;
@property (nonatomic, assign) BOOL success;
@end

@interface UpdateTotalResultModel : NSObject
@property (nonatomic, strong) NSArray * cartList;
@property (nonatomic, strong) NSArray * shopList;
@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, assign) NSInteger selectedNum; // 选中商品个数
@property (nonatomic,assign) NSInteger validNum; // 该购物车有效项数
@property (nonatomic, assign) NSInteger isVipUser;
@property (nonatomic, assign) CGFloat buyVipPrice;
@property (nonatomic, assign) CGFloat savePrice;

@end

@interface UpdateShopModel : NSObject

@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, assign) NSInteger shopSelected;

@end


