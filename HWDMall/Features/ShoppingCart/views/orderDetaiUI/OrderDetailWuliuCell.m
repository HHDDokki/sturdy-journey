//
//  OrderDetailWuliuCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetailWuliuCell.h"

@interface OrderDetailWuliuCell ()
@property (weak, nonatomic) IBOutlet UILabel *wuliuMesLbl;
@property (weak, nonatomic) IBOutlet UILabel *wuliuDataLbl;
@property (weak, nonatomic) IBOutlet UIButton *wuliuMoreBtn;

@end

@implementation OrderDetailWuliuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWith:(NSString *)mes Time:(NSString *)time ButtonHidden:(BOOL)btnHidden{
    self.wuliuMesLbl.text = mes;
    self.wuliuDataLbl.text = time;
    if (btnHidden) {
        self.wuliuMoreBtn.hidden = YES;
    }
}

@end
