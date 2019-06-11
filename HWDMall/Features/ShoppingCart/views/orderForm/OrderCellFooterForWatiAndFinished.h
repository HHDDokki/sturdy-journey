//
//  OrderCellFooterForWatiAndFinished.h
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BottomBtnActionBlock)(void);

@interface OrderCellFooterForWatiAndFinished : UITableViewHeaderFooterView
@property (nonatomic,copy) NSString *leftBtnTitle; // 左边buttontitle
@property (nonatomic,copy) NSString *rightBtnTitle; // 右边buttontitle
@property (nonatomic,copy) BottomBtnActionBlock leftBlock;
@property (nonatomic,copy) BottomBtnActionBlock rightBlock;


- (void)updateFooterWithLeftName:(NSString *)leftname
                       RightName:(NSString *)rightname
                           Count:(NSInteger)goodcount
                           Price:(CGFloat)price;

@end

NS_ASSUME_NONNULL_END
