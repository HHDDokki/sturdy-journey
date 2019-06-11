//
//  BFMallGoodsDetailController.h
//  BFMan
//
//  Created by HandC1 on 2019/5/22.
//  Copyright © 2019 HYK. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "BFMallBaseViewController2.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMallGoodsDetailController : BFMallBaseViewController2

//主view
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) NSString *userHeadImg;
@property (nonatomic, assign) NSInteger goodsId;

@end

NS_ASSUME_NONNULL_END
