//
//  WuliuListModel.h
//  HWDMall
//
//  Created by stewedr on 2018/12/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseModel.h"

@class WuliuListResultModel;
@class WuliuListGoodsModel;

typedef enum : NSUInteger {
    WuliuType_Wuguiji = 0,
    WuliuType_Yilanshou,
    WuliuType_Zaituzhong,
    WuliuType_Yiqianshou,
    WuliuType_Wentijian,
} WuliuType;

@interface WuliuListModel : BaseModel

@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSArray * result;

@end

@interface WuliuListResultModel : BaseModel

@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, strong) NSString * logisticsContent;
@property (nonatomic, strong) NSString * logisticsTime;
@property (nonatomic, strong) NSArray * orderGoodsList;
@property (nonatomic, strong) NSString * shippingCode;
@property (nonatomic, strong) NSString * shippingName;
@property (nonatomic, assign) WuliuType state;

@end

@interface WuliuListGoodsModel : BaseModel
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, strong) NSString * goodsThumb;
@end

