//
//  BFMallShoppingcartHeaderView.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/29.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RightBtnBlock)(void);
typedef void(^SelectedBtnBlock)(BOOL btnStatus);

@interface BFMallShoppingcartHeaderView : UIView

@property (nonatomic,copy) RightBtnBlock deleteBlock;
@property (nonatomic,copy) RightBtnBlock balanceBlock;
@property (nonatomic,copy) SelectedBtnBlock selectedBlock;
@property (nonatomic,assign) BOOL isAllSelected; // 是否全部选中
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
