//
//  BFMallVipRightsDescView.m
//  BFMan
//
//  Created by HandC1 on 2019/5/23.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallVipRightsDescView.h"
#import "BFMallVipRightsCusView.h"

@interface BFMallVipRightsDescView ()

@property (nonatomic, strong) BFMallVipRightsCusView *fstView;
@property (nonatomic, strong) BFMallVipRightsCusView *secView;
@property (nonatomic, strong) BFMallVipRightsCusView *thrView;
@property (nonatomic, strong) BFMallVipRightsCusView *fthView;

@end

@implementation BFMallVipRightsDescView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.fstView = [[BFMallVipRightsCusView alloc] initWithFrame:CGRectZero];
    self.secView = [[BFMallVipRightsCusView alloc] initWithFrame:CGRectZero];
    self.thrView = [[BFMallVipRightsCusView alloc] initWithFrame:CGRectZero];
    self.fthView = [[BFMallVipRightsCusView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.fstView];
    [self addSubview:self.secView];
    [self addSubview:self.thrView];
    [self addSubview:self.fthView];
    
    CGFloat width = SCREEN_W / 4.0;
    
    [self.fstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(width);
        make.top.equalTo(0);
        make.height.equalTo(58);
    }];
    [self.fstView.imageView setImage:IMAGE_NAME(@"商品折扣")];
    self.fstView.highLightLabel.text = @"商品95折起";
    self.fstView.normalLabel.text = @"尊享会员成本价";

    [self.secView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fstView.mas_right);
        make.width.equalTo(width);
        make.top.equalTo(0);
        make.height.equalTo(58);
    }];
    [self.secView.imageView setImage:IMAGE_NAME(@"30天退换")];
    self.secView.highLightLabel.text = @"30天内退换货";
    self.secView.normalLabel.text = @"免费上门取件";
    
    [self.thrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secView.mas_right);
        make.width.equalTo(width);
        make.top.equalTo(0);
        make.height.equalTo(58);
    }];
    [self.thrView.imageView setImage:IMAGE_NAME(@"每月试用")];
    self.thrView.highLightLabel.text = @"每月1件";
    self.thrView.normalLabel.text = @"免费试用";
    
    [self.fthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thrView.mas_right);
        make.width.equalTo(width);
        make.top.equalTo(0);
        make.height.equalTo(58);
    }];
    [self.fthView.imageView setImage:IMAGE_NAME(@"24小时客服")];
    self.fthView.highLightLabel.text = @"7x24客服";
    self.fthView.normalLabel.text = @"专享管家";
    
}

@end
