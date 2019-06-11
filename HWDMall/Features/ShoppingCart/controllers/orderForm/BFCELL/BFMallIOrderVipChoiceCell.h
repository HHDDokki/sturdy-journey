//
//  BFMallIOrderVipChoiceCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/6/3.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^VipChoiceBlock)(BOOL btnState);

@interface BFMallIOrderVipChoiceCell : UITableViewCell

@property (nonatomic, strong) UIButton *choiceBtn;
@property (nonatomic,copy) VipChoiceBlock vipChoiceBlock;

- (void)changeState:(NSInteger)state;
- (void)updateVipPrice:(CGFloat)VipPrice TotalSavedPrice:(CGFloat)savePrice;
- (void)updateSavedPrice:(CGFloat)savePrice;

@end

NS_ASSUME_NONNULL_END
