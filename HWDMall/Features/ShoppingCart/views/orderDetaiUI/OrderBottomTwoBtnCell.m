//
//  OrderBottomTwoBtnCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderBottomTwoBtnCell.h"

@interface OrderBottomTwoBtnCell ()

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@end

@implementation OrderBottomTwoBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftBtn.layer.cornerRadius = 25;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    
    self.rightBtn.layer.cornerRadius = 25;
    self.rightBtn.layer.borderWidth = 1;
    self.rightBtn.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
