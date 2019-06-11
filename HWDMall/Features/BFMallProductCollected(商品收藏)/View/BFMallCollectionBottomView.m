//
//  BFMallCollectionBottomView.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/2.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallCollectionBottomView.h"

@implementation BFMallCollectionBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(87);
        make.height.equalTo(24);
    }];
    
}

- (void)deleteBtnClicked:(UIButton *)sender {
    
    self.deleteBlock?self.deleteBlock():nil;
    
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        _deleteBtn.layer.cornerRadius = 12;
        _deleteBtn.layer.borderColor = UIColorFromHex(0x626262).CGColor;
        _deleteBtn.layer.borderWidth = 1;
        [_deleteBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor hexColor:@"#626262"] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = kFont(10);
        [_deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end
