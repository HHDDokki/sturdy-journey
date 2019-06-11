//
//  ConfirmDealAfterPayControllerViewController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/25.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmDealAfterPayControllerViewController.h"
#import "UILabel+TimeDown.h"
#import "AddAddressView.h"
#import "ConfirmOrderBottomMesView.h"

#define InvitBtnTitle @"邀请好友"
#define BackhomepageTitle @"返回首页"

@interface ConfirmDealAfterPayControllerViewController ()
@property (nonatomic,strong) UILabel *timedownLbl; // 倒计时
@property (nonatomic,strong) UILabel *personLackLbl; // 缺少人数
@property (nonatomic,strong) AddAddressView *invitBtn; // 邀请好友
@property (nonatomic,strong) AddAddressView *backHomepageBtn; // 返回首页
@property (nonatomic,strong) ConfirmOrderBottomMesView *ordermesView;
@end

@implementation ConfirmDealAfterPayControllerViewController

#pragma mark -- lazyload
- (ConfirmOrderBottomMesView *)ordermesView{
    if (!_ordermesView) {
        _ordermesView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConfirmOrderBottomMesView class]) owner:self options:nil]lastObject];
    }
    return _ordermesView;
}

- (AddAddressView *)invitBtn{
    if (!_invitBtn) {
        _invitBtn = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressView class]) owner:self options:nil]lastObject];
        _invitBtn.btnTitle = InvitBtnTitle;
    }
    __weak typeof(self) weakSelf = self;
    _invitBtn.addBlock = ^{
        [weakSelf invitAction];
    };
    return _invitBtn;
}

- (AddAddressView *)backHomepageBtn{
    if (!_backHomepageBtn) {
        _backHomepageBtn = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressView class]) owner:self options:nil]lastObject];
        _backHomepageBtn.btnTitle = BackhomepageTitle;
        _backHomepageBtn.btnColor = [UIColor whiteColor];
        _backHomepageBtn.titleColor = UIColorFromHex(0xED5E3B);
    }
    __weak typeof(self) weakSelf = self;
    _backHomepageBtn.addBlock = ^{
        [weakSelf backHomepageAction];
    };
    return _backHomepageBtn;
}

- (UILabel *)timedownLbl{
    if (!_timedownLbl) {
        _timedownLbl = [[UILabel alloc]init];
        _timedownLbl.font = kFont(15);
        _timedownLbl.textColor = UIColorFromHex(0x666666) ;
        _timedownLbl.textAlignment = NSTextAlignmentCenter;
        _timedownLbl.backgroundColor = [UIColor whiteColor];
    }
    return _timedownLbl;
}

- (UILabel *)personLackLbl{
    if (!_personLackLbl) {
        _personLackLbl = [[UILabel alloc]init];
        _personLackLbl.font = kFont(15);
        _personLackLbl.textColor = UIColorFromHex(0x666666);
        _personLackLbl.textAlignment = NSTextAlignmentCenter;
        
        _personLackLbl.backgroundColor = [UIColor whiteColor];
    }
    return _personLackLbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- setUI
- (void)setUI{
    [self.view addSubview:self.timedownLbl];
    [self.view addSubview:self.personLackLbl];
    [self.view addSubview:self.invitBtn];
    [self.view addSubview:self.backHomepageBtn];
    [self.view addSubview:self.ordermesView];
    [self.timedownLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(29 + kSafeAreaTopHeight);
        make.height.equalTo(15);
    }];
    [self.personLackLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(15);
        make.top.equalTo(self.timedownLbl.mas_bottom).offset(10);
    }];
    [self.invitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(50);
        make.top.equalTo(self.personLackLbl.mas_bottom).offset(30);
    }];
    [self.backHomepageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(50);
        make.top.equalTo(self.invitBtn.mas_bottom).offset(15);
    }];
    [self.ordermesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.backHomepageBtn.mas_bottom).offset(100);
        make.height.equalTo(60);
    }];
    
    NSString *personLackLblStr = @"还差1人，赶快邀请好友来拼单吧～～～";
    NSRange range = [personLackLblStr rangeOfString:@"1"];
    NSMutableAttributedString * muAttStr = [[NSMutableAttributedString alloc]initWithString:personLackLblStr];
    [muAttStr addAttribute:NSForegroundColorAttributeName value:UIColorFromHex(0xED5E3B) range:range];
    self.personLackLbl.attributedText = muAttStr;
    [self.timedownLbl startTime:100 title:@"00:00:00" waitTittle:@"剩余" timeStringColor:UIColorFromHex(0xED5E3B)];
}
#pragma mark -- buttonAction
- (void)invitAction{
        RDLog(@"邀请好友");
}

- (void)backHomepageAction{
    RDLog(@"返回首页");
    [[WebServiceTool shareHelper]postWithURLString:kApi_appLogin parameters:nil success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
