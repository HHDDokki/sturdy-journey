//
//  OrderCellFooterForWatiAndFinished.m
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderCellFooterForWatiAndFinished.h"

@interface OrderCellFooterForWatiAndFinished()
@property (weak, nonatomic) IBOutlet UILabel *countAndMoneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation OrderCellFooterForWatiAndFinished

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftBtn.layer.cornerRadius = 13.5;
    self.leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    self.leftBtn.layer.borderWidth = 1;
    
    self.rightBtn.layer.cornerRadius = 13.5;
    self.rightBtn.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
    self.rightBtn.layer.borderWidth = 1;
}
- (IBAction)leftAction:(id)sender {
    if (self.leftBlock) {
        RDLog(@"left");
        self.leftBlock();
    }
     RDLog(@"left");
}
- (IBAction)rightAction:(id)sender {
    if (self.rightBlock) {
        RDLog(@"right");
        self.rightBlock();
    }
    RDLog(@"right");
}

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle{
    if (_leftBtnTitle != leftBtnTitle) {
        _leftBtnTitle = leftBtnTitle;
    }
    [self.leftBtn setTitle:_leftBtnTitle forState:UIControlStateNormal];
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle{
    if (_rightBtnTitle != rightBtnTitle) {
        _rightBtnTitle = rightBtnTitle;
    }
    [self.rightBtn setTitle:_rightBtnTitle forState:UIControlStateNormal];
}

- (void)updateFooterWithLeftName:(NSString *)leftname
                       RightName:(NSString *)rightname
                           Count:(NSInteger)goodcount
                           Price:(CGFloat)price{
    [self.leftBtn setTitle:leftname forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightname forState:UIControlStateNormal];
    NSString * countandmoney = NSStringFormat(@"共%ld件商品，实付:￥%.2f元",(long)goodcount,price);
    NSArray * strArr = [countandmoney componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":."]];
    NSRange range = [countandmoney rangeOfString:[strArr objectAtIndex:1]];
    NSMutableAttributedString * muatrStr = [[NSMutableAttributedString alloc]initWithString:countandmoney];
    [muatrStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],
                              NSForegroundColorAttributeName:[UIColor blackColor]
                              } range:range];
    self.countAndMoneyLbl.attributedText = muatrStr;
    if ([leftname isEqualToString:@"取消订单"]) {
        self.leftBtn.hidden = YES;
    }else{
        self.leftBtn.hidden = NO;
    }
}
@end
