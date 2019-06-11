//
//  OrderBottomThreeBtnCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderBottomThreeBtnCell.h"

@interface OrderBottomThreeBtnCell ()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation OrderBottomThreeBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    
    self.midBtn.layer.cornerRadius = 5;
    self.midBtn.layer.borderWidth = 1;
    self.midBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    
    self.rightBtn.layer.cornerRadius = 8;
    [self.rightBtn setGradientBackgroundWithColors:@[[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1],[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1]] locations:@[@(0),@(1)] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1)];
    self.rightBtn.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
