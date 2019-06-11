//
//  OrderBottomThreeBtnView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderBottomThreeBtnView.h"

@interface OrderBottomThreeBtnView ()



@end

@implementation OrderBottomThreeBtnView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftBtn.layer.cornerRadius = 16;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    
    self.midBtn.layer.cornerRadius = 16;
    self.midBtn.layer.borderWidth = 1;
    self.midBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    
    self.rightBtn.layer.cornerRadius = 16;
    self.rightBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
    self.rightBtn.layer.masksToBounds = YES;
    
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchDown];
    self.leftBtn.hidden = YES;
    [self.midBtn addTarget:self action:@selector(midBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchDown];
    
}

- (void)leftBtnAction{
    if (self.leftBtnBlock) {
        self.leftBtnBlock();
    }
}

- (void)midBtnAction{
    if (self.midBtnBlock) {
        self.midBtnBlock();
    }
}

- (void)rightBtnAction{
    if (self.rightBtnBlock) {
        self.rightBtnBlock();
    }
}

- (void)updataMesWithLeftTitle:(NSString *)lefttitle MidTitle:(NSString *)midtitle RightTitle:(NSString *)righttitle{
    [self.leftBtn setTitle:lefttitle forState:UIControlStateNormal];
    [self.midBtn setTitle:midtitle forState:UIControlStateNormal];
    [self.rightBtn setTitle:righttitle forState:UIControlStateNormal];
}

@end
