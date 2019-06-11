//
//  UILabel+TimeDown.h
//  HWDMall
//
//  Created by stewedr on 2018/10/25.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (TimeDown)
-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle timeStringColor:(UIColor *)timeColor;
@end

NS_ASSUME_NONNULL_END
