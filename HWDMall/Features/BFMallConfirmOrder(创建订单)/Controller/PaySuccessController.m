//
//  PaySuccessController.m
//  HWDMall
//
//  Created by stewedr on 2018/12/4.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "PaySuccessController.h"
#import "MyOrderDetailController.h" // 订单详情
#import "ConfirmOrderController.h" // 确认订单控制器
#import "MyOrderFormController.h"

@interface PaySuccessController ()
@property (nonatomic,strong) UIImageView * headimage;
@property (nonatomic,strong) UILabel *paywaytitleLbl;
@property (nonatomic,strong) UILabel *paywaymesLbl;
@property (nonatomic,strong) UILabel *paycounttitleLbl;
@property (nonatomic,strong) UILabel *paycountMes;
@property (nonatomic,strong) UIButton *checkOrderBtn;
@property (nonatomic,strong) UIButton *jixuguangguangnBtn;

//@property (nonatomic, strong) UIButton * headimage;

@end

@implementation PaySuccessController

#pragma mark -- lazyload
- (UIImageView *)headimage{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        _headimage.image = GetImage(@"ordersuccesshead");
    }
    return _headimage;
}

- (UILabel *)paywaytitleLbl{
    if (!_paywaytitleLbl) {
        _paywaytitleLbl = [UILabel new];
        _paywaytitleLbl.text = @"支付方式:";
        _paywaytitleLbl.font = kFont(14);
        _paywaytitleLbl.textColor = UIColorFromHex(0x333333);
    }
    return _paywaytitleLbl;
}

- (UILabel *)paywaymesLbl{
    if (!_paywaymesLbl) {
        _paywaymesLbl = [UILabel new];
        _paywaymesLbl.font = kFont(14);
        _paywaymesLbl.textColor = kMainRedColor;
    }
    return _paywaymesLbl;
}

- (UILabel *)paycounttitleLbl{
    if (!_paycounttitleLbl) {
        _paycounttitleLbl = [UILabel new];
        _paycounttitleLbl.text = @"支付金额:";
        _paycounttitleLbl.font = kFont(14);
        _paycounttitleLbl.textColor = UIColorFromHex(0x333333);
    }
    return _paycounttitleLbl;
}
- (UILabel *)paycountMes{
    if (!_paycountMes) {
        _paycountMes = [UILabel new];
        _paycountMes.font = kFont(14);
        _paycountMes.textColor = kMainRedColor;
    }
    return _paycountMes;
}


- (UIButton *)checkOrderBtn{
    if (!_checkOrderBtn) {
        _checkOrderBtn = [[UIButton alloc]init];
        [_checkOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        [_checkOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _checkOrderBtn.layer.cornerRadius = 24;
        [_checkOrderBtn setGradientBackgroundWithColors:@[kMainRedColor,kMainYellowColor] locations:nil startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1)];
        _checkOrderBtn.titleLabel.font = kFont(17);
        [_checkOrderBtn addTarget:self action:@selector(checkOrderDetail) forControlEvents:UIControlEventTouchDown];
    }
    return _checkOrderBtn;
}


- (UIButton *)jixuguangguangnBtn{
    if (!_jixuguangguangnBtn) {
        _jixuguangguangnBtn = [[UIButton alloc]init];
        [_jixuguangguangnBtn setTitle:@"继续逛逛" forState:UIControlStateNormal];
        [_jixuguangguangnBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
        _jixuguangguangnBtn.backgroundColor = [UIColor whiteColor];
        _jixuguangguangnBtn.layer.cornerRadius = 24;
        _jixuguangguangnBtn.layer.borderColor = kMainRedColor.CGColor;
        _jixuguangguangnBtn.layer.borderWidth = 1;
        _jixuguangguangnBtn.titleLabel.font = kFont(17);
        [_jixuguangguangnBtn addTarget:self action:@selector(backHomePage) forControlEvents:UIControlEventTouchDown];
    }
    return _jixuguangguangnBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"支付结果"]];
    [self setUI];
}

//- (UIButton *)set_leftButton{
//    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
//    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
//    return leftBtn;
//}


- (void)left_button_event:(UIButton *)sender{
    
}

#pragma mark -- setUI
- (void)setUI{
    
    [self.view addSubview:self.headimage];
    [self.view addSubview:self.paywaytitleLbl];
    [self.view addSubview:self.paywaymesLbl];
    [self.view addSubview:self.paycounttitleLbl];
    [self.view addSubview:self.paycountMes];
    [self.view addSubview:self.checkOrderBtn];
    [self.view addSubview:self.jixuguangguangnBtn];
    
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(75);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(36 + kSafeAreaTopHeight);
    }];
    
    [self.paywaytitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimage.mas_left).offset(-30);
        make.top.equalTo(self.headimage.mas_bottom).offset(24);
    }];
//
    [self.paywaymesLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headimage.mas_bottom).offset(24);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.left.equalTo(self.paycounttitleLbl.mas_right).equalTo(15);
    }];
//
    [self.paycounttitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimage.mas_left).offset(-30);
        make.top.equalTo(self.paywaytitleLbl.mas_bottom).offset(12);
    }];
//
    [self.paycountMes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.paywaytitleLbl.mas_bottom).offset(12);
        make.left.equalTo(self.paycounttitleLbl.mas_right).equalTo(15);
    }];

    [self.checkOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(49);
        make.top.equalTo(self.paycountMes.mas_bottom).offset(32);
    }];

    [self.jixuguangguangnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(49);
        make.top.equalTo(self.checkOrderBtn.mas_bottom).offset(15);
    }];
}

- (void)checkOrderDetail{
    NSMutableArray *viewCtrs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for (UIViewController * controller in viewCtrs) {
        if ([controller isKindOfClass:[ConfirmOrderController class]]) {
            [viewCtrs removeObject:controller];
            break;
        }
    }
    
    NSInteger index = [viewCtrs indexOfObject:self];
    if (self.isUnpack) {
        MyOrderFormController * orderController = [[MyOrderFormController alloc]init];
        orderController.hidesBottomBarWhenPushed = YES;
        orderController.currentIndex = 0;
        [viewCtrs replaceObjectAtIndex:index - 1 withObject:orderController];
    }else{
        MyOrderDetailController * orderdetail =[[MyOrderDetailController alloc]init];
        [orderdetail updateOrderDetailMesWithParentOrderID:[self.parentOrderSign integerValue] SonOrderID:[self.sonOrderSign integerValue] OrderType:nil OrderStatus:nil];
        orderdetail.hidesBottomBarWhenPushed = YES;
      [viewCtrs replaceObjectAtIndex:index - 1 withObject:orderdetail];
    }
    [self.navigationController setViewControllers:viewCtrs animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backHomePage{
    self.tabBarController.selectedIndex = 0;

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)updateMesWith:(NSString *)paywayStr PayPrice:(NSString *)payPriceStr{
    self.paywaymesLbl.text = paywayStr;
    self.paycountMes.text = payPriceStr;
}

@end
