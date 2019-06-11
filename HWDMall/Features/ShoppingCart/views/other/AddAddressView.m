//
//  AddAddressView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "AddAddressView.h"

@interface AddAddressView()

@end

@implementation AddAddressView
- (IBAction)addAddressAction:(id)sender {
    RDLog(@"add address");
    self.addBlock();
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.ManualBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
    self.ManualBtn.layer.cornerRadius = self.ManualBtn.height/2;
//    self.ManualBtn.backgroundColor = [UIColor whiteColor];
//    self.ManualBtn.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:34/255.0 blue:10/255.0 alpha:0.15].CGColor;
//    self.ManualBtn.layer.shadowOffset = CGSizeMake(0,4);
//    self.ManualBtn.layer.shadowOpacity = 1;
//    self.ManualBtn.layer.shadowRadius = 10;
//    self.ManualBtn.layer.cornerRadius = 24.5;
//    self.ManualBtn.layer.borderWidth = 1;
//    self.ManualBtn.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
//    [self.ManualBtn setGradientBackgroundWithColors:@[[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1],[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1]] locations:nil startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1)];
}

- (void)setBtnTitle:(NSString *)btnTitle{
    if (btnTitle != _btnTitle) {
        _btnTitle = btnTitle;
    }
    [self.ManualBtn setTitle:btnTitle forState:UIControlStateNormal];
}
- (void)setBtnColor:(UIColor *)btnColor{
    if (_btnColor != btnColor) {
        _btnColor = btnColor;
    }
    self.ManualBtn.backgroundColor = btnColor;
}
- (void)setTitleColor:(UIColor *)titleColor{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
    }
    [self.ManualBtn setTitleColor:_titleColor forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
