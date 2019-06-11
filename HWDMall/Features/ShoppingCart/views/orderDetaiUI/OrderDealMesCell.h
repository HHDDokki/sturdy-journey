//
//  OrderDealMesCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDealMesCell : UITableViewCell

- (void)updateCellMesWithCellTitle:(NSString *)celltitle
                       CellContent:(NSString *)content
                       ContenColor:(UIColor *)contentColor;

@end

