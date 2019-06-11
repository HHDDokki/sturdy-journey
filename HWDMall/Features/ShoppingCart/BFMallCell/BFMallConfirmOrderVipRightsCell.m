//
//  BFMallConfirmOrderVipRightsCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/27.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallConfirmOrderVipRightsCell.h"

@interface BFMallConfirmOrderVipRightsCell ()

@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UILabel *priceLab;

@end

@implementation BFMallConfirmOrderVipRightsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.descLab];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(28);
        make.width.height.equalTo(17);
    }];
    
    UIImageView *vipIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [vipIcon setImage:IMAGE_NAME(@"")];
    vipIcon.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:vipIcon];
    [vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(42);
        make.top.equalTo(17);
        make.width.equalTo(37);
        make.height.equalTo(17);
    }];
    
    UILabel *vipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    vipLabel.textColor = [UIColor hexColor:@"#0E0E0E"];
    vipLabel.font = kFont(14);
    vipLabel.text = @"会员";
    [self.contentView addSubview:vipLabel];
    [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipIcon.mas_right).offset(3);
        make.top.equalTo(self.contentView.mas_top).offset(17);
        make.width.equalTo(27);
        make.height.equalTo(15);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(40);
        make.width.equalTo(70);
        make.height.equalTo(12);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(42);
        make.top.equalTo(vipIcon.mas_top).offset(40);
        make.right.equalTo(self.priceLab.mas_left);
        make.height.equalTo(16);
    }];
    
}

#pragma mark -- lazyload
- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
    }
    return _selectBtn;
    
}

- (UILabel *)descLab {
    
    if (!_descLab) {
        _descLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLab.font = kFont(12);
    }
    return _descLab;
    
}

- (UILabel *)priceLab {
    
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLab.font = kFont(12);
        _priceLab.textColor = [UIColor hexColor:@"#FF7200"];
        _priceLab.text = @"￥199.00/年";
    }
    return _priceLab;
    
}

@end
