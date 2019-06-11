//
//  OrderPayCountCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderPayCountCell.h"

@interface OrderPayCountCell ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@end

@implementation OrderPayCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateMoney:(NSString *)money{
    self.moneyLbl.text = money;
}

@end
