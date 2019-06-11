//
//  ShoppingcartBottomView.h
//  HWDMall
//
//  Created by stewedr on 2018/11/8.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RightBtnBlock)(void);
typedef void(^SelectedBtnBlock)(BOOL btnStatus);
@interface ShoppingcartBottomView : UIView

@property (nonatomic,copy) RightBtnBlock deleteBlock;
@property (nonatomic,copy) RightBtnBlock balanceBlock;
@property (nonatomic,copy) NSString *totalMoney; // 全部
@property (nonatomic,copy) SelectedBtnBlock selectedBlck;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (nonatomic,assign) BOOL isAllSelected; // 是否全部选中

- (void)changeShoppingcartBottonViewWithStatus:(BOOL)status;
@end


