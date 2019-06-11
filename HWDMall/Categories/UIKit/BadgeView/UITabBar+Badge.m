//
//  UITabBar+Badge.m
//  Join
//
//  Created by silan on 16/10/4.
//  Copyright © 2016年 Join. All rights reserved.
//

#import "UITabBar+Badge.h"
#import "BadgeView.h"
#import <objc/runtime.h>

#define TabbarItemNums  5.0    //tabbar的数量 如果是5个设置为5

@interface UITabBar ()

@property (nonatomic, strong) NSMutableDictionary *badgeDict;

@end

@implementation UITabBar (Badge)

- (NSMutableDictionary *)badgeDict {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [NSMutableDictionary dictionaryWithCapacity:0];
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN);
    }
    
    return dict;
}

- (BadgeView *)badgeViewAtIndex:(NSInteger)index {
    BadgeView *badgeView =  [self.badgeDict objectForKey:@(index)];
    if (!badgeView && self.items.count > 0) {
        
        /*
         //新建小红点
         UIView *badgeView = [[UIView alloc]init];
         badgeView.tag = 888 + index;
         badgeView.layer.cornerRadius = 5.0;//圆形
         badgeView.backgroundColor = [UIColor clearColor];//颜色：红色
         badgeView.layer.borderWidth = 1;
         badgeView.layer.borderColor = kMainRedColor.CGColor;
         CGRect tabFrame = self.frame;
         
         //确定小红点的位置
         CGFloat percentX = (index + 0.6) / TabbarItemNums;
         CGFloat x = ceilf(percentX * tabFrame.size.width);
         CGFloat y = ceilf(0.1 * tabFrame.size.height);
         badgeView.frame = CGRectMake(x, y, 20.0, 10.0);//圆形大小为10
         badgeView.clipsToBounds = YES;
         [self addSubview:badgeView];
         */
        
        badgeView = [[BadgeView alloc] init];
        CGRect tabFrame = self.frame;
        CGFloat percentX = (index + 0.6) / TabbarItemNums;
        CGFloat x = ceilf(percentX * tabFrame.size.width);
        CGFloat y = ceilf(0.05 * tabFrame.size.height);
        badgeView.frame = CGRectMake(x, y, 20.0, 20.0);//圆形大小为10
        badgeView.clipsToBounds = YES;
        
        [self addSubview:badgeView];
        
        [self.badgeDict setObject:badgeView forKey:@(index)];
    }
    
    return badgeView;
}

- (void)updateBadge:(NSString *)badgeValue bgColor:(UIColor *)bgColor atIndex:(NSInteger)index {
    if (index >= 0 && index < self.items.count) {
        BadgeView *badgeView = [self badgeViewAtIndex:index];
        
        if (badgeView) {
            badgeView.bgColor = bgColor;
            badgeView.badgeValue = badgeValue;
        }
    }
}

- (void)updateBadge:(NSString *)badgeValue atIndex:(NSInteger)index {
    if (index >= 0 && index < self.items.count) {
        BadgeView *badgeView = [self badgeViewAtIndex:index];
        
        if (badgeView) {
            badgeView.badgeValue = badgeValue;
        }
    }
}

- (void)updateBadgeTextColor:(UIColor *)textColor atIndex:(NSInteger)index {
    if (index >= 0 && index < self.items.count) {
        BadgeView *badgeView = [self badgeViewAtIndex:index];

        if (badgeView) {
            badgeView.textColor = textColor;
        }
    }
}

- (void)updateBadgeBgColor:(UIColor *)bgColor atIndex:(NSInteger)index {
    if (index >= 0 && index < self.items.count) {
        BadgeView *badgeView = [self badgeViewAtIndex:index];

        if (badgeView) {
            badgeView.bgColor = bgColor;
        }
    }
}

- (void)updateBadgeTextFont:(UIFont *)textFont atIndex:(NSInteger)index {
    if (index >= 0 && index < self.items.count) {
        BadgeView *badgeView = [self badgeViewAtIndex:index];

        if (badgeView) {
            badgeView.textFont = textFont;
        }
    }
}

- (void)updateBadgeLayerColor:(UIColor *)layerColor atIndex:(NSInteger)index{
    if (index >= 0 && index < self.items.count) {
        BadgeView *badgeView = [self badgeViewAtIndex:index];
        
        if (badgeView) {
            badgeView.layer.borderWidth = 1;
            badgeView.layer.borderColor = layerColor.CGColor;
        }
    }
}

- (void)removeBadgeAtIndex:(NSInteger)index {
    BadgeView *badgeView = [self badgeViewAtIndex:index];
    [badgeView removeFromSuperview];
    [self.badgeDict removeObjectForKey:@(index)];
    badgeView = nil;
}

@end
