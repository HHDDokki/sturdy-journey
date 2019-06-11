//
//  BFMallOrderListFooterView.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/31.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallOrderListFooterView.h"

@interface BFMallOrderListFooterView ()

@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation BFMallOrderListFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
        
    }
    return self;
    
}

- (void)setUI {

    [self.contentView addSubview:self.totalLabel];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(14);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.equalTo(80);
        make.height.equalTo(26);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.width.equalTo(80);
        make.height.equalTo(26);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(8);
    }];
    
    
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.totalLabel.hidden = YES;
    
}

- (void)updateFooter {
    
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.totalLabel.hidden = YES;
    
}

- (void)updateFooterWithRightName:(NSString *)rightname {
    
    self.rightBtn.layer.borderColor = UIColorFromHex(0xFF7200).CGColor;
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:rightname forState:UIControlStateNormal];
    
}

- (void)updateFooterWithLeftName:(NSString *)leftname
                       RightName:(NSString *)rightname {
    
    self.leftBtn.hidden = NO;
    self.rightBtn.hidden = NO;
    if ([rightname isEqualToString:@"去付款"]) {
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
    };
    [self.leftBtn setTitleColor:[UIColor hexColor:@"#999999"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:leftname forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightname forState:UIControlStateNormal];

}

- (void)updateFooterWithLeftName:(NSString *)leftname
                       RightName:(NSString *)rightname
                           Price:(CGFloat)price {
    
    self.totalLabel.hidden = NO;
    self.leftBtn.hidden = NO;
    self.rightBtn.hidden = NO;
    
    
    if ([rightname isEqualToString:@"去付款"]) {
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
    };
    if ([rightname isEqualToString:@"确认收货"]) {
        self.totalLabel.text = NSStringFormat(@"¥%.2f", price);
    }else{
        self.totalLabel.text = NSStringFormat(@"合计：¥%.2f", price);
    }
    
    [self.leftBtn setTitleColor:[UIColor hexColor:@"#999999"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:leftname forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightname forState:UIControlStateNormal];

}

- (void)updateFooterWithRightName:(NSString *)rightname
                            Price:(CGFloat)price {
    
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = NO;
    self.totalLabel.hidden = NO;
    self.totalLabel.text = NSStringFormat(@"合计：¥%.2f", price);
    [self.rightBtn setTitle:rightname forState:UIControlStateNormal];
    
}

- (void)updateFooterWithRightPrice:(CGFloat)price {
    
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.totalLabel.hidden = NO;
    self.totalLabel.text = NSStringFormat(@"合计：¥%.2f", price);
    
}


- (void)leftBtnClicked:(UIButton *)sender {
    
    if (self.leftBtnBlock) {
        self.leftBtnBlock();
    }
}

- (void)rightBtnClicked:(UIButton *)sender {
    
    if (self.rightBtnBlock) {
        self.rightBtnBlock();
    }
}

#pragma mark -- lazyload
- (UILabel *)totalLabel {
    
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _totalLabel.font = kFont(14);
        _totalLabel.textColor = [UIColor hexColor:@"#FF7200"];
        _totalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalLabel;
    
}

- (UIButton *)leftBtn {
    
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _leftBtn.titleLabel.font = kFont(10);
        _leftBtn.layer.cornerRadius = 13.5;
        _leftBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
        _leftBtn.layer.borderWidth = 1;
        [_leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
    
}

- (UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _rightBtn.titleLabel.font = kFont(10);
        _rightBtn.layer.cornerRadius = 13.5;
        _rightBtn.layer.borderColor = UIColorFromHex(0xFF7200).CGColor;
        _rightBtn.layer.borderWidth = 1;
        [_rightBtn setTitleColor:[UIColor hexColor:@"#FF7200"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
    
}

@end
