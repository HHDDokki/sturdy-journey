//
//  OrderBottomThreeBtnView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(void);
@interface OrderBottomThreeBtnView : UIView
@property (nonatomic,copy) ButtonBlock leftBtnBlock;
@property (nonatomic,copy) ButtonBlock midBtnBlock;
@property (nonatomic,copy) ButtonBlock rightBtnBlock;
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

- (void)updataMesWithLeftTitle:(NSString *)lefttitle
                      MidTitle:(NSString *)midtitle
                    RightTitle:(NSString *)righttitle;
@end

