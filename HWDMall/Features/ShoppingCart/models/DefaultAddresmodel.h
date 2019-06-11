//
//  DefaultAddresmodel.h
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseModel.h"

@class DefaultAddressListModel;

@interface DefaultAddresmodel : BaseModel

@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) DefaultAddressListModel * result;

@end

@interface DefaultAddressListModel : BaseModel
@property (nonatomic, strong) NSString * address;
@property (nonatomic, assign) NSInteger addressId;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * consignee;
@property (nonatomic, assign) NSInteger district;
@property (nonatomic, strong) NSString * districtName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) NSInteger isDefault;
@property (nonatomic, strong) NSString * mobile;
@end
