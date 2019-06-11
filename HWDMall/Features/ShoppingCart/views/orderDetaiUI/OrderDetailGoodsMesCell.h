//
//  OrderDetailGoodsMesCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface OrderDetailGoodsMesCell : UITableViewCell

- (void)updateCellMesWithGoodsImge:(NSString *)goodsimage
                        GoodsName:(NSString *)goodsname
                       GoodsGuige:(NSString *)guige
                       GoodsPrice:(NSString *)goodsprice
                       GoodsCount:(NSString *)count
                        TuikanStatus:(NSString *)tuikuanstatus;

@end


