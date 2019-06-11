//
//  BFMallDetailBottomBar.h
//  BFMan
//
//  Created by HandC1 on 2019/5/26.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMallGoodsDetailModel.h"

typedef enum : NSInteger {
    BuyStateDanPin  = 0,//单购拼团
    BuyStateAddLiJi = 1,//加入购物车立即购买
    BuyStateKaiTong = 2 ,//开通会员
    BuyStateNo = 3//卖没了
} BuyState;

NS_ASSUME_NONNULL_BEGIN
@protocol OpenCusDelegate <NSObject>

- (void)openCus:(NSInteger)tag;

@end

typedef void(^openShoppingCartBlock)(void);

@interface BFMallDetailBottomBar : UIView
//打开购物车
@property(nonatomic,copy)openShoppingCartBlock openGWCBlock;
@property (nonatomic, assign) id <OpenCusDelegate> delegate;


@property (nonatomic, strong) UIButton *shoppingCartBtn;

@property (nonatomic, strong) UIButton *rLeftBtn;
@property (nonatomic, strong) UIButton *rRightBtn;
@property (nonatomic, strong) UIButton *rOneBtn;

- (void)bindModel:(BFMallGoodsDetailModel *)model carCount:(NSString *)cartCount BuyState:(BuyState)type;


@end

NS_ASSUME_NONNULL_END
