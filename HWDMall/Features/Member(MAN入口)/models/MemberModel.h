//
//  MemberModel.h
//  HWDMall
//
//  Created by HandC1 on 2018/11/1.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PriceModel
@end

@interface MemberModel : JSONModel

//@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy)NSString *headImg;
@property (nonatomic, assign) VipType isVip;//是否是会员（1是，0不是）
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *renewVip;//预留字段
@property (nonatomic, assign)float saveMoney;//节省金额
@property (nonatomic, assign)NSInteger time;//会员有效期时间（秒）
@property (nonatomic, assign) int userType;//用户类型（0绑定用户，1微信用户，2手机用户）
@property (nonatomic, strong)NSMutableArray *dtoList;//里层模型
@property (nonatomic, assign) NSInteger endTime;
@property (nonatomic, strong) NSMutableArray<PriceModel>*priceList;

@end

@interface PriceModel : JSONModel

@property (nonatomic, assign) CGFloat vipPrice;

@end

@interface SaveMemberModel : NSObject
@property (nonatomic, assign) int condition;
@property (nonatomic, assign) int effectType;
@property (nonatomic, assign) int ID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign) int money;
@property (nonatomic, assign) int status;
@property (nonatomic, assign) int type;
@property (nonatomic, copy)NSString *useScope;
@end

NS_ASSUME_NONNULL_END
