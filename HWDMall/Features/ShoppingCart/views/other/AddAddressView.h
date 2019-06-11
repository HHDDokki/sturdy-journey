//
//  AddAddressView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddAddressBlock)(void);

@interface AddAddressView : UIView

@property (weak, nonatomic) IBOutlet UIButton *ManualBtn;


@property (nonatomic,copy) AddAddressBlock  addBlock;
@property (nonatomic,copy) NSString * btnTitle; // 按钮title
@property (nonatomic,strong) UIColor *btnColor; // 按钮颜色
@property (nonatomic,strong) UIColor *titleColor; // title 颜色
@end

NS_ASSUME_NONNULL_END
