//
//  GoodsTypeView.h
//  HWDMall
//
//  Created by sk on 2018/11/5.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsTypeSpecBottomCell.h"

typedef void(^shoppingBlock)(NSInteger goodsNum,NSString *address,int skuId);
typedef void(^showBigImgBlock)(void);

@interface GoodsTypeView : UIView

@property (nonatomic, assign) int type;//0 单购 2拼团

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *skuData;
@property (nonatomic, copy) shoppingBlock fuKuanBlock;
@property (nonatomic, copy) showBigImgBlock bigImgBlock;
@property (nonatomic, strong) GoodsTypeSpecBottomCell *bottomCell;

@property(nonatomic,assign)NSInteger btnType; //0 加入购物车 立即购买 1 确定 2不在发货区

- (instancetype) initWithHeight:(CGFloat)height SkuSource:(NSMutableArray *)skuSource SkuList:(NSMutableArray *)skuList MaxPrice:(NSString *)maxPrice MinPrice:(NSString *)minPrice imgStr:(NSString *)imgStr Type:(NSInteger)type CurrentPrice:(CGFloat)currentPrice;

- (void)showAnimating;

@end
