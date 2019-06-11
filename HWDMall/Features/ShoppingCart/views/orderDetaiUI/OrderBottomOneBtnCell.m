//
//  OrderBottomOneBtnCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderBottomOneBtnCell.h"

@interface OrderBottomOneBtnCell ()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@end

@implementation OrderBottomOneBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftBtn.layer.cornerRadius = 25;
    self.leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    self.leftBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
