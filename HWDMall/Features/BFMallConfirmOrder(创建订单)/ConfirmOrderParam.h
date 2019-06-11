//
//  ConfirmOrderParam.h
//  HWDMall
//
//  Created by HandC1 on 2018/12/8.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderParam : NSObject

@property (nonatomic, strong) NSMutableDictionary *attributeDic;
@property (nonatomic, assign) OrderType ordertype;
@property (nonatomic, assign) BuyType buytype;
@property (nonatomic, assign) NSInteger sku;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, assign) NSInteger grouponId;
@property (assign) BOOL usecoin;
@property (nonatomic, assign) NSInteger addressId;
@property (nonatomic, assign) NSInteger foundId;
@property (nonatomic, assign) NSInteger activity;

@property (nonatomic, assign) Payway payType;
@property (nonatomic, assign) NSInteger goodsId;

- (void)setAllProperValueExceptPayWay;
- (void)setAllProperValueWithPayWay;

@end

NS_ASSUME_NONNULL_END
