//
//  ConsigneeMesModel.h
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  AddressListModel;

@interface ConsigneeMesModel : NSObject  // 收货地址model

@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSArray * result; 

@property (nonatomic,copy) NSString * consignee;// 联系人
@property (nonatomic,copy) NSString *mobile; // 手机号码
@property (nonatomic,assign) NSInteger provinceID; // 省id
@property (nonatomic,assign) NSInteger cityID; // 城市id
@property (nonatomic,assign) NSInteger districtID; // 地区id
@property (nonatomic,copy) NSString *provinceName;
@property (nonatomic,copy) NSString *addressiInfo;
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *districtName;
@property (nonatomic,copy) NSString *address; // 详细地址
@property (nonatomic,assign,getter=isSetCommon) BOOL isDefault; // 是否是常用地址
@property (nonatomic,assign,getter=isChanged) BOOL changed; // 是否修改过
@property (nonatomic,copy) NSString *errorMes; // 错误信息

- (BOOL)checkAddressMes;

@end

@interface AddressListModel : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, assign) NSInteger addressId;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * consignee;
@property (nonatomic, assign) NSInteger country;
@property (nonatomic, assign) NSInteger district;
@property (nonatomic, assign) NSInteger isDefault;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, strong) NSString * provinceName;
@property (nonatomic,strong) NSString *districtName;
@property (nonatomic, assign) NSInteger status;

@end
