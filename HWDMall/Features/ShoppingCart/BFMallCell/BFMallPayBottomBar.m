//
//  BFMallPayBottomBar.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallPayBottomBar.h"

@interface BFMallPayBottomBar ()

@property (nonatomic, strong) UILabel *moneyLbl;
@property (nonatomic, strong) UIButton *payBtn;

@end

@implementation BFMallPayBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self addSubview:self.moneyLbl];
    [self addSubview:self.payBtn];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(113);
        make.height.equalTo(40);
        
    }];
    self.payBtn.layer.cornerRadius = 20;
    
    [self.moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.payBtn.mas_left).offset(-14);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(14);
    }];
    
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
    
    self.moneyLbl.text = NSStringFormat(@"共计：%@",totalMoney);
//    NSMutableAttributedString * muattrStr = [[NSMutableAttributedString alloc]initWithString:totalMoney];
//    NSArray * comStrArr = [totalMoney componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"￥."]];
//    NSString * midStr = [comStrArr objectAtIndex:1];
//    NSRange rang = [totalMoney rangeOfString:midStr];
//    [muattrStr addAttribute:NSFontAttributeName value:kFont(17) range:rang];
//    self.moneyLbl.attributedText = muattrStr;
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

#pragma mark - lazyload
- (UILabel *)moneyLbl {
    
    if (!_moneyLbl) {
        _moneyLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _moneyLbl.font = kFont(14);
        _moneyLbl.text = @"共计:￥12980.00";
        _moneyLbl.textColor = [UIColor hexColor:@"#FF7200"];
        _moneyLbl.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLbl;
    
}

- (UIButton *)payBtn {
    
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _payBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
        [_payBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor hexColor:@"#FFFFFF"] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = kFont(15);
        [_payBtn addTarget:self action:@selector(payBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
    
}

@end
