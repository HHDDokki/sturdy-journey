//
//  OrderDealMesCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDealMesCell.h"

@interface OrderDealMesCell ()
@property (weak, nonatomic) IBOutlet UILabel *celltitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellContentLbl;

@end

@implementation OrderDealMesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWithCellTitle:(NSString *)celltitle CellContent:(NSString *)content ContenColor:(UIColor *)contentColor{
    self.celltitleLbl.text = celltitle;
    self.cellContentLbl.text = content;
    self.cellContentLbl.textColor = contentColor;
}

@end
