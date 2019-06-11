//
//  OrderMoreGoodsCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapBlock)(void);

@interface OrderMoreGoodsCell : UITableViewCell
@property (nonatomic,assign) NSInteger cellCount;
@property (nonatomic,strong) NSArray *picArr; // 图片
@property (nonatomic,copy) TapBlock tapblock;

@end

NS_ASSUME_NONNULL_END
