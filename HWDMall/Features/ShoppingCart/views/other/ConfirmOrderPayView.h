//
//  ConfirmOrderPayView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/18.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayBtnBlock)(void);

@interface ConfirmOrderPayView : UIView
@property (nonatomic,copy) PayBtnBlock payBlock;
@property (nonatomic,copy) NSString * totalMoney; // 商品总额
@property (nonatomic,assign) BOOL isCanDeliver; // 是否可以运输

@end

