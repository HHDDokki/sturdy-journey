//
//  ALYearWeekPickerView.h
//  Alliance
//
//  Created by cxlf_ljd on 2018/8/15.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import "BRBaseView.h"
#import "ALTwoDModel.h"

typedef void(^ALTwoDResultBlock)(ALYearModel *year, ALWeekModel *week);
typedef void(^ALTwoDCancelBlock)(void);

@interface ALYearWeekPickerView : BRBaseView

+ (void)showAddressPickerWithTitle:(NSString *)title
                           dataSource:(NSArray *)dataSource
                      defaultSelected:(NSArray *)defaultSelectedArr
                         isAutoSelect:(BOOL)isAutoSelect
                           themeColor:(UIColor *)themeColor
                          resultBlock:(ALTwoDResultBlock)resultBlock
                          cancelBlock:(ALTwoDCancelBlock)cancelBlock;

@end
