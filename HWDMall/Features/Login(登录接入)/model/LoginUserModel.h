//
//  LoginUserModel.h
//  HWDMall
//
//  Created by 肖旋 on 2018/12/17.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUserModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *isBind;
@property (nonatomic, copy) NSString *isVip;
@property (nonatomic, copy) NSString *is_vip;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *outUserCode;
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *headPic;
@property (nonatomic, assign) NSInteger couponDesc;
@property (nonatomic, assign) NSInteger isFirst;

@end
