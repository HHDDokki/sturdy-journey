//
//  BFMallVipRightsCusView.m
//  BFMan
//
//  Created by HandC1 on 2019/5/23.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallVipRightsCusView.h"

@implementation BFMallVipRightsCusView

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    return _imageView;
}

- (UILabel *)highLightLabel {
    if (!_highLightLabel) {
        _highLightLabel = [UILabel new];
        _highLightLabel.textColor = [UIColor hexColor:@"#C39B68"];
        _highLightLabel.font = kFont(12);
        _highLightLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_highLightLabel];
        [_highLightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(8);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(13);
            make.width.equalTo(self.mas_width);
        }];
    }
    return _highLightLabel;
}

- (UILabel *)normalLabel {
    if (!_normalLabel) {
        _normalLabel = [UILabel new];
        _normalLabel.textColor = [UIColor hexColor:@"#8C8C8C"];
        _normalLabel.font = kFont(10);
        _normalLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_normalLabel];
        [_normalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.highLightLabel.mas_bottom).offset(4);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(11);
            make.width.equalTo(self.mas_width);
        }];
    }
    return _normalLabel;
}

@end
