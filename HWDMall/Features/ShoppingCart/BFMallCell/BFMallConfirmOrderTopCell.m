//
//  BFMallConfirmOrderTopCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallConfirmOrderTopCell.h"

@interface BFMallConfirmOrderTopCell ()

@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIButton *addAddressBtn;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation BFMallConfirmOrderTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.addAddressBtn];
    [self.contentView addSubview:self.descLab];
//    [self.contentView addSubview:self.bottomLine];
    
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.width.equalTo(self.contentView.mas_width);
//        make.height.equalTo(8);
//    }];

    [self.addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(17);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.height.equalTo(30);
    }];
        
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(15);
        make.top.equalTo(self.addAddressBtn.mas_bottom).offset(11);
    }];
}


- (void)addAddress {
    
    if (self.addAddressBlock) {
        self.addAddressBlock();
    }
}

#pragma mark -- lazyLoad
- (UIButton *)addAddressBtn {
    if (!_addAddressBtn) {
        _addAddressBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_addAddressBtn setImage:IMAGE_NAME(@"添加收货地址") forState:UIControlStateNormal];
        [_addAddressBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLab.text = @"请您添加收货地址";
        _descLab.font = kFont(14);
        _descLab.textAlignment = NSTextAlignmentCenter;
    }
    return _descLab;
}

//- (UIView *)bottomLine {
//    
//    if (!_bottomLine) {
//        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
//        _bottomLine.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
//    }
//    return _bottomLine;
//    
//}

@end
