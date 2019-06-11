//
//  BFMallPayBottomBar.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PayBtnBlock)(void);

@interface BFMallPayBottomBar : UIView
@property (nonatomic,copy) PayBtnBlock payBlock;
@property (nonatomic,copy) NSString * totalMoney; // 商品总额
@property (nonatomic,assign) BOOL isCanDeliver; // 是否可以运输

- (void)setUI;

@end

NS_ASSUME_NONNULL_END
