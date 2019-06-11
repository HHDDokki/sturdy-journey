//
//  BFMallGoodsDetailModel.m
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallGoodsDetailModel.h"

@implementation BFMallBargainGoodsDetailModel

+ (JSONKeyMapper*)keyMapper {
    NSDictionary *dict = @{
                           @"id": @"cut_id",
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation BFMallBargainWinnerListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


@implementation BFMallDetaiServiceListModel


- (CGFloat)nameHeight {
    
    CGSize nameSize = [self.name boundingRectWithSize:CGSizeMake(300*SCALE_750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kFont(15*SCALE_750)} context:nil].size;
    
    return nameSize.height;
}

- (CGFloat)cellHeight {
    
    CGSize size = [self.ser_description boundingRectWithSize:CGSizeMake(310*SCALE_750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kFont(13*SCALE_750)} context:nil].size;
    
    return size.height + self.nameHeight + 16*SCALE_750 + 11*SCALE_750;
    
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper*)keyMapper {
    NSDictionary *dict = @{
                           @"description": @"ser_description",
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end


@implementation BFMallDetailBaseInfoModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


@implementation BFMallDetailShopDetailModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper*)keyMapper {
    NSDictionary *dict = @{
                           @"description": @"shop_description",
                           @"id":@"shopId"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}


@end


/*----------优惠券------------------------------------------------------------------*/

@implementation BFMallDetailCouponModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper*)keyMapper {
    NSDictionary *dict = @{
                           @"id": @"couponId",
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}


@end

@implementation BFMallDetailCouponListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


/*---------拼团-------------------------------------------------------------*/

@implementation BFMallDetailRecommendDetailModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper*)keyMapper {
    NSDictionary *dict = @{
                           @"id": @"usrId",
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end


@implementation BFMallDetailRecommendListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


@implementation BFMallDetailRecommendMainModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


@implementation BFMallGoodsDetailModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
