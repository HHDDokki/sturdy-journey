//
//  BFMallCollectionCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/2.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BFMallCollectionCell ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *goodsImg;
@property (nonatomic, strong) UILabel *goodsName;
@property (nonatomic, strong) UILabel *goodsDesc;
@property (nonatomic, strong) UILabel *goodsTag;

@end

@implementation BFMallCollectionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.goodsName];
    [self.contentView addSubview:self.goodsDesc];
    [self.contentView addSubview:self.goodsTag];
    
    self.selectBtn.frame = CGRectMake(0, 0, 0, 0);
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(9);
        make.left.equalTo(self.selectBtn.mas_right);
        make.width.height.equalTo(86);
    }];
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImg.mas_top);
        make.left.equalTo(self.goodsImg.mas_right).offset(7);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.height.equalTo(30);
    }];
    
    [self.goodsDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsName.mas_bottom).offset(8);
        make.left.equalTo(self.goodsImg.mas_right).offset(7);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.height.equalTo(11);
    }];
    
    [self.goodsTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsDesc.mas_bottom).offset(19);
        make.left.equalTo(self.goodsImg.mas_right).offset(7);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.height.equalTo(14);
    }];
    
}

- (void)bindModel:(BFMallCollectionDetailModel *)model {
    
//    self.selectBtn.selected = model.isSelectedStatus;
    [self.goodsImg sd_setImageWithURL:URL_STR(model.imgUrl) placeholderImage:IMAGE_NAME(@"")];
    self.goodsName.text = model.articleTitle;
    [self.goodsName resizeLabelVertical];
    NSArray *catNames = [model.catNames componentsSeparatedByString:@","];
    NSString *goodsDescStr;
    for (int i = 0; i < catNames.count; i++) {
        if (i == 0) {
            goodsDescStr = NSStringFormat(@"#%@",catNames[0]);
        }else {
            goodsDescStr = NSStringFormat(@"%@ #%@",goodsDescStr,catNames[i]);
        }
    }
    self.selectBtn.selected = model.isSelectedStatus;
    self.goodsDesc.text = goodsDescStr;
    [self.goodsDesc resizeLabelVertical];
    self.goodsTag.text = model.articleContent;
    [self.goodsTag sizeToFit];
    self.goodsTag.backgroundColor = [UIColor greenColor];
    
}

- (void)stateChangeWithState:(BOOL)state {
    if (state) {
        self.selectBtn.frame = CGRectMake(0, 0, 41, 114);
    }else {
        self.selectBtn.frame = CGRectMake(0, 0, 14, 0);
    }
}

- (void)selectAction:(id)sender {
    
    if ([sender isEqual:self.selectBtn]){
        self.selectBtn.selected ^= 1;
        if (self.selectedBlock) {
            self.selectedBlock(self.selectBtn.isSelected);
        }
    }
    
}

#pragma mark -- setter & getter
- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn setImage:IMAGE_NAME(@"login_unconfirm") forState:UIControlStateNormal];
        [_selectBtn setImage:IMAGE_NAME(@"login_confirm") forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
    
}

- (UIImageView *)goodsImg {
    
    if (!_goodsImg) {
        _goodsImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _goodsImg;
    
}

- (UILabel *)goodsName {
    
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsName.textColor = [UIColor hexColor:@"#2D3640"];
        _goodsName.font = kFont(14);
        [_goodsName setNumberOfLines:2];
    }
    return _goodsName;
    
}

- (UILabel *)goodsDesc {
    
    if (!_goodsDesc) {
        _goodsDesc = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsDesc.font = kFont(10);
        _goodsDesc.textColor = [UIColor hexColor:@"#2D3640"];
    }
    return _goodsDesc;
}

- (UILabel *)goodsTag {
    
    if (!_goodsTag) {
        _goodsTag = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsTag.font = kFont(8);
        _goodsTag.textColor = [UIColor whiteColor];
    }
    return _goodsTag;
    
}

@end
