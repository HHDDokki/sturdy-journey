//
//  HHDAlertView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^HHDAlertBlock)(void);

@interface HHDAlertView : UIView
@property (nonatomic,copy) NSString *mesStr; //信息
@property (nonatomic,copy) NSString *cancelTitle; // 取消键title
@property (nonatomic,copy) NSString *confirmTitle; // 确认键title
@property (nonatomic,strong) UIColor *cancelColor; // 取消键色值
@property (nonatomic,strong) UIColor *confirmColor; // 确认键色值
@property (nonatomic,copy)  HHDAlertBlock confirmBlock; // 确认键
@property (nonatomic,copy) HHDAlertBlock cancelBlock; // 取消键block
@property (nonatomic,assign) BOOL rightDismiss; // 确认键是否可以让视图dismiss


@end

NS_ASSUME_NONNULL_END
