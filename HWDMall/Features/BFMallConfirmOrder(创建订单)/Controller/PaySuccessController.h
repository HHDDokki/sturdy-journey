//
//  PaySuccessController.h
//  HWDMall
//
//  Created by stewedr on 2018/12/4.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaySuccessController : BaseViewController

@property (nonatomic,copy) NSString *parentOrderSign;
@property (nonatomic,copy) NSString *sonOrderSign;
@property (nonatomic,assign) BOOL isUnpack; // 是否拆单


- (void)updateMesWith:(NSString *)paywayStr
             PayPrice:(NSString *)payPriceStr;
@end

NS_ASSUME_NONNULL_END
