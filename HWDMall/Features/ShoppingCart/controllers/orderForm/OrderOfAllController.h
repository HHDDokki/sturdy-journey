//
//  OrderOfAllController.h
//  HWDMall
//
//  Created by stewedr on 2018/10/26.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BasePayViewController.h"

typedef void(^PushDetailBlock)(NSInteger parentid,NSInteger sonorderid);

@interface OrderOfAllController : BasePayViewController // 订单-全部

@property (nonatomic,assign) NSInteger orderStatus;
@property (nonatomic,copy) PushDetailBlock pushBlock;
@property (nonatomic,weak) BaseViewController *basecontroller;

@end

