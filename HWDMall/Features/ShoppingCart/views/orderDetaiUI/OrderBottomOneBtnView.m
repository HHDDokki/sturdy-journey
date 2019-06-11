//
//  OrderBottomOneBtnView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderBottomOneBtnView.h"

@interface OrderBottomOneBtnView ()
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation OrderBottomOneBtnView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.rightBtn.layer.cornerRadius = 15;
    self.rightBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    self.rightBtn.layer.borderWidth = 1;
    [self.rightBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchDown];
    self.rightBtn.hidden = YES;
}

- (void)btnAction{
    RDLog(@"click");
    if (self.btnBlock) {
        self.btnBlock();
    }
}

- (void)setTitleName:(NSString *)titleName{
    if (_titleName != titleName) {
        _titleName = titleName;
    }
    [self.rightBtn setTitle:titleName forState:UIControlStateNormal];
    self.rightBtn.hidden = YES;
}

@end
