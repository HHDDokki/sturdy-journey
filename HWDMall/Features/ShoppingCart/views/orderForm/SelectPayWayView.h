//
//  SelectPayWayView.h
//  HWDMall
//
//  Created by stewedr on 2018/12/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectpaywayViewBlock)(Payway payway);

@interface SelectPayWayView : UIView
@property (nonatomic,copy) SelectpaywayViewBlock payBlock;

- (void)bindPrice:(CGFloat)price;

@end

