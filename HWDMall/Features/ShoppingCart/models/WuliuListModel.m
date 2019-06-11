//
//  WuliuListModel.m
//  HWDMall
//
//  Created by stewedr on 2018/12/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "WuliuListModel.h"

@implementation WuliuListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"result":@"WuliuListResultModel"};
}

@end

@implementation WuliuListResultModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orderGoodsList":@"WuliuListGoodsModel"};
}
@end

@implementation WuliuListGoodsModel

@end
