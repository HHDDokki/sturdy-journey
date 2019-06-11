//
//  ConfirmAndCreatOrderModel.m
//  HWDMall
//
//  Created by stewedr on 2018/11/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmAndCreatOrderModel.h"

@implementation ConfirmAndCreatOrderModel


@end

@implementation ConfirmAndCreatorderResultModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"orderList":@"ConfirmAndCreatOrderliseModel"
             };
}


@end

@implementation ConfirmAndCreatOrderliseModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"orderGoodsList":@"ConfirmAndCreatOrderGoodsListModel"
             };
}

@end

@implementation ConfirmAndCreatOrderGoodsListModel



@end
