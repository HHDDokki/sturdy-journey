//
//  CancelReasonModel.h
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseModel.h"

@class CancelReasonListModel;

@interface CancelReasonModel : BaseModel
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSArray * result;

@end

@interface CancelReasonListModel : BaseModel

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * value;
@property (nonatomic,assign) BOOL isSelectedStatus; // 选中状态

@end

