//
//  BFMallDetailRightPopView.h
//  BFMan
//
//  Created by HandC1 on 2019/5/22.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMallModuleBtn.h"

#define TYPE_SHOPPINGCART      @"1008"
#define TYPE_MYORDER           @"1009"
#define TYPE_MYCOLLECTION      @"1010"
#define TYPE_ADDRESS_MANAGER   @"1011"
#define TYPE_BUY_VIP           @"1000"

NS_ASSUME_NONNULL_BEGIN
// Menu将要显示的通知
extern NSString * const  MenuWillAppearNotification;
// Menu已经显示的通知
extern NSString * const  MenuDidAppearNotification;
// Menu将要隐藏的通知
extern NSString * const  MenuWillDisappearNotification;
// Menu已经隐藏的通知
extern NSString * const  MenuDidDisappearNotification;


typedef void(^MenuSelectedItem)(NSInteger index, NSString *type);

typedef enum {
    MenuBackgrounColorEffectSolid      = 0, //!<背景显示效果.纯色
    MenuBackgrounColorEffectGradient   = 1, //!<背景显示效果.渐变叠加
}  MenuBackgrounColorEffect;


@interface  MenuOverlay : UIView

@end

@interface  MenuView : UIView

@property (nonatomic, strong) MenuOverlay *overlay;
@property (nonatomic, strong) BFMallModuleBtn *goShoppingCartBtn;
@property (nonatomic, strong) BFMallModuleBtn *goOrderDetailBtn;
@property (nonatomic, strong) BFMallModuleBtn *goCollectionBtn;
@property (nonatomic, strong) BFMallModuleBtn *goAddressBtn;
@property (nonatomic, strong) BFMallModuleBtn *buyVipServiceBtn;
@property (nonatomic, strong) BFMallModuleBtn *renewBtn;

@property (nonatomic, strong) UIImageView *usrIcon;
@property (nonatomic, strong) UILabel *usrNameLab;
@property (nonatomic, strong) UILabel *usrDescLab;
@property (nonatomic, strong) UILabel *vipDescLab;

- (void)dismissMenu:(BOOL)animated;

@end


@interface BFMallDetailRightPopView : UIView

+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect selected:(MenuSelectedItem)selectedItem;

+ (void)dismissMenu;
+ (BOOL)isShow;

// 主题色
+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

// 圆角
+ (CGFloat)cornerRadius;
+ (void)setCornerRadius:(CGFloat)cornerRadius;

// 箭头尺寸
+ (CGFloat)arrowSize;
+ (void)setArrowSize:(CGFloat)arrowSize;

// 是否显示阴影
+ (BOOL)hasShadow;
+ (void)setHasShadow:(BOOL)flag;

// 背景效果
+ (MenuBackgrounColorEffect)backgrounColorEffect;
+ (void)setBackgrounColorEffect:(MenuBackgrounColorEffect)effect;

@end

NS_ASSUME_NONNULL_END
