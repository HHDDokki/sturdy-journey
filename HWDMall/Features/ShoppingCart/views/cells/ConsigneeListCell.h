//
//  ConsigneeListCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AddressListModel;

typedef void(^EditAddressBlock)(AddressListModel * model);

@interface ConsigneeListCell : UITableViewCell
@property (nonatomic,copy) EditAddressBlock editBlock;
@property (nonatomic,copy) EditAddressBlock deleteBlock;

- (void)setContentWithConsigneeMesModel:(AddressListModel *)model;
@end

NS_ASSUME_NONNULL_END
