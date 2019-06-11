//
//  HHDAlertView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "HHDAlertView.h"

#define leftBtnNormalColor 0xEEEEEE
#define rightBtnNormalColor

@interface HHDAlertView()
@property (nonatomic,strong) UIView *contentView; // 内容
@property (nonatomic,strong) UIButton *cancelBtn; // 取消键位
@property (nonatomic,strong) UIButton *confirmBtn; // 确认键位
@property (nonatomic,strong) UILabel *contenLbl; // 显示内容
@end


@implementation HHDAlertView

#pragma mark -- lazyload
- (UILabel *)contenLbl{
    if (!_contenLbl) {
        _contenLbl = [[UILabel alloc]init];
        _contenLbl.font = kFont(15);
        _contenLbl.textColor = UIColorFromHex(0x333333);
        _contenLbl.numberOfLines = 0;
        _contenLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _contenLbl;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView.layer setMasksToBounds:YES];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kFont(15);
        [_cancelBtn setBackgroundColor:UIColorFromHex(0xeeeeee)];
        [_cancelBtn.layer setMasksToBounds:YES];
        [_cancelBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = kFont(15);
        _confirmBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
        [_confirmBtn.layer setMasksToBounds:YES];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _confirmBtn;
}

#pragma mark -- init1   1
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubviews];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}

- (void)setSubviews{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.contenLbl];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.confirmBtn];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(250);
        make.height.equalTo(150);
    }];
    [self.contenLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-5);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.height.equalTo(40);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
        make.height.equalTo(40);
    }];

}


#pragma mark -- BtnAction
- (void)backAction:(UIButton *)sender{
    if ([sender isEqual:self.cancelBtn]) {
        [self removeFromSuperview];
        _cancelBlock ? self.cancelBlock() : nil;
    }
}

- (void)confirmAction:(UIButton *)sender{
    if ([sender isEqual:self.confirmBtn]) {
        [self removeFromSuperview];
        _confirmBlock ? self.confirmBlock() : nil;
        if (self.rightDismiss) {
        }
    }
}


#pragma mark -- setter
- (void)setCancelColor:(UIColor *)cancelColor{
    if (cancelColor != _cancelColor) {
        _cancelColor = cancelColor;
    }
    [self.cancelBtn setTitleColor:_cancelColor forState:UIControlStateNormal];
}

- (void)setConfirmColor:(UIColor *)confirmColor{
    if (confirmColor != _confirmColor) {
        _confirmColor = confirmColor;
    }
    [self.confirmBtn setTitleColor:_confirmColor forState:UIControlStateNormal];
}

- (void)setMesStr:(NSString *)mesStr{
    if (mesStr != _mesStr) {
        _mesStr = mesStr;
    }
    self.contenLbl.text = mesStr;
}

- (void)setConfirmTitle:(NSString *)confirmTitle{
    if (confirmTitle != _confirmTitle) {
        _confirmTitle = confirmTitle;
    }
    [self.confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
}

- (void)setCancelTitle:(NSString *)cancelTitle{
    if (_cancelTitle != cancelTitle) {
        _cancelTitle = cancelTitle;
    }
    [self.cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
}

@end
