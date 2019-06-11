//
//  CancelReasonCell.m
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "CancelReasonCell.h"

@interface CancelReasonCell ()
@property (weak, nonatomic) IBOutlet UILabel *cacelReasonLbl;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation CancelReasonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.selectBtn addTarget:self action:@selector(selectedBtnAction) forControlEvents:UIControlEventTouchDown];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWithTitle:(NSString *)titleMes SelectedStatus:(BOOL)status{
    self.cacelReasonLbl.text = titleMes;
    if (status) {
        self.selectBtn.selected = YES;
    }else{
        self.selectBtn.selected = NO;
    }
}

#pragma mark -- buttonAction
- (void)selectedBtnAction{
    if (!self.selectBtn.isSelected) {
        self.selectBtn.selected = !self.selectBtn.isSelected;
        if (self.btnBlock) {
            self.btnBlock();
        }
    }
}

@end
