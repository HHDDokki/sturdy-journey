//
//  OrderCellFooterForTimedown.h
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderlistResultModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^BottomBtnBlock)(void);
typedef void(^OrdercellTimedownBlock)(OrderlistResultModel *model);

@interface OrderCellFooterForTimedown : UITableViewHeaderFooterView
@property (nonatomic,copy) BottomBtnBlock bottomBlock;
@property (nonatomic,strong) OrderlistResultModel *timedownmodel;
@property (nonatomic,copy) OrdercellTimedownBlock timedownBlock;


- (void)updateCellmesWithTime:(NSInteger)timedown
                 AccountMoney:(NSString *)money
                BottomBtnName:(NSString *)btnTitle;

@end

NS_ASSUME_NONNULL_END
