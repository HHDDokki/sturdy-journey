//
//  GetShopCarModel.h
//  HWDMall
//
//  Created by stewedr on 2018/12/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetShopCartResultModel;

@interface GetShopCarModel : NSObject

@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) GetShopCartResultModel * result;

@end

@interface GetShopCartResultModel : NSObject
@property (nonatomic, assign) NSInteger cartCount;
@end

