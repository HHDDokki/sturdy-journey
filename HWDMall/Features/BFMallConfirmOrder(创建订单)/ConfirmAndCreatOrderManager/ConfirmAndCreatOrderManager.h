//
//  ConfirmAndCreatOrderManager.h
//  HWDMall
//
//  Created by stewedr on 2018/11/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ConfirmAndCreatOrderModel;
@class ConfirmAndCreatorderResultModel;

@interface ConfirmAndCreatOrderManager : NSObject

- (NSArray *)setConfirmOrderUIModel:(ConfirmAndCreatorderResultModel *)model;

@end

