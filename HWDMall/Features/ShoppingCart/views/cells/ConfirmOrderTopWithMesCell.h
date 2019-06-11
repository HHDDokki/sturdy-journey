//
//  ConfirmOrderTopWithMesCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 确认订单有信息topCell
@interface ConfirmOrderTopWithMesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *arrowImage;

- (void)updateCellMesWithName:(NSString *)name
                        Phone:(NSString *)phone
                      Address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
