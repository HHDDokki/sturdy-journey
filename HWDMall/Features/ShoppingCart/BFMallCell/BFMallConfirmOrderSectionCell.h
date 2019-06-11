//
//  BFMallConfirmOrderSectionCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMallConfirmOrderSectionCell : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *bfmallIcon;
@property (nonatomic, strong) UILabel *descLabel;

- (void)bindDetailModel;
- (void)updateHeaderWithMoreShops:(BOOL)haveShops
                         ShopName:(NSString *)shopName
                   AndOrderStatus:(NSString *)shopStatus;
@end

NS_ASSUME_NONNULL_END
