//
//  OrderBottomOneBtnView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OneBtnBlock)(void);

@interface OrderBottomOneBtnView : UIView
@property (nonatomic,copy) OneBtnBlock btnBlock;
@property (nonatomic,copy) NSString *titleName;

@end

NS_ASSUME_NONNULL_END
