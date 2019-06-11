//
//  Config.h
//  HWDMall
//
//  Created by stewedr on 2018/10/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#ifndef Config_h
#define Config_h
#import "GVUserDefaults.h"
#import "GVUserDefaults+UserConfig.h" // 用户信息：登录、VIP
#import "TimedownModel.h"


typedef enum : NSUInteger {
    Accounttype_Visitor = 0, // 游客
    Accounttype_Common, // 普通用户
    Accounttype_Member // 会员
} AccountType;

typedef enum : NSUInteger {
    BFMALL_MAIN = 0, // 首页
    BFMALL_LIST, // 列表
    BFMALL_COMMON, // 通用
    BAMALL_NORMAL // normal
} PAGETYPE;

typedef enum : NSUInteger {
    OrderDetailCellType_Top, // 顶部
    OrderDetailCellType_Time,// 订单时间
    OrderDetailCellType_Total,// 订单优惠
    OrderDetailCellType_topWaitpay, // 等待付款
    OrderDetailCellType_topTwoMes, // 两行信息
    OrderDetailCellType_topPindanTimedown, // 拼单倒计时
    OrderDetailCellType_topOneMes, // 一条信息
    OrderDetailCellType_Address, // 地址
    OrderDetailCellType_Pinduan,// 拼团信息
    OrderDetailCellType_GoodsMes,// 商品信息
    OrderDetailCellType_OrderTime,// 订单号、支付方式、下单时间、拼单时间
    OrderDetailCellType_OrderTotal,// 商品总额、优惠信息(金豆、优惠券)
    OrderDetailCellType_Wuliu, // 物流
    OrderDetailCellType_ActualPay // 实际支付
} OrderDetailCellType; // 订单详情页面 cell页面

typedef enum : NSUInteger {
    ConfirmOrderCellType_Top= 1, // 地址和支付(组)
    ConfirmOrderCellType_Goods, // 商品信息（组）
    ConfirmOrderCellType_Youhui,// 优惠信息（组）
    ConfirmOrderCellType_OrderMes,// 订单：优惠券、金豆、运费（组）
    ConfirmOrderCellType_TopNoMes, // 顶部没有信息(地址)
    ConfirmOrderCellType_TopWithMes, // 顶部有信息(地址)
    ConfirmOrderCellType_GoodsMes, // 商品信息
    ConfirmOrderCellType_Payway, // 支付方式
    ConfirmOrderCellType_YouhuiWithMes,
    ConfirmOrderCellType_YouhuiNoMes,
    ConfirmOrderCellType_YouhuiJindou, // 金豆
    ConfirmOrderCellType_OrderdetailMes,// 订单信息
    ConfirmOrderCellType_VipChoiceMes, //vip信息
    ConfirmOrderCellType_NoPeisong, // 不能配送物流
    ConfirmOrderCellType_Bottom // 底部条
} ConfirmOrderCellType; // 确认订单列表类型

typedef enum : NSUInteger {
    OrderCellType_WaitPay = 1, // 待支付
     OrderCellType_Closed, // 交易关闭
    OrderCellType_WaitSend, // 待发货
    OrderCellType_WaitReceive, // 待收货
    OrderCellType_Finished = 6,// 已完成
    OrderCellType_WaitShare,// 待分享
} OrderCellType; // 订单cell类型

typedef enum : NSUInteger {
    OrderStatus_WaitPay = 1, // 待支付
    OrderStatus_Closed, // 交易关闭
    OrderStatus_WaitSend, // 待发货
    OrderStatus_WaitReceive, // 待收货
    OrderStatus_Finished = 6, // 交易成功
    OrderStatus_WaitShar , // 待分享
    OrderStatus_Cancel // 交易取消
} OrderStatus; //订单状态

typedef enum : NSUInteger {
    OrderType_Mall = 1, // 商城
    OrderType_Kanjia, // 砍价
    OrderType_Pintuan // 拼团
} OrderType; // 订单类型

typedef enum : NSUInteger {// 支付方式
    Payway_Wxpay = 1, // 微信
    Payway_Alipay // 支付宝
}Payway;

typedef enum : NSUInteger {
    groupStatus_ing = 1, // 正在拼团
    groupStatus_finish, // 拼团成功
    groupStatus_fail, // 拼团失败
} GroupStatus; // 拼团状态

typedef enum : NSUInteger {
    GoodsStatus_tuikuaning = 1, // 退款中
    GoodsStatus_tuikuanFinished // 退款成功
} GoodsStatus; // 商品状态

typedef enum : NSUInteger {
    ShopingCartGoodsStatus_shangjia = 3, // 上架
    ShopingCartGoodsStatus_xiajia, // 下架 == 无效
    ShopingCartGoodsStatus_shouqing, // 售罄 == 无效
    ShopingCartGoodsStatus_wuhuo // 无货 == 有效
} ShopingCartGoodsStatus;

typedef enum : NSUInteger {
    BuyType_Noshopcart = 0, // 非购物车
    BuyType_shopcart, // 购物车
} BuyType; // 购买类型

typedef enum : NSUInteger {
    AD_GOODSDETAIL = 1, //1.商品详情页
    AD_ACTIVIEW = 2, //2.活动页[暂时弃用]
    AD_SHOP = 3, //3.店铺
    AD_COLLAGE = 4, //4.拼团
    AD_BARGAIN = 5, //5.砍价
    AD_CLASSIFY = 6, //6.分类
    AD_ENTERURL = 7, //7.输入链接
    AD_NONE, //8.无跳转
    AD_MINE, //9.'我的'
    AD_VIP_BUY //10.会员购买页面
} AdType; // 跳转类型


/**
 * 分享的类型
 */
typedef enum{
    SHARE_WECHAT = 0,
    SHARE_COPYLINK
}SHARE_SNS_TYPE;

/**
 * 分享长图的类型
 */
typedef enum{
    LONGIMAGE_WECHAT = 0,
    LONGIMAGE_TIMELINE,
    LONGIMAGE_SAVE
}SHARE_LONGIMAGE_TYPE;

typedef void(^TimeDownBlock)(TimedownModel *model); // 倒计时block

// 微信登录
static NSString * const WXAuthSuccess = @"WXAuthSuccess";
static NSString * const WXSaveUserInfo = @"WXUserInfo";
static NSString * const WXSaveToken = @"WXToken";
static NSString * const WXSaveAccess_token = @"WXAccessToken";
static NSString * const WXSaveRefreshToken = @"WXRefreshToken";

// 微信分享成功
static NSString * const WXShareSuccess = @"WXShareSuccess";


typedef void(^HeightChangeBlock)(void);

#define PostCenterName @"getshopcarcountPostName"  // 刷新购物车个数
#define ResetOrderListPostName @"resetorderlistdata" // 刷新订单列表

/*
 @property (nonatomic,copy) NSString *name;// 联系人
 @property (nonatomic,copy) NSString *phoneNum; // 手机号码
 @property (nonatomic,copy) NSString *address;// 地区
 @property (nonatomic,copy) NSString *detailAddress; // 详细地址
 */
#define key_Name @"consignee"
#define key_PhoneNum @"mobile"
#define key_Address @"addressiInfo" // "country":21, //国家ID 必填"province":121, //省份ID 必填"city":1212, //城市ID 必填"district":121212, //地区ID 必填“provinceName”:“北京市”  ，//省份名称 必填"cityName":"北京市"，//城市名称  必填"districtName":"朝阳区", //地区名称 必填
#define key_DetailAddress @"address"
#define key_IsDault @"isDefault" // 是否是默认收货地址

//网络状态监控地址
static NSString* const kURL_Reachability__Address=@"www.baidu.com";


//常用色 --sk --1018
#define kLightGreyColor @"F6F6F6" //底色灰
#define kBlackColor @"333333" //按钮黑色文字
#define kSelectedBtnOrangeColor @"ED5E3B" //按钮选中文字颜色
#define kMainRedColor UIColorFromHex(0xED4D4D) // 主要颜色 偏红色
#define kMainYellowColor UIColorFromHex(0xEE8B0B) // 主要颜色 偏黄色

#define WK(weakSelf)  __weak __typeof(&*self)weakSelf = self;


//程序启动次数记录
#define KEY_APP_LAUNCH_COUNT      @"app_launch_count"

#endif /* Config_h */
