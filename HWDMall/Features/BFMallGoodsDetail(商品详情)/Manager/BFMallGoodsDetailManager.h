//
//  BFMallGoodsDetailManager.h
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFMallGoodsDetailController.h"

NS_ASSUME_NONNULL_BEGIN

@class BFMallGoodsDetailController;

typedef void(^PictureAciontBlock)(NSUInteger actionIndex, NSArray<NSString *> *arr);
typedef void(^ToBeVipBlock)(void);

@interface BFMallGoodsDetailManager : NSObject
//大图点击
@property (nonatomic, copy) PictureAciontBlock pictureBlock;
//成为会员
@property (nonatomic, copy) ToBeVipBlock toBeVipBlock;

@property (nonatomic, weak) BFMallGoodsDetailController *baseController;


- (void)configWithModel:(NSMutableArray *)modelArr;
- (CGFloat)heightForRowAtIndex:(NSInteger)index;
- (UIView *)setupHeaderScroll;
- (UIView *)setupNamePriceView;
- (UIImageView *)createDetailImageViewWithIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
