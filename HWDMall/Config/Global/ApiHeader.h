//
//  ApiHeader.h
//  HWDMall
//
//  Created by stewedr on 2018/10/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#ifndef ApiHeader_h
#define ApiHeader_h

#define  PRODUCT 1

#if PRODUCT
#define kApiPrefix @"http://47.93.216.16:7081" // 开发小弟本地调试
#define kApiStaticPrefix @"https://static.pinshizai.com" // 静态资源测试环境

#else
#define kApiPrefix @"https://api.haohuoduo.com"  // 测试大佬用 // com 是正式
#define kApiStaticPrefix @"https://static.haohuoduo.com" // 静态资源 正式环境

#endif

/* 用户接口 */
#define kApi_appLogin @"/wx/appLogin.json" //微信APP登录
#define kApi_wxBindGetCode @"/user/wxBindGetCode.json" // 获取绑定手机验证码
#define kApi_mobileGetCode @"/login/mobileGetCode.json" // 获取登录验证码
#define kApi_mobileLogin @"/login/mobileLogin.json" // 验证码登录
#define kApi_wxMobileBind @"/user/wxMobileBind.json" // 手机账号绑定微信
#define kApi_logout @"/logout.json" // 退出登录

#define kApi_distributionScope @"/region/distributionScope.json" // 该地区是否有货
#define kApi_getUserHeadPic @"/teamFound/getUser.json" // 获取用户头像

/* --------------------- 购物车 ------------------ */
 
#define kApi_findCartList   @"/cart/findCartList.json" // 购物车列表
#define kApi_getTotalAndCheckCart @"/cart/getTotalAndCheckCart.json" // 获取合计金额 和 最新购物车信息
#define kApi_deleteCartGoods  @"/cart/deleteCartGoods.json"  // 删除购物车或者失效商品
#define kApi_updateGoodsNum @"/cart/updateGoodsNum.json" // 改变购物车数量
#define kApi_addGoodsToCart @"/cart/addGoodsToCart.json" // 添加购物车 负责人:lwz
#define kApi_findCartCount @"/cart/findCartCount.json" // 查询购物车商品数量 负责人:zxd

/* --------------------------- 订单 ------------------------ */

#define kApi_findOrderList @"/order/findOrderList.json" // 订单列表
#define kApi_findOrderDetail @"/order/findOrderDetail.json" // 订单详情
#define kApi_createOrder  @"/order/create.json" // 创建订单
#define kApi_cancelOrder @"/order/cancelOrder.json" // 取消订单
#define kApi_listCancelOrderReason @"/config/listCancelOrderReason.json" //取消订单原因
#define kApi_orderDetailMes @"/order/build.json" // 获取结算页面信息
#define kApi_confirmOrder @"/order/confirmOrder.json"  // 确认收货

/* -------------------------- 商品详情 ----------------------- */

#define API_QRCODE               @"/wxCode/createWeChatQrCode.json"
#define kApi_findAllInfoById @"/goods/findAllInfoById.json" // 商品详情接口 负责人:zxd
#define kApi_findBaseInfoById @"/goods/findBaseInfoById.json" // 商品基本信息接口（简单结果集，获取价格等） 负责人:zxd
#define kApi_findSpecByGoodsId @"/goods/findSpecByGoodsId.json" // 规格列表 负责人:zxd

/* --------------------------- 物流 ----------------------- */

#define kApi_listNewLogistics @"/order/listNewLogistics.json" // 包裹列表
#define kApi_logisticInfo           @"/kdniao/logisticInfo.json"

/* --------------------------- 我的页面 ---------------------- */


#define kApi_userappPersonalCenter @"/user/appPersonalCenter.json" // 我的 负责人:ygx
#define kApi_addAddress  @"/userAddress/addAddress.json" // 添加用户地址
#define kApi_findDefaultAddress @"/userAddress/findDefaultAddress.json" // 查找默认地址
#define kApi_findMyAddressList @"/userAddress/findMyAddressList.json" // 查询当前账户的地址列表
#define kApi_updateAddress @"/userAddress/updateAddress.json" // 修改地址
#define kApi_deleteAddress @"/userAddress/deleteAddress.json" // 删除地址
//商品收藏列表
#define API_GOODSCOLLECT_LIST     @"/goodsCollect/list.json"
#define API_SHOPCOLLECT_LIST      @"/goodsCollect/list.json"

//收藏清空(商品收藏 = 店铺收藏)
#define API_REMOVEALL             @"/goodsCollect/removeAll.json"
#define API_REMOVE                @"/goodsCollect/cacle.json"

#define kApi_collect @"/goodsCollect/collect.json" // 添加、取消收藏 负责人:zxd
#define kApi_goodsCollect @"/goodsCollect/collect.json" // 收藏接口 负责人:zxd

/* --------------------------- 支付接口 -------------------------- */

//获取支付订单
#define API_Pay_Order   @"/pay/order.json"

/* --------------------- 检查强制更新接口 ------------------------- */

#define API_getNewest   @"/version/getNewest.json"

/* -------------------------- 会员页面 -------------------------- */

//会员续费或开通会员页
#define API_FindVipPriceList   @"/userVipPrice/findVipPriceList.json"
//购买会员接口
#define API_Vip   @"/pay/vip.json"
//会员权益页面
#define API_VipRights   @"/user/vipRights.json"

/* ------------------------ 推荐商品 ----------——-------------*/

/* ------------------------ 静态资源 ------------------------- */

#define kApi_weichat_download                @"/download/download.html"
//苹果商城评论页面
#define URL_APPSTORE_REVIEW     \
@"itms-apps://itunes.apple.com/cn/app/id1445525107?mt=8&action=write-review"


#endif /* ApiHeader_h */
