//
//  GoodsTypeSpecBottomCell.h
//  BFMan
//
//  Created by HandC1 on 2019/5/26.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^getGoodsNumBlock)(int goodsNum);

@interface GoodsTypeSpecBottomCell :  UICollectionViewCell

@property (nonatomic, strong) UIButton *conformBtn;

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *subBtn;

@property (copy, nonatomic) getGoodsNumBlock getGoodsNumBlock;


- (void)bindType:(NSInteger)type withAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
