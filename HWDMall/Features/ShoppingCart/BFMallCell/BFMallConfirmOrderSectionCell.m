//
//  BFMallConfirmOrderSectionCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallConfirmOrderSectionCell.h"

@interface BFMallConfirmOrderSectionCell ()

@property (nonatomic, strong) UILabel *orderName;

@end;

@implementation BFMallConfirmOrderSectionCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.bfmallIcon];
        [self.contentView addSubview:self.orderName];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(self.contentView.mas_width).offset(-15);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.height.equalTo(15);
        }];
        
        [self.bfmallIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.equalTo(37);
            make.height.equalTo(17);
        }];
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.bottom.equalTo(self.contentView.mas_bottom);
            make.centerY.equalTo(self.bfmallIcon.mas_centerY);
            make.left.equalTo(self.bfmallIcon.mas_right).offset(3);
            make.width.equalTo(40);
            make.height.equalTo(15);
            
        }];
        
        [self.orderName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.bfmallIcon.mas_centerY);
            make.width.equalTo(90);
            make.height.equalTo(13);
            
        }];
        
        self.bfmallIcon.hidden = YES;
        self.descLabel.hidden = YES;
        self.orderName.hidden = YES;
        
    }
    return self;
}

- (void)bindDetailModel {
    
    self.bfmallIcon.hidden = NO;
    self.descLabel.hidden = NO;
    self.orderName.hidden = YES;
    self.titleLabel.hidden = YES;
    
}

- (void)updateHeaderWithMoreShops:(BOOL)haveShops
                         ShopName:(NSString *)shopName
                   AndOrderStatus:(NSString *)shopStatus{
//    if (haveShops) { // 多个店铺显示好货多logo 和 好货多商城
//        [self.shopName setTitle:@"好货多" forState:UIControlStateNormal];
//    }else{
//        [self.shopName setTitle:shopName forState:UIControlStateNormal];
//    }
    self.bfmallIcon.hidden = NO;
    self.descLabel.hidden = NO;
    self.titleLabel.hidden = YES;
    self.orderName.hidden = NO;
    self.orderName.text = shopStatus;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = kFont(14);
        _titleLabel.textColor = [UIColor hexColor:@"#2D3640"];
        _titleLabel.text = @"选购商品";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLabel;
}

- (UIImageView *)bfmallIcon {
    
    if (!_bfmallIcon) {
        
        _bfmallIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_bfmallIcon setImage:IMAGE_NAME(@"man_black")];
        
    }
    return _bfmallIcon;
    
}

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.text = @"商品";
        _descLabel.font = kBoldFont(14);
        _descLabel.textColor = [UIColor hexColor:@"#2D3640"];

    }
    return _descLabel;
    
}

- (UILabel *)orderName {
    
    if (!_orderName) {
        
        _orderName = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderName.font = kFont(14);
        _orderName.textColor = [UIColor hexColor:@"#FF7200"];
        _orderName.textAlignment = NSTextAlignmentRight;
        _orderName.text = @"待付款";
        
    }
    return _orderName;
    
}

@end
