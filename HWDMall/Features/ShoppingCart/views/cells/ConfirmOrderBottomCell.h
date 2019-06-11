//
//  ConfirmOrderBottomCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLSwitch.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^changeSwitchBlock)(BOOL isOn);
typedef void(^RechargeBlock)(void);

@interface ConfirmOrderBottomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet KLSwitch *useCoinSwitch;
@property (nonatomic,copy) changeSwitchBlock switchBlock;
@property (nonatomic,copy) RechargeBlock  rechargeBlock;


- (void)updateCellMesWithCellTitle:(NSString *)celltitle
                        UseContent:(NSString *)usecontent;

@end

NS_ASSUME_NONNULL_END
