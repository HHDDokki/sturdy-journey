//
//  UITabBar+CustomBadge.h
//  HWDMall
//
//  Created by stewedr on 2018/11/10.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (CustomBadge)

- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点

@end

NS_ASSUME_NONNULL_END
