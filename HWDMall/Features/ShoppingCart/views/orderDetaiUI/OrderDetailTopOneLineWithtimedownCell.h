//
//  OrderDetailTopOneLineWithtimedownCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrderDetailTopOneLineWithtimedownCell : UITableViewCell  // 头部一行 带倒计时

@property (nonatomic,copy) TimeDownBlock timedownBlock;
@property (nonatomic,strong) TimedownModel * mytimedownmodel;

- (void)updateCellMesWithTitle:(NSString * )titleStr
                     HeadImage:(NSString *)headimage
                      TimeDown:(NSInteger )timedown;

@end


