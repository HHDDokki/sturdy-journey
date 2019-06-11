//
//  SelectPayWayView.m
//  HWDMall
//
//  Created by stewedr on 2018/12/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "SelectPayWayView.h"
#import "PaywayCell.h"

static NSString * const paywaycellID = @"PAYWANCELLID";

@interface SelectPayWayView()<UITableViewDelegate,UITableViewDataSource>
{
    Payway _payway; // 支付方式
}
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLbl; // 标题
@property (nonatomic,strong) UILabel *priceLbl;
@property (nonatomic,strong) UITableView * paywayTable; //
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UIButton *cancelBtn; // 删除button
@property (nonatomic,strong) UIView *line;


@property (nonatomic,strong) UIView *payWayView;
@property (nonatomic,strong) UIImageView *aliImg;
@property (nonatomic,strong) UIImageView *wxImg;
@property (nonatomic,strong) UILabel *aliView;
@property (nonatomic,strong) UILabel *wxView;
@property (nonatomic,strong) UIButton *aliBtn;
@property (nonatomic,strong) UIButton *wxBtn;


@end

@implementation SelectPayWayView

#pragma mark -- setUI

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromHex(0xeeeeee);
    }
    return _line;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)payWayView {
    
    if (!_payWayView) {
        _payWayView = [[UIView alloc]init];
        _payWayView.backgroundColor = [UIColor whiteColor];
        _payWayView.userInteractionEnabled = YES;

    }
    return _payWayView;
    
}

- (UIImageView *)aliImg {
    if (!_aliImg) {
        _aliImg = [[UIImageView alloc] init];
        [_aliImg setImage:IMAGE_NAME(@"支付宝")];
    }
    return _aliImg;
    
}

- (UIImageView *)wxImg {
    
    if (!_wxImg) {
        _wxImg = [[UIImageView alloc] init];
        [_wxImg setImage:IMAGE_NAME(@"微信")];
    }
    return _wxImg;
    
}

- (UILabel *)aliView {
    
    if (!_aliView) {
        _aliView = [[UILabel alloc] init];
        _aliView.font = kFont(14);
        _aliView.text = @"支付宝支付";
        _aliView.tag = Payway_Alipay + 100;
        UITapGestureRecognizer * topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topViewTapAction)];
        topTap.numberOfTapsRequired = 1;
        topTap.numberOfTouchesRequired = 1;
        _aliView.userInteractionEnabled = YES;
        [_aliView addGestureRecognizer:topTap];
    }
    return _aliView;
}

- (UILabel *)wxView {
    
    if (!_wxView) {
        _wxView = [[UILabel alloc] init];
        _wxView.font = kFont(14);
        _wxView.text = @"微信支付";
        _wxView.tag = Payway_Wxpay + 100;
        UITapGestureRecognizer * bottomTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomViewTapAction)];
        bottomTap.numberOfTouchesRequired = 1;
        bottomTap.numberOfTapsRequired = 1;
        _wxView.userInteractionEnabled = YES;
        [_wxView addGestureRecognizer:bottomTap];

    }
    return _wxView;
}

- (void)topViewTapAction{ // 点击上
    
    self.aliBtn.selected = YES;
    self.wxBtn.selected = NO;
    _payway = Payway_Alipay;
}

- (void)bottomViewTapAction{ // 点击下
    
    self.aliBtn.selected = NO;
    self.wxBtn.selected = YES;
    _payway = Payway_Wxpay;

}


- (UIButton *)aliBtn {
    
    if (!_aliBtn) {
        _aliBtn = [[UIButton alloc] init];
        [_aliBtn setImage:IMAGE_NAME(@"details_icon_service_normal") forState:UIControlStateNormal];
        [_aliBtn setImage:IMAGE_NAME(@"成为会员勾选") forState:UIControlStateSelected];
        _aliBtn.tag = Payway_Alipay + 100;
        [_aliBtn addTarget:self action:@selector(payWaySelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _aliBtn;
    
}

- (UIButton *)wxBtn {
    
    if (!_wxBtn) {
        _wxBtn = [[UIButton alloc] init];
        [_wxBtn setImage:IMAGE_NAME(@"details_icon_service_normal") forState:UIControlStateNormal];
        [_wxBtn setImage:IMAGE_NAME(@"成为会员勾选") forState:UIControlStateSelected];
        _wxBtn.tag = Payway_Wxpay + 100;
        [_wxBtn addTarget:self action:@selector(payWaySelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
    
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.text = @"请选择支付方式";
        _titleLbl.font = [UIFont boldSystemFontOfSize:14];
        _titleLbl.textColor = UIColorFromHex(0x333333);
        
    }
    return _titleLbl;
}

- (UILabel *)priceLbl {
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]init];
        _priceLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLbl;
}

- (UITableView *)paywayTable{
    if (!_paywayTable) {
        _paywayTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _paywayTable.delegate = self;
        _paywayTable.dataSource = self;
        _paywayTable.tableFooterView = [UIView new];
        _paywayTable.separatorStyle = UITableViewCellEditingStyleNone;
        [_paywayTable registerNib:[UINib nibWithNibName:NSStringFromClass([PaywayCell class]) bundle:nil] forCellReuseIdentifier:paywaycellID];
    }
    return _paywayTable;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = kFont(15);
        _confirmBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _confirmBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:GetImage(@"arrow_right_black_14") forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelBtn;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _payway = Payway_Wxpay;
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _payway = Payway_Wxpay;
        [self setUI];
    }
    return self;
}


#pragma mark -- setUI
- (void)setUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.confirmBtn];
//    [self.contentView addSubview:self.paywayTable];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.priceLbl];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(271);
    }];
    
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.width.equalTo(120);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(14);
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(15);
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(50);
    }];
    
//    [self.paywayTable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.contentView);
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.confirmBtn.mas_top);
//    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(45);
    }];
    
    UIView *line0 = [[UIView alloc] init];
    line0.backgroundColor = [UIColor hexColor:@"#EEEEEE"];
    [self.contentView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLbl.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(1);
    }];
    
    [self.contentView addSubview:self.payWayView];
    [self.payWayView addSubview:self.aliImg];
    [self.payWayView addSubview:self.wxImg];
    [self.payWayView addSubview:self.aliView];
    [self.payWayView addSubview:self.wxView];
    [self.payWayView addSubview:self.aliBtn];
    [self.payWayView addSubview:self.wxBtn];
    self.aliBtn.selected = YES;
    _payway = Payway_Alipay;
    
    [self.payWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLbl.mas_bottom);
        make.bottom.equalTo(self.confirmBtn.mas_top);
        make.width.equalTo(self.contentView.mas_width);
        make.left.equalTo(self.contentView.mas_left);
    }];
    
    [self.aliImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line0.mas_bottom).offset(16);
        make.width.height.equalTo(32);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor hexColor:@"#EEEEEE"];
    [self.payWayView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aliImg.mas_bottom).offset(17);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(1);
    }];
    [self.wxImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(18);
        make.width.height.equalTo(32);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    [self.aliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line0.mas_bottom);
        make.left.equalTo(self.aliImg.mas_right).offset(9);
        make.right.equalTo(self.aliBtn.mas_left);
        make.height.equalTo(65);
    }];
    [self.wxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(self.wxImg.mas_right).offset(9);
        make.right.equalTo(self.wxBtn.mas_left);
        make.height.equalTo(65);
    }];
    [self.aliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aliImg.mas_centerY);
        make.width.height.equalTo(17);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wxImg.mas_centerY);
        make.width.height.equalTo(17);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    
}

- (void)bindPrice:(CGFloat)price {
    NSString *a = NSStringFormat(@"请继续完成支付金额¥%.2f元",price);
    NSRange priceRange = [a rangeOfString:NSStringFormat(@"¥%.2f", price)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:a attributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"#0E0E0E"]}];
    [attributedString addAttribute:NSFontAttributeName value:kFont(12) range:NSMakeRange(0, priceRange.location)];
    [attributedString addAttribute:NSFontAttributeName value:kFont(17) range:NSMakeRange(priceRange.location, priceRange.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor hexColor:@"#FF7200"] range:priceRange];
    self.priceLbl.attributedText = attributedString;
}

#pragma mark -- BtnAction
- (void)deleteBtnAction{
    [self removeFromSuperview];
}

- (void)payWaySelect:(UIButton *)btn {
    _payway = btn.tag-100;
    if (_payway == Payway_Alipay) {
        self.wxBtn.selected = YES;
        self.aliBtn.selected = NO;
    }else {
        self.wxBtn.selected = NO;
        self.aliBtn.selected = YES;
    }
}

- (void)confirmBtnAction{

        if (self.payBlock) {
            self.payBlock(_payway);
        }
        [self removeFromSuperview];
    
}

#pragma mark -- tableviewdelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.paywayTable.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaywayCell * paycell = [tableView dequeueReusableCellWithIdentifier:paywaycellID];
    if (!paycell) {
        paycell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([paycell class]) owner:self options:nil]lastObject];
    }
    paycell.payBlock = ^(Payway payway) {
        self->_payway = payway;
    };
    paycell.titlehidden = YES;
    return paycell;
}

@end
