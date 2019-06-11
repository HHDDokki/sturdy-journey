//
//  BFMallLogisticsCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/9.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallLogisticsCell.h"

@interface BFMallLogisticsCell ()

@property (nonatomic, strong) UILabel *logisticsNum;
@property (nonatomic, strong) UILabel *logisticsState;
@property (nonatomic, strong) UIImageView *goodsImg;
@property (nonatomic, strong) UILabel *goodsName;
@property (nonatomic, strong) UIButton *detailBtn;



@end

@implementation BFMallLogisticsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.logisticsNum];
    [self.contentView addSubview:self.logisticsState];
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.detailBtn];
    [self.contentView addSubview:self.goodsName];
    
    [_logisticsNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.
        
    }];
    [_logisticsState mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [_goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    
}

- (UILabel *)logisticsNum {
    
    if (!_logisticsNum) {
        _logisticsNum = [[UILabel alloc] init];
        _logisticsNum.font = kFont(14);
        _logisticsNum.textColor = [UIColor hexColor:@"#2D3640"];
        
    }
    return _logisticsNum;
    
}

- (UILabel *)logisticsState {
    
    if (!_logisticsState) {
        _logisticsState = [[UILabel alloc] init];
        _logisticsState.font = kMindleFont(15);
        _logisticsState.textColor = [UIColor hexColor:@"#FF7200"];
        
    }
    return _logisticsState;
    
}

- (UIImageView *)goodsImg {
    
    if (!_goodsImg) {
        _goodsImg = [[UIImageView alloc] init];

    }
    return _goodsImg;
    
}

- (UILabel *)goodsName {
    
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.font = kMindleFont(15);
        _goodsName.textColor = [UIColor hexColor:@"#2D3640"];
        _goodsName.numberOfLines = 2;

    }
    return _goodsName;
    
}

- (UIButton *)detailBtn {
    
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] init];
    }
    return _detailBtn;
    
}

@end
