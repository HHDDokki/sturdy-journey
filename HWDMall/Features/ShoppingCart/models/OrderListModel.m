//
//  OrderListModel.m
//  HWDMall
//
//  Created by stewedr on 2018/11/12.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"result":@"OrderlistResultModel"
             };
}

@end

@implementation OrderlistResultModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"shop":@"OrderlistShopModel"
             };
}

@end

@implementation OrderlistShopModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"goods":@"OrderlistGoodsModel"
             };
}

@end

@implementation OrderlistGoodsModel


@end
