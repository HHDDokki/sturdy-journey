//
//  ConfirmOrderGoodsCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderGoodsCell : UITableViewCell

- (void)updateCellMesWithHeadUrl:(NSString *)goodshead
                       GoodsName:(NSString *)goodsname
                      GoodsGuige:(NSString *)goodsguige
                      GoodsPrice:(NSString *)goodsprice
                        GoodsNum:(NSString *)goodsnum;

@end

NS_ASSUME_NONNULL_END
