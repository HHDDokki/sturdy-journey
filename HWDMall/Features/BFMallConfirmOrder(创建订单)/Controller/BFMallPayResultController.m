//
//  BFMallPayResultController.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/9.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallPayResultController.h"

@interface BFMallPayResultController ()

@property (nonatomic,strong) UIImageView *headimage;
@property (nonatomic,strong) UILabel *resultDescLbl;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *serviceBtn;

@end

@implementation BFMallPayResultController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"支付结果"]];
    [self setNav];
    [self setUI];
}

- (void)setUI {
    
    [self.view addSubview:self.headimage];
    [self.view addSubview:self.resultDescLbl];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.serviceBtn];
    
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(kSafeAreaTopHeight + 43);
        make.width.height.equalTo(60);
    }];
    
    [self.resultDescLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.headimage.mas_bottom).offset(12);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(20);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headimage.mas_bottom).offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(227);
        make.height.equalTo(40);
    }];
    
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn.mas_bottom).offset(8);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(227);
        make.height.equalTo(40);
    }];
    
}

- (void)updateMesWith:(BOOL)state {
    
    if (state) {
        self.serviceBtn.hidden = YES;
        self.resultDescLbl.text = @"您已支付成功";
    }else {
        
        [self.headimage setImage:IMAGE_NAME(@"失败")];
        self.resultDescLbl.text = @"支付失败";
        self.serviceBtn.hidden = NO;
    }
    
}

- (void)serviceBtnClicked:(id)sender {
    
    
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

#pragma mark -- lazyLoad
- (UIImageView *)headimage {
    
    if (!_headimage) {
        _headimage = [[UIImageView alloc] init];
        [_headimage setImage:IMAGE_NAME(@"成功")];
    }
    return _headimage;
    
}

- (UILabel *)resultDescLbl {
    
    if (!_resultDescLbl) {
        _resultDescLbl = [[UILabel alloc] init];
        _resultDescLbl.textColor = [UIColor blackColor];
        _resultDescLbl.font = kFont(17);
        _resultDescLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _resultDescLbl;
    
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"返回商城" forState:UIControlStateNormal];
        _backBtn.titleLabel.font = kFont(15);
        _backBtn.layer.cornerRadius = 20;
        _backBtn.layer.borderColor = UIColorFromHex(0xFF7200).CGColor;
        _backBtn.layer.borderWidth = 1;
        _backBtn.backgroundColor  = [UIColor hexColor:@"#FF7200"];
        [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
    
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, 22, 44);
        [_closeBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIButton *)serviceBtn {
    
    if (!_serviceBtn) {
        _serviceBtn = [[UIButton alloc] init];
        [_serviceBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
        [_serviceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        _serviceBtn.titleLabel.font = kFont(15);
        _serviceBtn.layer.cornerRadius = 20;
        _serviceBtn.layer.borderColor = UIColorFromHex(0xFF7200).CGColor;
        _serviceBtn.layer.borderWidth = 1;
        [_serviceBtn setTitleColor:[UIColor hexColor:@"#FF7200"] forState:UIControlStateNormal];
        [_serviceBtn addTarget:self action:@selector(serviceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceBtn;
    
}


@end
