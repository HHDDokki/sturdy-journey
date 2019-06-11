//
//  UIButton+Badge.h
//  HWDMall
//
//  Created by sk on 2018/11/7.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Badge)
- (void)setBadge:(NSString *)number andFont:(int)font;
- (void)setBadge:(NSString *)number andFont:(int)font cornerRadius:(CGFloat)cornerRadius;

@end
