//
//  OrderBottomTwoBtnView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnActionBlock)(void);

@interface OrderBottomTwoBtnView : UIView

@property (nonatomic,copy) BtnActionBlock leftBlock;
@property (nonatomic,copy) BtnActionBlock rightBlock;

- (void)updateViewMesWithLeftBtnTitle:(NSString *)leftTitle
                           RightTitle:(NSString *)rightTitle;

@end

