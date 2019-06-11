//
//  GoodsTypeBtnsCell.m
//  HWDMall
//
//  Created by sk on 2018/11/7.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "GoodsTypeBtnsCell.h"

@implementation GoodsTypeBtnsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setupViewCell];
    }
    return self;
}

- (void)setupViewCell {
    
    [self.layer setCornerRadius:(5)];
    [self.layer setMasksToBounds:YES];
    
    _propertyL = [UILabel new];
    _propertyL.textColor = [UIColor blackColor];
    _propertyL.font = [UIFont systemFontOfSize:12];
    _propertyL.numberOfLines = 0;
    _propertyL.textAlignment = NSTextAlignmentCenter;
    _propertyL.text = @"属性";
    [self.contentView addSubview:_propertyL];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.equalTo(self.contentView).offset(0);
        make.bottom.right.equalTo(self.contentView).offset(0);
    }];
    
    
}
@end
