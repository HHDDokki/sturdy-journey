//
//  OrderBottomTwoBtnView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderBottomTwoBtnView.h"

@interface OrderBottomTwoBtnView ()

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@end

@implementation OrderBottomTwoBtnView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftBtn.layer.cornerRadius = 15;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchDown];
    self.leftBtn.hidden = YES;
    
    self.rightBtn.layer.cornerRadius = 15;
    self.rightBtn.layer.borderWidth = 1;
    self.rightBtn.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchDown];
}

- (void)updateViewMesWithLeftBtnTitle:(NSString *)leftTitle RightTitle:(NSString *)rightTitle{
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}

#pragma mark -- btnAction
- (void)leftBtnAction{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnAction{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

@end
