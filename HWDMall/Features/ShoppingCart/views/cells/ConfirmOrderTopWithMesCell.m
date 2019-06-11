//
//  ConfirmOrderTopWithMesCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderTopWithMesCell.h"

@interface ConfirmOrderTopWithMesCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@end

@implementation ConfirmOrderTopWithMesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWithName:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address{
    self.nameLbl.text = NSStringFormat(@"收货人:%@",name);
    self.phoneNumLbl.text = [NSString PhoneWithSecret:phone];
    self.addressLbl.text = NSStringFormat(@"收货地址:%@",address);
}

@end
