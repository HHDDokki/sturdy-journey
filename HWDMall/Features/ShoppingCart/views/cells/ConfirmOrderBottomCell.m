//
//  ConfirmOrderBottomCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderBottomCell.h"

@interface ConfirmOrderBottomCell()

@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UILabel *useContent;

@property (weak, nonatomic) IBOutlet UILabel *celltitle;
@end

@implementation ConfirmOrderBottomCell

#pragma mark -- lazyload


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [KLSwitch class];
    [self.useCoinSwitch setOnTintColor: UIColorFromHex(0x51AB38)];
    [self.useCoinSwitch setContrastColor:UIColorFromHex(0xeeeeee)];
    __weak typeof(self) weakSelf = self;
     self.useCoinSwitch.didChangeHandler = ^(BOOL isOn) {
        RDLog(@"change");
        weakSelf.switchBlock(isOn);
    };
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"充值"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:titleRange];
    [self.rechargeBtn setAttributedTitle:title
                      forState:UIControlStateNormal];
    [self.rechargeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.rechargeBtn addTarget:self action:@selector(rechargeBtnAction) forControlEvents:UIControlEventTouchDown];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateCellMesWithCellTitle:(NSString *)celltitle UseContent:(NSString *)usecontent{
    self.celltitle.text = celltitle;
    self.useContent.text = usecontent;
}

#pragma mark -- rechargeBtnAction
- (void)rechargeBtnAction{
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
}

@end
