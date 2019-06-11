//
//  OrderCellFooterForCanceled.m
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderCellFooterForCanceled.h"

@interface OrderCellFooterForCanceled ()
@property (weak, nonatomic) IBOutlet UILabel *countAndMoneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@end

@implementation OrderCellFooterForCanceled

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bottomBtn.layer.borderWidth = 1;
    self.bottomBtn.layer.cornerRadius = 13.5;
    self.bottomBtn.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
}
- (IBAction)bottomBtnAction:(id)sender {
}

@end
