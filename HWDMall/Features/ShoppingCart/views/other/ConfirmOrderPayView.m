//
//  ConfirmOrderPayView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/18.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderPayView.h"


@interface ConfirmOrderPayView()
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

@implementation ConfirmOrderPayView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.payBtn.layer.cornerRadius = 20;
    [self.payBtn addTarget:self action:@selector(payBtn:) forControlEvents:UIControlEventTouchDown];
}
- (void)payBtn:(UIButton *)sender{
    RDLog(@"pay");
    if ([sender isEqual:self.payBtn]) {
        self.payBlock();
    }
}

- (void)setTotalMoney:(NSString *)totalMoney{
    if (_totalMoney != totalMoney) {
        _totalMoney = totalMoney;
    }
    
    NSMutableAttributedString * muattrStr = [[NSMutableAttributedString alloc]initWithString:totalMoney];
    NSArray * comStrArr = [totalMoney componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"￥."]];
    NSString * midStr = [comStrArr objectAtIndex:1];
    NSRange rang = [totalMoney rangeOfString:midStr];
    [muattrStr addAttribute:NSFontAttributeName value:kFont(17) range:rang];
    self.moneyLbl.attributedText = muattrStr;
}


- (void)setIsCanDeliver:(BOOL)isCanDeliver{
    if (_isCanDeliver != isCanDeliver) {
        _isCanDeliver = isCanDeliver;
    }
    if (isCanDeliver) {
        self.payBtn.alpha = 1;
         self.payBtn.userInteractionEnabled = YES;
    }else{
        self.payBtn.alpha = 0.5;
        self.payBtn.userInteractionEnabled = NO;
    }
}
@end
