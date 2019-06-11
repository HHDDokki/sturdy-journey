//
//  ShoppingcartBottomView.m
//  HWDMall
//
//  Created by stewedr on 2018/11/8.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingcartBottomView.h"

@interface ShoppingcartBottomView ()

@property (weak, nonatomic) IBOutlet UIButton *balanceBtn; // 去结算

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn; // 删除
@property (weak, nonatomic) IBOutlet UILabel *quanxuanLbl;
@property (weak, nonatomic) IBOutlet UILabel *hejiLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;


@end

@implementation ShoppingcartBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.balanceBtn.layer.cornerRadius = 15;
    [self.balanceBtn setGradientBackgroundWithColors:@[[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1],[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
    
    self.deleteBtn.layer.cornerRadius = 15;
    [self.deleteBtn setGradientBackgroundWithColors:@[[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1],[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
}

- (void)changeShoppingcartBottonViewWithStatus:(BOOL)status{
    self.hejiLbl.hidden = status;
    self.moneyLbl.hidden = status;
    self.deleteBtn.hidden = !status;
}
- (IBAction)deleteAction:(id)sender {
    RDLog(@"删除");
    _deleteBlock ? self.deleteBlock() : nil;
}
- (IBAction)balanceAction:(id)sender {
    RDLog(@"去结算");
    _balanceBlock ? self.balanceBlock() : nil;
}

- (IBAction)selectedBtnAction:(id)sender {
    if ([sender isEqual:self.selectedBtn]){
        UIButton *selectedBnt = (UIButton *)sender;
        if (self.selectedBlck) {
            self.selectedBlck(selectedBnt.isSelected);
        }
    }
}

#pragma mark -- setter
- (void)setTotalMoney:(NSString *)totalMoney{
    if (totalMoney != _totalMoney) {
        _totalMoney = totalMoney;
    }
    self.moneyLbl.text = totalMoney;
}

- (void)setIsAllSelected:(BOOL)isAllSelected{
    if (_isAllSelected != isAllSelected) {
        _isAllSelected = isAllSelected;
    }
    self.selectedBtn.selected = isAllSelected;
}

@end
