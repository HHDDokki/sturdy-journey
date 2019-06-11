//
//  OrderCellHeaderView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapBlock)(void);

@interface OrderCellHeaderView : UITableViewHeaderFooterView

@property (nonatomic,assign) BOOL isTop;

@property (nonatomic,copy) TapBlock tapBlock;

- (void)updateHeaderWithMoreShops:(BOOL)haveShops
                         ShopName:(NSString *)shopName
                   AndOrderStatus:(NSString *)shopStatus;

@end

