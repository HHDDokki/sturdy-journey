//
//  ConfirmOrderController.m
//  HWDMall
//
//  Created by stewedr on 2018/12/4.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "BasePayViewController.h" // 支付
//#import "PaySuccessController.h"
#import "BFMallPayResultController.h"
#import "HHDAlertView.h"
#import "MyOrderDetailController.h" // 订单详情
#import "UINavigationController+StackManager.h"
#import "ConfirmOrderViewController.h"

@interface ConfirmOrderController ()

{
    NSString *_ordersign;
    CGFloat _totoalmoney;
    Payway _payway;
}

@property (nonatomic,strong) UILabel *ordersignLbl;
@property (nonatomic,strong) UILabel *totalmoneyLbl;
@property (nonatomic,strong) UILabel *shoukuangfangLlb;
@property (nonatomic,strong) UILabel *platformLbl;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *payBtn;

@end

@implementation ConfirmOrderController

#pragma mark -- lazyload
- (UILabel *)ordersignLbl{
    if (!_ordersignLbl) {
        _ordersignLbl = [[UILabel alloc]init];
        _ordersignLbl.textColor = UIColorFromHex(0x666666);
        _ordersignLbl.textAlignment = NSTextAlignmentCenter;
        _ordersignLbl.font = kFont(12);
    }
    return _ordersignLbl;
}

- (UILabel *)totalmoneyLbl{
    if (!_totalmoneyLbl) {
        _totalmoneyLbl = [[UILabel alloc]init];
        _totalmoneyLbl.textColor = UIColorFromHex(0x666666);
        _totalmoneyLbl.textAlignment = NSTextAlignmentCenter;
        _totalmoneyLbl.font = kFont(22);
    }
    return _totalmoneyLbl;
}

- (UILabel *)shoukuangfangLlb{
    if (!_shoukuangfangLlb) {
        _shoukuangfangLlb = [[UILabel alloc]init];
        _shoukuangfangLlb.textColor = UIColorFromHex(0x666666);
        _shoukuangfangLlb.textAlignment = NSTextAlignmentCenter;
        _shoukuangfangLlb.text = @"收款方";
        _shoukuangfangLlb.font = kFont(15);
    }
    return _shoukuangfangLlb;
}

- (UILabel *)platformLbl{
    if (!_platformLbl) {
        _platformLbl = [[UILabel alloc]init];
        _platformLbl.text = @"好货多";
        _platformLbl.textColor = UIColorFromHex(0x333333);
        _platformLbl.textAlignment = NSTextAlignmentCenter;
        _platformLbl.font = kFont(15);
    }
    return _platformLbl;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromHex(0xEEEEEE);
    }
    return _line;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = kFont(17);
        [_payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchDown];
        _payBtn.layer.cornerRadius = 24;
        [_payBtn setGradientBackgroundWithColors:@[[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1.0],[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]] locations:nil startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1)];
    }
    return  _payBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"确认交易"]];
    [self set_leftButton];
}
- (UIButton *)set_leftButton{
     UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)left_button_event:(UIButton *)sender{
    HHDAlertView * alert = [[HHDAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alert.confirmTitle = @"继续支付";
    alert.cancelTitle = @"暂时放弃";
    alert.mesStr = @"确定放弃付款吗?\n喜欢的商品可能会被抢空哦～";
    alert.rightDismiss = YES;
    __weak typeof(self) weakSelf = self;
    alert.cancelBlock = ^{
        MyOrderDetailController * orderdetail = [[MyOrderDetailController alloc]init];
        [orderdetail updateOrderDetailMesWithParentOrderID:[weakSelf.parentorderid integerValue]
                                                SonOrderID:[weakSelf.sonOrderSign integerValue]
                                                 OrderType:weakSelf.ordertype
                                               OrderStatus:OrderStatus_WaitPay];
        orderdetail.hidesBottomBarWhenPushed = YES;
        NSMutableArray *viewCtrs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        NSInteger index = [viewCtrs indexOfObject:self];
        [viewCtrs replaceObjectAtIndex:index - 1 withObject:orderdetail];
        [weakSelf.navigationController setViewControllers:viewCtrs animated:YES];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];

    };
    
    [kWindow addSubview:alert];
}

- (void)setUI{
    [self.view addSubview:self.ordersignLbl];
    [self.view addSubview:self.totalmoneyLbl];
    [self.view addSubview:self.platformLbl];
    [self.view addSubview:self.shoukuangfangLlb];
    [self.view addSubview:self.line];
    [self.view addSubview:self.payBtn];
    
    [self.ordersignLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kSafeAreaTopHeight + 15);
    }];
    
    [self.totalmoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.ordersignLbl.mas_bottom).offset(30);
    }];
    
    [self.shoukuangfangLlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.top.equalTo(self.totalmoneyLbl.mas_bottom).offset(28);
    }];
    
    [self.platformLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(self.totalmoneyLbl.mas_bottom).offset(28);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(self.shoukuangfangLlb.mas_bottom).offset(12);
    }];
    
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(48);
        make.top.equalTo(self.line.mas_bottom).offset(30);
    }];
    
}


- (void)payBtnAction:(UIButton *)sender{
    if ([sender isEqual: self.payBtn]) {
        RDLog(@"支付");
        if (_totoalmoney > 0) {
            BasePayViewController * payvc = [[BasePayViewController alloc]init];
            // 1微信、2支付宝
            if (_payway == Payway_Wxpay) {
                [self payWithOrderNo:NSStringFormat(@"%@", _ordersign) paymentMethod:@"1"];
            }else{
                [self payWithOrderNo:NSStringFormat(@"%@",_ordersign) paymentMethod:@"2"];
            }
        }
        else{
            BFMallPayResultController *paysuccessl = [[BFMallPayResultController alloc] init];
            [paysuccessl updateMesWith:YES];
//                PaySuccessController * paysuccessl = [[PaySuccessController alloc]init];
//                if (_payway == Payway_Wxpay) {
//                    [paysuccessl updateMesWith:@"微信支付" PayPrice:NSStringFormat(@"￥%.2f",_totoalmoney)];
//                }else{
//                    [paysuccessl updateMesWith:@"支付宝支付" PayPrice:NSStringFormat(@"￥%.2f",_totoalmoney)];
//                }
//                paysuccessl.isUnpack = self.isUnpack;
//                paysuccessl.parentOrderSign = self.parentorderid;
//                paysuccessl.sonOrderSign = self.sonOrderSign;
            paysuccessl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:paysuccessl animated:YES];
    
        }
    }
}


-(void)paySuccess:(BOOL)success channel:(NSString *)channel{
    if (success) {
        RDLog(@"支付成功");
        BFMallPayResultController *paysuccessl = [[BFMallPayResultController alloc] init];
        [paysuccessl updateMesWith:YES];
//            PaySuccessController * paysuccessl = [[PaySuccessController alloc]init];
//            if (_payway == Payway_Wxpay) {
//                [paysuccessl updateMesWith:@"微信支付" PayPrice:NSStringFormat(@"￥%.2f",_totoalmoney)];
//            }else{
//                [paysuccessl updateMesWith:@"支付宝支付" PayPrice:NSStringFormat(@"￥%.2f",_totoalmoney)];
//            }
//            paysuccessl.parentOrderSign = self.parentorderid;
//            paysuccessl.sonOrderSign = self.sonOrderSign;
//            paysuccessl.isUnpack = self.isUnpack;
        paysuccessl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:paysuccessl animated:YES];
        
    }else{
        BFMallPayResultController *paysuccessl = [[BFMallPayResultController alloc] init];
        [paysuccessl updateMesWith:NO];
        paysuccessl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:paysuccessl animated:YES];

//        [self.view makeToast:@"交易失败"];
    }
}


- (void)updateMesWithOrderSign:(NSString *)ordersign TotalMoney:(CGFloat)totalmoney PayWay:(Payway)payway{
    NSString * totalmoneyStr = NSStringFormat(@"￥%.2f",totalmoney);
    _ordersign = ordersign;
    _payway = payway;
    _totoalmoney = totalmoney;
    NSMutableAttributedString * muattrStr = [[NSMutableAttributedString alloc]initWithString:totalmoneyStr];
    NSArray * comStrArr = [totalmoneyStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"￥."]];
    NSString * midStr = [comStrArr objectAtIndex:1];
    NSRange rang = [totalmoneyStr rangeOfString:midStr];
    [muattrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:38] range:rang];
    [muattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    self.totalmoneyLbl.attributedText = muattrStr;
    self.ordersignLbl.text = NSStringFormat(@"好货多-订单编号%@",ordersign);
    
}

@end
