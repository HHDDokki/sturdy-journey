//
//  ShoppingcartUnusebleHeader.h
//  HWDMall
//
//  Created by stewedr on 2018/11/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteAllBlock)(void);
@interface ShoppingcartUnusebleHeader : UITableViewHeaderFooterView
@property (nonatomic,copy) DeleteAllBlock deleteBlock;

@end


