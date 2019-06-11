//
//  CancelReasonModel.m
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "CancelReasonModel.h"

@implementation CancelReasonModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"result":@"CancelReasonListModel"};
}

@end


@implementation CancelReasonListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
     return @{@"idField": @"id"};
}

@end
