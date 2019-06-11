//
//  OrderDetaiModel.m
//  HWDMall
//
//  Created by stewedr on 2018/11/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetaiModel.h"

@implementation OrderDetaiModel

@end




@implementation OrderDetaiResultModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"cart":@"OrderDetaiCartModel"
             };
}

@end

@implementation OrderDetaiAddressModel



@end

@implementation OrderDetaiGroupInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"imgGroup":@"OrderDetaiImageModel"
             };
}

@end

@implementation OrderDetaiLogisticsInfoModel



@end

@implementation OrderDetaiOrderTimeModel



@end

@implementation OrderDetaiOrderTitleModel

@end

@implementation OrderDetaiOrderTotalModel



@end

@implementation OrderDetaiImageModel



@end

@implementation OrderDetaiCartModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"goods":@"OrderDetaiGoodsModel"
             };
}

@end

@implementation OrderDetaiGoodsModel



@end



