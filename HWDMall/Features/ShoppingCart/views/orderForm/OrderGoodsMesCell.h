//
//  OrderGoodsMesCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderGoodsMesCell : UITableViewCell

- (void)updateGoodsMesWithHeadImage:(NSString *)headerurl
                          Goodsname:(NSString *)goodsname
                         Goodsprice:(CGFloat)price
                         GoodsGuige:(NSString *)guige
                           GoodsNum:(NSInteger)goodsnum;
@end

