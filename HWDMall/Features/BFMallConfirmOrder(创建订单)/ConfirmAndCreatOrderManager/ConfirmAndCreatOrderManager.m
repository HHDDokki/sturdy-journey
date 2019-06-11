//
//  ConfirmAndCreatOrderManager.m
//  HWDMall
//
//  Created by stewedr on 2018/11/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmAndCreatOrderManager.h"
#import "ConfirmAndCreatOrderModel.h" // 获取订单信息模型
#import "OderCellModel.h" // 订单详情UI

@implementation ConfirmAndCreatOrderManager

- (NSArray *)setConfirmOrderUIModel:(ConfirmAndCreatorderResultModel *)model{
    NSMutableArray *  modelMuarr = [[NSMutableArray alloc]init];
    
    OderCellModel * topmodel = [[OderCellModel alloc]init];
    topmodel.sectionHeight = CGFLOAT_MIN;
    topmodel.sectionFooterHeight = 8.f;
    topmodel.ordercelltype = ConfirmOrderCellType_Top; // 地址和支付 分组
    
    OderCellModel * addressmodel =[[OderCellModel alloc]init];
    addressmodel.ordercellHeight = 89.f;
    addressmodel.sectionFooterHeight = 8.f;
    addressmodel.ordercelltype = ConfirmOrderCellType_TopNoMes; //地址cell
    
    OderCellModel * paymodel = [[OderCellModel alloc]init];
    paymodel.ordercellHeight = 116.f;
    paymodel.sectionFooterHeight = 0.f;
    paymodel.ordercelltype = ConfirmOrderCellType_Payway; // 支付cell
    
    OderCellModel * noPeisongModel = [[OderCellModel alloc]init];
    noPeisongModel.ordercellHeight = 31.f;
    noPeisongModel.ordercelltype = ConfirmOrderCellType_NoPeisong; // 不能配送cell
    if (!model.isCanDeliver) {
        [topmodel.modelMuarr addObject:noPeisongModel]; // 默认不能配送
    }
    [topmodel.modelMuarr addObject:addressmodel];

    [modelMuarr addObject:topmodel];
    
    for (ConfirmAndCreatOrderliseModel * listmodel in model.orderList) {
        OderCellModel * shopmodel = [[OderCellModel alloc]init];
        shopmodel.ordercelltype = ConfirmOrderCellType_Goods;   // 店铺分组
        shopmodel.title = listmodel.shopName; // 店铺名字
        shopmodel.sectionHeight = 40.f;
            if (listmodel.shippingPrice) {
                shopmodel.sectionFooterHeight = 8.f;
            }else{
                shopmodel.sectionFooterHeight = 8.f;
            }
        shopmodel.shopid = listmodel.shopId;
//        shopmodel.totalPrice = listmodel.totalAmount; // 商品总额
//        shopmodel.goodsNum = NSStringFormat(@"共%ld件商品,小计:",(long)listmodel.goodsNum); // 商品总数
//        if (model.promType == OrderType_Kanjia) {
//            shopmodel.goodsNum = @"";
//        }
//        shopmodel.yunfei = listmodel.shippingPrice; // 运费
//        RDLog(@"运费：%f",listmodel.shippingPrice);
        for (ConfirmAndCreatOrderGoodsListModel * goodslisemodel in listmodel.orderGoodsList) {
            OderCellModel * goodsmodel = [[OderCellModel alloc]init];
            goodsmodel.ordercelltype = ConfirmOrderCellType_GoodsMes;  // 商品model
            goodsmodel.goodsNum = NSStringFormat(@"×%ld",(long)goodslisemodel.goodsNum);
            goodsmodel.goodsHeadImage = goodslisemodel.goodsThumb;
            goodsmodel.ordercellHeight = 114.f;
            goodsmodel.goodsid = goodslisemodel.goodsId;
            goodsmodel.goodsName = goodslisemodel.goodsName;
            goodsmodel.goodsGuige = goodslisemodel.specKeyName;
            goodsmodel.savedMoney = NSStringFormat(@"会员价: ¥%.2f", goodslisemodel.goodsPrice - goodslisemodel.vipPrice);
            goodsmodel.vipPrice = NSStringFormat(@"会员价: ¥%.2f", goodslisemodel.vipPrice);
            goodsmodel.goodsPrice = NSStringFormat(@"￥%.2f",goodslisemodel.goodsPrice);
            [shopmodel.modelMuarr addObject:goodsmodel];
        }
         [modelMuarr addObject:shopmodel];
    }
    
    
//    if (model.isVipUser) {
    
        NSDictionary *userVipModel = model.userVipPrice;
        OderCellModel * vipModel = [[OderCellModel alloc]init];
        vipModel.ordercelltype = ConfirmOrderCellType_VipChoiceMes;
        vipModel.sectionFooterHeight = 8.f;
        
        OderCellModel *vipDetailModel = [[OderCellModel alloc]init];
        vipDetailModel.savedMoney = NSStringFormat(@"%.2f",model.savePrice);
    vipDetailModel.vipPrice = NSStringFormat(@"%.2f",userVipModel[@"vipPrice"]);
        vipDetailModel.ordercellHeight = 144.f;
        vipDetailModel.ordercelltype = ConfirmOrderCellType_VipChoiceMes;
        vipDetailModel.isVip = model.isVipUser;
    
        [vipModel.modelMuarr addObject:vipDetailModel];
        [modelMuarr addObject:vipModel];
//    };
    
    
    OderCellModel * jiesuanmodel = [[OderCellModel alloc]init];
    jiesuanmodel.sectionHeight =CGFLOAT_MIN;
    jiesuanmodel.sectionFooterHeight = 8.f;
    jiesuanmodel.ordercelltype = ConfirmOrderCellType_OrderMes;
    
    OderCellModel * jiesuanOrderPricemodel = [[OderCellModel alloc]init];
    jiesuanOrderPricemodel.ordercellHeight = 32.5;
    jiesuanOrderPricemodel.ordercelltype =ConfirmOrderCellType_OrderdetailMes;
    jiesuanOrderPricemodel.title = @"商品价格";
    jiesuanOrderPricemodel.contentMes = NSStringFormat(@"+￥%.2f",model.goodsPrice);
    
    OderCellModel * jiesuanhouhuiyunfei = [[OderCellModel alloc]init];
    jiesuanhouhuiyunfei.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
    jiesuanhouhuiyunfei.ordercellHeight = 32.5;
    jiesuanhouhuiyunfei.title = @"运费";
    jiesuanhouhuiyunfei.contentMes = NSStringFormat(@"+￥%.2f",model.shippingPrice);
    

    [jiesuanmodel.modelMuarr addObject:jiesuanOrderPricemodel];
    [jiesuanmodel.modelMuarr addObject:jiesuanhouhuiyunfei];
    [modelMuarr addObject:jiesuanmodel];
    
    [modelMuarr addObject:paymodel];
    [paymodel.modelMuarr addObject:paymodel];
    return modelMuarr;
}

@end
