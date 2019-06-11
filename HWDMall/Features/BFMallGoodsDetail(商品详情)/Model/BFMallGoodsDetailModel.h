//
//  BFMallGoodsDetailModel.h
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "JSONModel.h"

@protocol BFMallBargainGoodsDetailModel
@end

@protocol BFMallBargainWinnerListModel
@end

@protocol BFMallDetailBaseInfoModel
@end

@protocol BFMallDetailShopDetailModel
@end

@protocol BFMallDetailCouponListModel
@end

@protocol BFMallDetailCouponModel
@end

@protocol BFMallDetailRecommendDetailModel
@end

//拼团列表
@protocol BFMallDetailRecommendMainModel
@end

@protocol BFMallDetailRecommendListModel
@end

@protocol BFMallDetaiServiceListModel
@end

/*-------------砍价轮播 -----------------------*/

@interface BFMallBargainGoodsDetailModel : JSONModel

@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *beforeTime;
@property (nonatomic, strong) NSString *cutPrice;
@property (nonatomic, strong) NSString *cut_id;


@end

@interface BFMallBargainWinnerListModel : JSONModel

@property (nonatomic, assign) CGFloat buyPrice;
@property (nonatomic, strong) NSMutableArray <BFMallBargainGoodsDetailModel>*users;


@end


/*-----------服务？-----------------------------------------------------------------*/
@interface BFMallDetaiServiceListModel : JSONModel

@property (nonatomic, strong) NSString *ser_description;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat nameHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@end

/*-----------基础信息-----------------------------------------------------------------*/

@interface BFMallDetailBaseInfoModel : JSONModel

//最高价
@property(assign,nonatomic)double maxPrice;
//最低价
@property(assign,nonatomic)double minPrice;
//单购价
@property(assign,nonatomic)double singlePrice;
//促销价
@property(assign,nonatomic)double promPrice;
//团购价
@property(assign,nonatomic)double teamPrice;
//是否售罄  1是 0否
@property(assign,nonatomic)int isStock;
//几人团
@property(assign,nonatomic)int teamScope;
//成团次数
@property(assign,nonatomic)int teamCount;
//砍价（砍成次数）
@property (assign, nonatomic) int cutCount;

@property(assign,nonatomic) int activeId;//活动id 可能没有该key，接口说加不了zxd

@property (nonatomic, strong) NSString *originalImg;

//商品名
@property(copy,nonatomic)NSString *goodsName;

@end

/*-----------店铺相关-----------------------------------------------------------------*/

@interface BFMallDetailShopDetailModel : JSONModel

//店铺描述
@property (nonatomic, strong) NSString *shop_description;
//店铺id
@property (nonatomic, strong) NSString *shopId;
//店铺logo
@property (nonatomic, strong) NSString *shopLogo;
//店铺名称
@property (nonatomic, strong) NSString *shopName;

@end


/*------------小信息----------------------------------------------------------------*/

@interface BFMallGoodsDetailModel : JSONModel

@property(copy,nonatomic)NSString *goodsName;

//店铺相关信息
@property (copy,nonatomic) BFMallDetailShopDetailModel *shop;
////商品轮播图
@property (copy,nonatomic) NSArray *imgUrls;
//服务内容
@property (copy,nonatomic) NSMutableArray <BFMallDetaiServiceListModel> *serviceList;
//商品详情
@property (copy,nonatomic) NSArray *imgDetail;
//商品状态 1.下线 2.已冻结 3.已关店 4.已上线 只要不是4 都显示已下架
@property (nonatomic, assign) int status;

@property (assign,nonatomic) NSInteger collectionState;
@property (strong,nonatomic) NSString *goodsId;
@property (assign,nonatomic) NSString *goodsType;
//促销
@property (assign) BOOL isOnSale;
//售罄
@property (assign) BOOL isStock;
@property (assign) BOOL isVip;
//最高价
@property(assign,nonatomic)double maxPrice;
//最低价
@property(assign,nonatomic)double minPrice;
//单购价
@property(assign,nonatomic)double singlePrice;
//促销价
@property(assign,nonatomic)double promPrice;
//团购价
@property(assign,nonatomic)double teamPrice;
//差价
@property(assign,nonatomic)double differencePrice;

@property (nonatomic, strong) NSString *originalImg;

@end

/*----------优惠券------------------------------------------------------------------*/

@interface BFMallDetailCouponModel : JSONModel

@property(assign,nonatomic)int couponId;
//0:平台优惠券 1:店铺优惠券
@property(assign,nonatomic)int type;
//优惠券金额
@property(assign,nonatomic)CGFloat money;
//使用条件（满x元可用）
@property(assign,nonatomic)CGFloat condition;
//生效方式(1:时间段内有效 2:领用后生效)
@property(assign,nonatomic)int effectType;
//领用后x天有效
@property(assign,nonatomic)int dayMonth;
//有效期开始时间
@property(assign,nonatomic)int startTime;
//有效期结束时间
@property(assign,nonatomic)int endTime;
//可领 0 不可领
@property(assign,nonatomic)int status;

@property (assign, nonatomic) int limitNum;

//优惠券名字
@property(copy,nonatomic)NSString *name;
//优惠券使用范围
@property (nonatomic,copy) NSString *useScope;


@end


@interface BFMallDetailCouponListModel : JSONModel

@property (nonatomic, strong) NSMutableArray<BFMallDetailCouponModel> *result;

@end



/*---------拼团-------------------------------------------------------------*/
@interface BFMallDetailRecommendDetailModel : JSONModel

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *usrId;
@property (assign) BOOL isLeader;


@end



@interface BFMallDetailRecommendListModel : JSONModel
//"foundId":1,//团编号
//"foundStatus": 1,//1正常;2拼团已满5拼团已结束还是超时？？
//"remainQuantity": 1,//剩余名额
//"endTime":  1111,//XXX后结束，结束时间，秒
//"join": 1,//已参团人数
//"need": 2,//需多少人成团
//"goodsId": 11,//商品id
//"status": 1,//拼团状态0: 待开团(表示已下单但是未支付)1: 已经开团(团长已支付)2: 拼团成功,3拼团失败
//"foundTime": 11111,//开团时间，秒
//“foundEndTime”:222 ,//成团时间，秒
//"userType":1,//用户范围(1全员2会员3非会员4注册未下单)
//"userList": [{
//    "id": 102, //用户id
//    "isLeader": 1,// 是否团长
//    "heapPic": "XXX",//会员头像
//    "nickname":"A",//会员昵称

//团编号
@property(assign,nonatomic)NSInteger foundId;
//1正常;2拼团已满5拼团已结束还是超时？？
@property(assign,nonatomic)int foundStatus;
//剩余名额
@property(assign,nonatomic)int remainQuantity;
//XXX后结束，结束时间，秒
@property(assign,nonatomic)NSInteger endTime;
@property(assign,nonatomic)int join;
@property(assign,nonatomic)int need;
@property(assign,nonatomic)int status;
@property(assign,nonatomic)int goodsId;
@property(assign,nonatomic)int foundTime;
@property(assign,nonatomic)int foundEndTime;
@property(assign,nonatomic)int userType;
@property (nonatomic, assign) NSInteger teamEndTime;
@property(copy,nonatomic)NSMutableArray<BFMallDetailRecommendDetailModel> *userList;

@end

@interface BFMallDetailRecommendMainModel : JSONModel

@property (nonatomic, strong) NSMutableArray<BFMallDetailRecommendListModel> *result;

@end

