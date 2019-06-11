//
//  ShoppingCartCustomModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartCustomModel : NSObject

@property (nonatomic,copy) NSString * shopName; // 店铺名字
@property (nonatomic,assign) NSInteger shopid; // 店铺id
@property (nonatomic,assign) BOOL isUsable; // 可用的
@property (nonatomic,assign) BOOL isSelectedStatus;
@property (nonatomic,strong) NSMutableArray * shopGoodMuarr; // 店铺商品数组

@end

