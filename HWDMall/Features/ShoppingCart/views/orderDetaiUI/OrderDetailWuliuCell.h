//
//  OrderDetailWuliuCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailWuliuCell : UITableViewCell

- (void)updateCellMesWith:(NSString *)mes
                     Time:(NSString *)time
             ButtonHidden:(BOOL)btnHidden;

@end

