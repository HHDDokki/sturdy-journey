//
//  BFMallConfirmOrderTopCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddAddressBlock)(void);

@interface BFMallConfirmOrderTopCell : UITableViewCell

@property (nonatomic,copy) AddAddressBlock addAddressBlock;

@end

NS_ASSUME_NONNULL_END
