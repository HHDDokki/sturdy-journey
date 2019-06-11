//
//  BFMallConfirmOrderAddressCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/27.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallConfirmOrderAddressCell.h"

@implementation BFMallConfirmOrderAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.phoneLab];
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.arrowImg];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(24);
        make.width.equalTo(18);
        make.height.equalTo(19);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icon.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.width.equalTo(5);
        make.height.equalTo(8);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(42);
        make.top.equalTo(12);
        make.width.equalTo(120);
        make.height.equalTo(20);
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLab.right).offset(50);
        make.top.equalTo(12);
        make.width.equalTo(1);
        make.height.equalTo(20);
        
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(42);
        make.top.equalTo(self.nameLab.mas_bottom).offset(4);
        make.right.equalTo(self.contentView.right).offset(-50);
        make.height.equalTo(30);
        
    }];
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
//    lineView.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
//    [self.contentView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.width.equalTo(SCREEN_W);
//        make.height.equalTo(8);
//        make.left.equalTo(0);
//
//    }];
    
}

- (void)updateCellMesWithName:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address{
    self.nameLab.text = NSStringFormat(@"收货人:%@",name);
    CGFloat nameWidth = [UILabel getWidthWithTitle:self.nameLab.text font:kFont(14)];
    if (nameWidth > 120) {
        nameWidth = 120;
    }
    self.nameLab.width =  nameWidth;
    self.phoneLab.text = [NSString PhoneWithSecret:phone];
    self.phoneLab.left = self.nameLab.right + 40;
    [self.phoneLab sizeToFit];
    self.addressLab.text = NSStringFormat(@"收货地址:%@",address);
    [self.addressLab resizeLabelVertical];
}

- (UIImageView *)icon {
    
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_icon setImage:IMAGE_NAME(@"收货地址")];
    }
    return _icon;
    
}

- (UILabel *)nameLab {
    
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLab.font = kFont(14);
        _nameLab.textColor = [UIColor hexColor:@"#000000"];
    }
    return _nameLab;
}

- (UILabel *)phoneLab {
    
    if (!_phoneLab) {
        
        _phoneLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLab.textColor = [UIColor hexColor:@"#000000"];
        _phoneLab.font = kFont(14);
    }
    return _phoneLab;
    
}

- (UILabel *)addressLab {
    
    if (!_addressLab) {
    
        _addressLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLab.font = kFont(14);
        _addressLab.textColor = [UIColor hexColor:@"#000000"];
        _addressLab.numberOfLines = 2;
        
    }
    return _addressLab;
    
}

- (UIButton *)arrowImg {
    
    if (!_arrowImg) {
        _arrowImg = [[UIButton alloc] initWithFrame:CGRectZero];
        [_arrowImg setImage:[UIImage imageNamed:@"details_nav_icon_jump_normal"] forState:UIControlStateNormal];
    }
    return _arrowImg;
    
}

@end
