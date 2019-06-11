//
//  ConsigneeMesModel.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConsigneeMesModel.h"

@implementation ConsigneeMesModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"result":@"AddressListModel"
             };
}

- (BOOL)checkAddressMes{
    BOOL isSuccess = YES;
    if ([self.consignee deleteBlank].length ==0) {
        self.errorMes = @"请填写联系人";
        isSuccess = NO;
        return isSuccess;
    }
    
    if (![self.mobile deleteBlank].length){
        self.errorMes = @"请填写手机号";
        isSuccess = NO;
        return isSuccess;
    }
    
    if (![[self.mobile deleteBlank] isPhoneNum]){
        self.errorMes = @"请输入正确的手机号";
        isSuccess = NO;
        return isSuccess;
    }
    
    if ([self.provinceName deleteBlank].length == 0 || [self.cityName deleteBlank].length == 0 || [self.districtName deleteBlank].length == 0 ) {
        self.errorMes = @"请选择地区";
        isSuccess = NO;
        return isSuccess;
    }
    
    if ([self.address deleteBlank].length == 0) {
        self.errorMes = @"请输入详细地址";
        isSuccess = NO;
        return isSuccess;
    }
    
    return isSuccess;
}

@end

@implementation AddressListModel



@end
