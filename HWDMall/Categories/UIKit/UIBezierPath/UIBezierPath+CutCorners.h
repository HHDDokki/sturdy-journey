//
//  UIBezierPath+CutCorners.h
//  HWDMall
//
//  Created by HandC1 on 2018/11/21.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (CutCorners)

+ (void)bezierRoundView:(UIView *)view withRadii:(CGSize)size;
+ (void)bezierCutCircleForView:(UIView *)view;
+ (void)bezierTopRoundView:(UIView *)view withRadii:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
