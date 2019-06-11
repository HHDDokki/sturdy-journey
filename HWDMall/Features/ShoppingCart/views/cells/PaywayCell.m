//
//  PaywayCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "PaywayCell.h"

@interface PaywayCell()
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxpayBtn;
@property (weak, nonatomic) IBOutlet UILabel *tiitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *topView;
@property (weak, nonatomic) IBOutlet UILabel *bottomView;

@end

@implementation PaywayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.alipayBtn.selected = NO;
    self.wxpayBtn.selected = YES;
    UITapGestureRecognizer * topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topViewTapAction)];
    topTap.numberOfTapsRequired = 1;
    topTap.numberOfTouchesRequired = 1;
    self.topView.userInteractionEnabled = YES;
    [self.topView addGestureRecognizer:topTap];
    
    UITapGestureRecognizer * bottomTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomViewTapAction)];
    bottomTap.numberOfTouchesRequired = 1;
    bottomTap.numberOfTapsRequired = 1;
    self.bottomView.userInteractionEnabled = YES;
    [self.bottomView addGestureRecognizer:bottomTap];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)alipayAction:(id)sender {
    self.alipayBtn.selected = YES;
    self.wxpayBtn.selected = NO;
    if (self.payBlock) {
    self.payBlock(Payway_Alipay);
    }
   
}
- (IBAction)wxpayAction:(id)sender {
    self.alipayBtn.selected = NO;
    self.wxpayBtn.selected = YES;
    if (self.payBlock) {
     self.payBlock(Payway_Wxpay);
    }
}


- (void)setTitlehidden:(BOOL)titlehidden{
    if (_titlehidden != titlehidden) {
        _titlehidden = titlehidden;
    }
    if (titlehidden) {
        self.tiitleLbl.hidden = YES;
    }else{
        self.tiitleLbl.hidden = NO;
    }
}

- (void)topViewTapAction{ // 点击上
    self.alipayBtn.selected = YES;
    self.wxpayBtn.selected = NO;
    if (self.payBlock) {
        self.payBlock(Payway_Alipay);
    }
}

- (void)bottomViewTapAction{ // 点击下
    self.alipayBtn.selected = NO;
    self.wxpayBtn.selected = YES;
    if (self.payBlock) {
        self.payBlock(Payway_Wxpay);
    }
}


@end
