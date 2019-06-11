//
//  BFMallDetailBottomBar.m
//  BFMan
//
//  Created by HandC1 on 2019/5/26.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallDetailBottomBar.h"
#import "UIButton+Badge.h"

@interface BFMallDetailBottomBar ()

@property (nonatomic, strong) UIView *oShadowView;
@property (nonatomic, strong) UIView *rShadowView;
@property (nonatomic, strong) UIView *lShadowView;

@end

@implementation BFMallDetailBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initRightView];
        
    }
    return self;
}

- (void)initRightView {

    self.rShadowView = [[UIView alloc] init];
    self.rShadowView.layer.shadowColor = [UIColor hexColor:@"#CA610C"].CGColor;
    self.rShadowView.layer.shadowOffset = CGSizeMake(0, 4);
    self.rShadowView.layer.shadowOpacity = 0.6f;
    self.rShadowView.layer.shadowRadius = 3.0;
    self.rShadowView.layer.cornerRadius = 5.0;
    self.rShadowView.clipsToBounds = NO;
    [self addSubview:self.rShadowView];
    
    [self.rShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(120);
        make.height.equalTo(40);
        make.right.equalTo(self.mas_right).offset(-15);
    }];

    [self.rShadowView addSubview:self.rRightBtn];
    
    
    self.lShadowView = [[UIView alloc] init];
    self.lShadowView.layer.shadowColor = [UIColor hexColor:@"#3A6698"].CGColor;
    self.lShadowView.layer.shadowOffset = CGSizeMake(0, 4);
    self.lShadowView.layer.shadowOpacity = 0.6f;
    self.lShadowView.layer.shadowRadius = 3.0;
    self.lShadowView.layer.cornerRadius = 5.0;
    self.lShadowView.clipsToBounds = NO;
    [self addSubview:self.lShadowView];
    
    [self.lShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(120);
        make.height.equalTo(40);
        make.right.equalTo(self.rShadowView.mas_left).offset(-7);
    }];
    
    [self.lShadowView addSubview:self.rLeftBtn];
    
    [self addSubview:self.shoppingCartBtn];
    [self.shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(60);
        make.centerY.equalTo(self.lShadowView);
        make.width.equalTo(30);
        make.height.equalTo(36);
    }];
    _shoppingCartBtn = [self setLBtn:_shoppingCartBtn];
    
    self.oShadowView = [[UIView alloc] init];
    self.oShadowView.layer.shadowColor = [UIColor hexColor:@"#3A6698"].CGColor;
    self.oShadowView.layer.shadowOffset = CGSizeMake(0, 4);
    self.oShadowView.layer.shadowOpacity = 0.6f;
    self.oShadowView.layer.shadowRadius = 3.0;
    self.oShadowView.layer.cornerRadius = 5.0;
    self.oShadowView.clipsToBounds = NO;
    [self addSubview:self.oShadowView];
    
    [self.oShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(226);
        make.height.equalTo(40);
        make.right.equalTo(self.mas_right).offset(-7);
    }];
    [self.oShadowView addSubview:self.rOneBtn];
    self.oShadowView.hidden = YES;

}

- (void)bindModel:(BFMallGoodsDetailModel *)model carCount:(NSString *)cartCount BuyState:(BuyState)type {
    if (model.status != 4) {
        self.oShadowView.hidden = YES;
        self.rShadowView.hidden = NO;
        self.lShadowView.hidden = NO;
    }
    [self.shoppingCartBtn setBadge:cartCount andFont:8 cornerRadius:self.shoppingCartBtn.width/2];
}

#pragma - mark click
-(void)rbtnClick:(UIButton *)btn{
    
    //tag 101加入购物车 
    int userT =  [GVUserDefaults standardUserDefaults].userType;
//    if (userT == 0) {
        // 未登录 跳转登录
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[PhoneLoginController alloc] init]];
//        [[ToolsManage getCurrentVC] presentViewController:nav animated:YES completion:nil];
//    }else{
        if ([self.delegate respondsToSelector:@selector(openCus:)]) {
            [self.delegate openCus:btn.tag];
        }
//    }
    
}

//打开购物车
-(void)openGWCClick {
    
    int userT =  [GVUserDefaults standardUserDefaults].userType;
//    if (userT == 0) {
//        // 未登录 跳转登录
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[PhoneLoginController alloc] init]];
//        [[ToolsManage getCurrentVC] presentViewController:nav animated:YES completion:nil];
//    }else{
    if (self.openGWCBlock) {
        self.openGWCBlock();
    }
    
//    }
    
}

- (UIButton *)shoppingCartBtn {
    if (!_shoppingCartBtn) {
        _shoppingCartBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_shoppingCartBtn setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
        [_shoppingCartBtn setTitle:@"购物车" forState:UIControlStateNormal];
        [_shoppingCartBtn setTitleColor:[UIColor hexColor:@"#2D3640"] forState:UIControlStateNormal];
        _shoppingCartBtn.titleLabel.font = kBoldFont(8);
        [_shoppingCartBtn addTarget:self action:@selector(openGWCClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shoppingCartBtn;
    
}

- (UIButton *)setLBtn:(UIButton *)btn{
    
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height + 3), 0);
    
    return btn;
}

- (UIButton *)rOneBtn {
    if (!_rOneBtn) {
        _rOneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 226, 40)];
        [UIBezierPath bezierRoundView:_rOneBtn withRadii:CGSizeMake(20, 20)];
        _rOneBtn.backgroundColor = [UIColor hexColor:@"#C5C8CC"];
        [_rOneBtn setTitleColor:[UIColor hexColor:@"#FFFFFF"] forState:UIControlStateNormal];
        [_rOneBtn setTitle:@"已下架" forState:UIControlStateNormal];
        _rOneBtn.titleLabel.font = kFont(15);
        
    }
    return _rOneBtn;
    
}

- (UIButton *)rLeftBtn {
    
    if (!_rLeftBtn) {
        _rLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        [UIBezierPath bezierRoundView:_rLeftBtn withRadii:CGSizeMake(20, 20)];
        _rLeftBtn.backgroundColor = [UIColor hexColor:@"#2D3640"];
        [_rLeftBtn setTitleColor:[UIColor hexColor:@"#FFFFFF"] forState:UIControlStateNormal];
        [_rLeftBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _rLeftBtn.titleLabel.font = kFont(15);
        _rLeftBtn.tag = 101;
        [_rLeftBtn addTarget:self action:@selector(rbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rLeftBtn;
    
}

- (UIButton *)rRightBtn {
    
    if (!_rRightBtn) {
        _rRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        [UIBezierPath bezierRoundView:_rRightBtn withRadii:CGSizeMake(20, 20)];
        _rRightBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
        [_rRightBtn setTitleColor:[UIColor hexColor:@"#FFFFFF"] forState:UIControlStateNormal];
        [_rRightBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _rRightBtn.titleLabel.font = kFont(15);
        _rRightBtn.tag = 102;
        [_rRightBtn addTarget:self action:@selector(rbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rRightBtn;
    
}
@end
