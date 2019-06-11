//
//  OrderdetailCellModel.h
//  HWDMall
//
//  Created by stewedr on 2018/11/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OrderdetailCellModel : NSObject
@property (nonatomic,assign) OrderDetailCellType cellType; // 加载哪种cell
@property (nonatomic,assign) CGFloat cellHeight; // cell高度
@property (nonatomic,assign) NSInteger goodsid; // 商品id
@property (nonatomic,copy) NSString * celltitle; // title
@property (nonatomic,copy) NSString * subTitle;
@property (nonatomic,copy) NSString * content; // 内容
@property (nonatomic,copy) NSString * imageName; // 图片
@property (nonatomic,assign) NSInteger timeDown;// 倒计时
@property (nonatomic,copy) NSString * name; // 姓名
@property (nonatomic,copy) NSString * phone; // 电话
@property (nonatomic,copy) NSString * address; // 地址
@property (nonatomic,copy) NSString * goodsImage; // 商品图片
@property (nonatomic,copy) NSString * goodsName; // 商品名字
@property (nonatomic,copy) NSString * goodsGuige; // 商品规格
@property (nonatomic,copy) NSString * goodsPrice; // 商品价格
@property (nonatomic,copy) NSString * goodsCount; // 商品数量
@property (nonatomic,copy) NSString * groupStatus; // 拼团状态
@property (nonatomic,copy) NSString * groupPerson; // 还缺几个人
@property (nonatomic,copy) NSString * vipPrice; //会员价格
@property (nonatomic,strong) NSArray * groupImageArr; // 头像
@property (nonatomic,assign) BOOL isTuikuan; // 是否退款
@property (nonatomic,copy) NSString * wuliumes; // 物流信息
@property (nonatomic,copy) NSString * wuliuTime; // 物流时间
@property (nonatomic,assign) BOOL isMoreBag; // 是否多个包裹
@property (nonatomic,copy) NSString *shopName; // 店铺名字
@property (nonatomic,assign) NSInteger shopid;
@property (nonatomic,copy) NSString *orderStatus; // 店铺状态
@property (nonatomic,copy) NSString *tuikuanStatus;
@property (nonatomic,assign) BOOL buttonHidden;
@property (nonatomic,strong) NSMutableArray * cellmodelMuarr; //存商品model
@end


