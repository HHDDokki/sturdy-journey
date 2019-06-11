//
//  BFMallIOrderVipChoiceCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/3.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallIOrderVipChoiceCell.h"
#import "BFMallVipRightsDescView.h"

@interface BFMallIOrderVipChoiceCell ()

@property (nonatomic, strong) BFMallVipRightsDescView *vipDescView;
@property (nonatomic, strong) UIButton *manIconBtn;
@property (nonatomic, strong) UILabel *vipTag;
@property (nonatomic, strong) UILabel *vipOrderDescLab;
@property (nonatomic, strong) UILabel *vipPriceLab;

@end

@implementation BFMallIOrderVipChoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.choiceBtn];
    [self.contentView addSubview:self.manIconBtn];
    [self.contentView addSubview:self.vipTag];
    [self.contentView addSubview:self.vipOrderDescLab];
    [self.contentView addSubview:self.vipPriceLab];

    
    self.choiceBtn.frame = CGRectMake(15, 28, 17, 17);

    [self.manIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(17);
        make.left.equalTo(self.choiceBtn.mas_right).offset(11);
        make.width.equalTo(67);
        make.height.equalTo(18);
        
    }];
    
    [self.vipTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manIconBtn.mas_right).offset(7);
        make.top.equalTo(self.contentView.mas_top).offset(17);
        make.width.equalTo(45);
        make.height.equalTo(14);
        
    }];
    self.vipTag.layer.cornerRadius = 2;

    
    [self.vipOrderDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manIconBtn.mas_left);
        make.top.equalTo(self.manIconBtn.mas_bottom).offset(3);
        make.right.equalTo(self.vipPriceLab.mas_left);
        make.height.equalTo(16);
    }];
    
    [self.vipPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vipOrderDescLab.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.equalTo(100);
        make.height.equalTo(13);
        
    }];
    
    
    BFMallVipRightsDescView *vipRightsDescView = [[BFMallVipRightsDescView alloc] init];
    [self.contentView addSubview:vipRightsDescView];
    
    [vipRightsDescView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-17);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(58);
    }];
    
}

- (void)changeState:(NSInteger)state {
    if (state) {
        self.choiceBtn.frame = CGRectMake(0, 0, 0, 0);
        self.choiceBtn.hidden = YES;
    }else {
        self.choiceBtn.frame = CGRectMake(15, 28, 17, 17);
    }
}

- (void)updateSavedPrice:(CGFloat)savePrice {
    
    NSString *a = NSStringFormat(@"本单将为您节省%.2f元",savePrice);
    NSRange priceRange = [a rangeOfString:NSStringFormat(@"%.2f", savePrice)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:a attributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"#2D3640"]}];
    [attributedString addAttribute:NSFontAttributeName value:kFont(13) range:NSMakeRange(0, priceRange.location)];
    [attributedString addAttribute:NSFontAttributeName value:kFont(13) range:NSMakeRange(a.length-1, 1)];
    [attributedString addAttribute:NSFontAttributeName value:kFont(17) range:NSMakeRange(priceRange.location, priceRange.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor hexColor:@"#FF7200"] range:priceRange];
    
    self.vipOrderDescLab.attributedText = attributedString;
}

- (void)updateVipPrice:(CGFloat)VipPrice TotalSavedPrice:(CGFloat)savePrice {
    
    NSString *a = NSStringFormat(@"成为会员，本单将节省%.2f元",savePrice);
    NSRange priceRange = [a rangeOfString:NSStringFormat(@"%.2f", savePrice)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:a attributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"#2D3640"]}];
    [attributedString addAttribute:NSFontAttributeName value:kFont(13) range:NSMakeRange(0, priceRange.location)];
    [attributedString addAttribute:NSFontAttributeName value:kFont(13) range:NSMakeRange(a.length-1, 1)];
    [attributedString addAttribute:NSFontAttributeName value:kFont(17) range:NSMakeRange(priceRange.location, priceRange.length-1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor hexColor:@"#FF7200"] range:priceRange];

    self.vipOrderDescLab.attributedText = attributedString;
    [self.vipOrderDescLab sizeToFit];
    self.vipPriceLab.text = NSStringFormat(@"¥%.2f/年", VipPrice);
    
    
}

- (void)vipChoiceClicked:(UIButton *)sender {
    
    sender.selected ^= 1;
    self.vipChoiceBlock? self.vipChoiceBlock(sender.selected) : nil;
}

#pragma mark  -- lazyLoad
- (UIButton *)choiceBtn {
    
    if (!_choiceBtn) {
        _choiceBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_choiceBtn setImage:IMAGE_NAME(@"成为会员勾选") forState:UIControlStateSelected];
        [_choiceBtn setImage:IMAGE_NAME(@"login_unconfirm") forState:UIControlStateNormal];
        [_choiceBtn addTarget:self action:@selector(vipChoiceClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choiceBtn;
    
}

- (UIButton *)manIconBtn {
    
    if (!_manIconBtn) {
        _manIconBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_manIconBtn setImage:IMAGE_NAME(@"man_black") forState:UIControlStateNormal];
        [_manIconBtn setTitle:@"会员" forState:UIControlStateNormal];
        [_manIconBtn setTitleColor:[UIColor hexColor:@"#000000"] forState:UIControlStateNormal];
        _manIconBtn.titleLabel.font = kBoldFont(14);
        
    }
    return _manIconBtn;
    
}

- (UILabel *)vipTag {
    if (!_vipTag) {
        _vipTag = [[UILabel alloc] initWithFrame:CGRectZero];
        _vipTag.backgroundColor = [UIColor hexColor:@"#CCD5E0"];
        _vipTag.text = @"会员权益";
        _vipTag.textColor = [UIColor whiteColor];
        _vipTag.font = kFont(8);
        _vipTag.textAlignment = NSTextAlignmentCenter;
    }
    return _vipTag;
    
}

- (UILabel *)vipOrderDescLab {
    
    if (!_vipOrderDescLab) {
        _vipOrderDescLab = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _vipOrderDescLab;
    
}

- (UILabel *)vipPriceLab {
    
    if (!_vipPriceLab) {
        _vipPriceLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _vipPriceLab.textColor = [UIColor hexColor:@"#FF7200"];
        _vipPriceLab.font = kFont(12);
        _vipPriceLab.textAlignment = NSTextAlignmentRight;
    }
    return _vipPriceLab;
    
}

@end
