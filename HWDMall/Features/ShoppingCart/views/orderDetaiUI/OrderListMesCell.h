//
//  OrderListMesCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListMesCell : UITableViewCell // 订单商品信息

- (void)updateCellMessWithTitle:(NSString *)title
                        Content:(NSString *)content
                   ButtonHidden:(BOOL)buttonhidden;

@end

NS_ASSUME_NONNULL_END
