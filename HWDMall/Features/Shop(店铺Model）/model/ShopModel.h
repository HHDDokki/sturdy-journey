//
//  ShopModel.h
//  HWDMall
//
//  Created by HandC1 on 2018/11/26.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ShopCategoryDetailModel
@end
@protocol ShopCategoryModel
@end

@interface ShopCategoryDetailModel : JSONModel

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *categoryCount;

@end


@interface ShopCategoryModel : JSONModel

@property (nonatomic, strong) NSMutableArray<ShopCategoryDetailModel> *result;

@end


@interface ShopModel : JSONModel

//该用户是否收藏该店铺 String 1已收藏,0未收藏
@property (nonatomic, strong) NSString *isEnshrine;

@property (nonatomic, strong) NSString *shopMessage;

@property (nonatomic, strong) NSString *shopName;

@property (nonatomic, strong) NSString *shopHeadImg;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, assign) int shopId;


@end

NS_ASSUME_NONNULL_END
