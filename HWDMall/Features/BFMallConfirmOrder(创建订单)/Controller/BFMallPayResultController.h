//
//  BFMallPayResultController.h
//  HWDMall
//
//  Created by HandC1 on 2019/6/9.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMallPayResultController : BaseViewController

@property (nonatomic,copy) NSString *parentOrderSign;
@property (nonatomic,copy) NSString *sonOrderSign;
@property (nonatomic,assign) BOOL isUnpack; // 是否拆单


- (void)updateMesWith:(BOOL)state;

@end

NS_ASSUME_NONNULL_END
