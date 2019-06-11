//
//  CancelReasonView.h
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelViewBlock)(NSString *reasonStr);

@interface CancelReasonView : UIView
@property (nonatomic,copy) CancelViewBlock cancelBlock;

@end

