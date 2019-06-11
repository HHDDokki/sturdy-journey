//
//  BFMallShoppingcartHeaderView.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/29.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallShoppingcartHeaderView.h"

@interface BFMallShoppingcartHeaderView ()

@property (nonatomic, strong) UILabel *selectAllLabel;

@end

@implementation BFMallShoppingcartHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self addSubview:self.selectAllLabel];
    [self addSubview:self.selectedBtn];
    [self addSubview:self.deleteBtn];

    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(16);
        make.left.equalTo(self.mas_left).offset(14);
        make.width.height.equalTo(17);

    }];

    [self.selectAllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectedBtn.mas_centerY);
        make.left.equalTo(self.mas_left).offset(41);
        make.width.equalTo(50);
        make.height.equalTo(15);
    }];

    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectedBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-14);
        make.width.equalTo(14);
        make.height.equalTo(16);
    }];
    
}

#pragma mark -- btnClicked
- (void)deleteAction:(id)sender {
    RDLog(@"删除");
    _deleteBlock ? self.deleteBlock() : nil;
}

- (void)selectAllAction:(id)sender {
    
    if ([sender isEqual:self.selectedBtn]){
//        self.selectedBtn.selected ^= 1;
        if (self.selectedBlock) {
            self.selectedBlock(self.selectedBtn.isSelected);
        }
    }
    
}

- (void)setIsAllSelected:(BOOL)isAllSelected{
    if (_isAllSelected != isAllSelected) {
        _isAllSelected = isAllSelected;
    }
    self.selectedBtn.selected = isAllSelected;
}


#pragma mark -- lazyload
- (UILabel *)selectAllLabel {
    
    if (!_selectAllLabel) {
        _selectAllLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _selectAllLabel.font = kFont(14);
        _selectAllLabel.text = @"全选";
        _selectAllLabel.textColor = [UIColor blackColor];
    }
    return _selectAllLabel;
    
}

- (UIButton *)selectedBtn {
    
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectedBtn setImage:IMAGE_NAME(@"login_unconfirm") forState:UIControlStateNormal];
        [_selectedBtn setImage:IMAGE_NAME(@"成为会员勾选") forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
    
}

- (UIButton *)deleteBtn {
    
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBtn setImage:IMAGE_NAME(@"删除") forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
    
}

@end
