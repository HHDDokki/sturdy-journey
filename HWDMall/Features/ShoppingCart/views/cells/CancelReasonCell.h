//
//  CancelReasonCell.h
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReasonBtnBlock)(void);

@interface CancelReasonCell : UITableViewCell

@property (nonatomic,copy) ReasonBtnBlock btnBlock;


- (void)updateCellMesWithTitle:(NSString *)titleMes
                SelectedStatus:(BOOL)status;

@end

