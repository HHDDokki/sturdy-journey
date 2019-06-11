//
//  BFMallOrderListFooterView.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/31.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LeftBtnBlock)(void);
typedef void(^RightBtnBlcok)(void);

@interface BFMallOrderListFooterView : UITableViewHeaderFooterView

@property (nonatomic,copy) LeftBtnBlock leftBtnBlock;
@property (nonatomic,copy) RightBtnBlcok rightBtnBlock;


- (void)updateFooter;

- (void)updateFooterWithRightName:(NSString *)rightname;

- (void)updateFooterWithLeftName:(NSString *)leftname
                       RightName:(NSString *)rightname;

- (void)updateFooterWithLeftName:(NSString *)leftname
                       RightName:(NSString *)rightname
                           Price:(CGFloat)price;

- (void)updateFooterWithRightName:(NSString *)rightname
                           Price:(CGFloat)price;

- (void)updateFooterWithRightPrice:(CGFloat)price;

@end

NS_ASSUME_NONNULL_END
