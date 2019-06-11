//
//  BFMallOrderShopListCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/6/1.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapBlock)(void);

@interface BFMallOrderShopListCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *muArr;
@property (nonatomic, strong) UITableView *mesTable;
@property (nonatomic,copy) TapBlock tapblock;

@end

NS_ASSUME_NONNULL_END
