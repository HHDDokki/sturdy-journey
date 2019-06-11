//
//  OrderInvalidCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderInvalidCell.h"

@implementation OrderInvalidCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setGradientBackgroundWithColors:@[[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1],[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
