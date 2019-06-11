//
//  ConfirmDealController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/25.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmDealController.h"
#import "ConfirmDealMesView.h"
#import "AddAddressView.h"
#import "UIButton+countDown.h"

@interface ConfirmDealController ()
@property (nonatomic,strong) AddAddressView *payBtn; // 立即支付
@property (nonatomic,strong) ConfirmDealMesView *dealMesView; // 订单信息
@property (nonatomic,strong) UIButton * testBtn; // 测试
@end

@implementation ConfirmDealController

#pragma mark -- lazyload

- (AddAddressView *)payBtn{
    if (!_payBtn) {
        _payBtn = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressView class]) owner:self options:nil]lastObject];
        _payBtn.btnTitle = @"立即支付";
        _payBtn.addBlock = ^{
            
        };
    }
    return _payBtn;
}
- (ConfirmDealMesView *)dealMesView{
    if (!_dealMesView) {
        _dealMesView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConfirmDealMesView class]) owner:self options:nil]lastObject];
    }
    return _dealMesView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self set_leftButton];
}


#pragma mark -- setUI
- (void)setUI{
    [self.view addSubview:self.dealMesView];
    [self.view addSubview:self.payBtn];
    [self.view addSubview:self.testBtn];
    [self.dealMesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(240);
    }];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.dealMesView.mas_bottom).offset(15);
        make.height.equalTo(50);
    }];
    
    
}
#pragma mark -- buttonAction
- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
