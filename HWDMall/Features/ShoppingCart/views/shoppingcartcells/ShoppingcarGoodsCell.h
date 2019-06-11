//
//  ShoppingcarGoodsCell.h
//  HWDMall
//
//  Created by stewedr on 2018/11/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,RoundCornerType)
{
    KKRoundCornerCellTypeTop,
    KKRoundCornerCellTypeBottom,
    KKRoundCornerCellTypeSingleRow,
    KKRoundCornerCellTypeDefault
};

typedef void(^SelectedCellBlock)(BOOL cellStatus);
typedef void(^ChangeCountBlock)(NSInteger count);

@interface ShoppingcarGoodsCell : UITableViewCell
@property (nonatomic,copy) SelectedCellBlock selectBlock;
@property(nonatomic,readwrite,assign)RoundCornerType roundCornerType;
@property (nonatomic,assign) BOOL isEditing; // 正在编辑
@property (nonatomic,assign) NSInteger cartid; // 购物车id
@property (nonatomic,copy) ChangeCountBlock changcountblockBlock;
@property (nonatomic,assign) ShopingCartGoodsStatus shopgoodsStatus; // 购物车商品状态



/**
 购物车商品cell

 @param headurl 商品图
 @param goodsname 商品名字
 @param goodsguige 商品规格
 @param goodsprice 商品价格
 @param goodscount 商品数量
 @param unuse 是否可用
 */
- (void)updateCellMesWithHeadUrl:(NSString *)headurl GoodsName:(NSString *)goodsname GoodsGuige:(NSString *)goodsguige GoodsPrice:(NSString *)goodsprice GoodsCount:(NSInteger)goodscount GoodsUnuse:(BOOL)unuse GoosSeletedStatus:(BOOL)isseleted normalSinglePrice:(NSString *)normalPrice VipPrice:(NSString *)vipPrice;

@end

NS_ASSUME_NONNULL_END
