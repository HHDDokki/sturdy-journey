//
//  GoodOneMesFooter.h
//  HWDMall
//
//  Created by stewedr on 2018/12/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodOneMesFooter : UITableViewHeaderFooterView

- (void)updateMesWithGoodsCount:(NSString *)goodscount
                     GoodsPrice:(NSString *)goodprice;

@end

