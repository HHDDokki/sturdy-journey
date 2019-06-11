//
//  OrderDetailManager.m
//  HWDMall
//
//  Created by stewedr on 2018/11/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetailManager.h"
#import "OrderDetaiModel.h" // 订单详情数据模型
#import "OrderdetailCellModel.h" // cell类型

#define  TimeCellHeight 32.5
#define TotalCellHeight 32.5

@implementation OrderDetailManager

- (NSArray *)setOrderDetailUIWithModel:(OrderDetaiResultModel *)model
                             OrderType:(OrderType)type
                           OrderStatus:(OrderStatus)status{
    
    NSMutableArray * cellmodelMuarr = [[NSMutableArray alloc]init];
    OrderdetailCellModel * topModel = [[OrderdetailCellModel alloc]init]; // 头部
    topModel.cellType = OrderDetailCellType_Top;
    OrderdetailCellModel * timeModel = [[OrderdetailCellModel alloc]init]; // 订单时间
    timeModel.cellType = OrderDetailCellType_Time;
    OrderdetailCellModel * totalModel = [[OrderdetailCellModel alloc]init]; // 订单优惠以及总额
    totalModel.cellType = OrderDetailCellType_Total;
    
    [cellmodelMuarr addObject:topModel]; /** 添加头部model **/
    
    OrderdetailCellModel * cellTopmodel = [[OrderdetailCellModel alloc]init]; // 状态条
    cellTopmodel.cellHeight = 63.f;
    
    OrderdetailCellModel * addressMesmodel = [[OrderdetailCellModel alloc]init]; // 地址栏
    addressMesmodel.cellHeight = 80.f;
    addressMesmodel.name = model.addressInfo.receiver;
    addressMesmodel.phone = model.addressInfo.mobile;
    addressMesmodel.address = model.addressInfo.address;
    addressMesmodel.cellType = OrderDetailCellType_Address;
    
    OrderdetailCellModel * pintuanmodel = [[OrderdetailCellModel alloc]init]; // 拼团
    /*
     groupStatus_ing = 1, // 正在拼团
     groupStatus_finish, // 拼团成功
     groupStatus_fail, // 拼团失败
     */
    switch (model.groupInfo.groupStatus) {
        case groupStatus_ing:
            pintuanmodel.groupStatus = @"正在拼单";
            if (model.groupInfo.shareNum > 0) {
             pintuanmodel.groupPerson = NSStringFormat(@"待分享，差%ld人",(long)model.groupInfo.shareNum);
            }else if (model.groupInfo.shareNum == 0 || model.groupInfo.unpaidCount){
                pintuanmodel.groupPerson = NSStringFormat(@"%ld人未支付",(long)model.groupInfo.unpaidCount);
            }else{
                
            }
            break;
        case groupStatus_fail:
            pintuanmodel.groupStatus = @"拼单失败";
            break;
        case groupStatus_finish:
            pintuanmodel.groupStatus = @"拼单成功";
            break;
            
        default:
            break;
    }
    pintuanmodel.groupImageArr = model.groupInfo.imgGroup;
    pintuanmodel.cellType = OrderDetailCellType_Pinduan;
    pintuanmodel.cellHeight = 110.f;
    
    OrderdetailCellModel * wuliumodel = [[OrderdetailCellModel alloc]init]; // 物流
    wuliumodel.wuliumes = model.logisticsInfo.logisticsContent;
    if (model.logisticsInfo.logisticsTime) {
        wuliumodel.wuliuTime = model.logisticsInfo.logisticsTime;
        wuliumodel.isMoreBag = NO;
        wuliumodel.cellHeight = 68.f;
    }else{
        wuliumodel.isMoreBag = YES;
        wuliumodel.cellHeight = 42.f;
    }
    wuliumodel.cellType = OrderDetailCellType_Wuliu;
    
    for (OrderDetaiCartModel * cart in model.cart) {
        OrderdetailCellModel * cartmodel = [[OrderdetailCellModel alloc]init];
        cartmodel.shopName = cart.shopName;
        cartmodel.shopid = cart.shopId;
        cartmodel.goodsCount = NSStringFormat(@"共%ld商品，小计:",cart.totalNum);
        switch (model.orderTitle.orderStatus) {
            case OrderStatus_Closed:
                cartmodel.orderStatus = @"已关闭";
                break;
            case OrderStatus_WaitSend:
                cartmodel.orderStatus = @"待发货";
                break;
            case OrderStatus_WaitPay:
                cartmodel.orderStatus = @"待付款";
                break;
            case OrderStatus_WaitReceive:
                cartmodel.orderStatus = @"待收货";
                break;
            case OrderStatus_WaitShar:
                cartmodel.orderStatus = @"待分享";
                break;
            case OrderStatus_Finished:
                cartmodel.orderStatus = @"已完成";
                break;
            case OrderStatus_Cancel:
                cartmodel.orderStatus = @"已关闭";
                break;
            default:
                break;
        }
        cartmodel.cellType = OrderDetailCellType_GoodsMes;
        for (OrderDetaiGoodsModel * goods in cart.goods) {
            OrderdetailCellModel * goodsmodel = [[OrderdetailCellModel alloc]init];
            goodsmodel.cellType = OrderDetailCellType_GoodsMes;
            goodsmodel.goodsImage = goods.goodsThumb;
            goodsmodel.cellHeight = 114.f;
            goodsmodel.goodsName = goods.goodsName;
            goodsmodel.goodsid = goods.goodsId;
            goodsmodel.goodsGuige = goods.specKeyName;
            goodsmodel.vipPrice = NSStringFormat(@"会员价：¥%.2f",goods.vipPrice);
            
            switch (goods.status) {
                case GoodsStatus_tuikuaning:
                    goodsmodel.tuikuanStatus = @"退款中";
                    break;
                    case GoodsStatus_tuikuanFinished:
                    goodsmodel.tuikuanStatus = @"退款成功";
                    break;
                default:
                    break;
            }
            goodsmodel.goodsCount = NSStringFormat(@"× %ld",(long)goods.goodsNum);
            goodsmodel.goodsPrice = NSStringFormat(@"￥%.2f",goods.finalPrice);
            [cartmodel.cellmodelMuarr addObject:goodsmodel];
        }
        [cellmodelMuarr addObject:cartmodel]; /** 添加店铺model **/
    }
    OrderdetailCellModel * ordersignmodel = [[OrderdetailCellModel alloc]init]; // 订单号
    ordersignmodel.cellType = OrderDetailCellType_OrderTime;
    ordersignmodel.celltitle = @"订单编号:";
    ordersignmodel.buttonHidden = YES;
    ordersignmodel.content = model.orderTime.orderSn;
    ordersignmodel.cellHeight = TimeCellHeight;
    ordersignmodel.content = model.orderTime.orderSn;
    
    OrderdetailCellModel * paywaymodel = [[OrderdetailCellModel alloc]init]; // 支付方式
    paywaymodel.celltitle = @"支付方式:";
    paywaymodel.cellHeight = TimeCellHeight;
    paywaymodel.cellType = OrderDetailCellType_OrderTime;
    switch (model.orderTime.pwName) {
        case Payway_Wxpay:
            paywaymodel.content = @"微信支付";
            break;
            
        case Payway_Alipay:
            paywaymodel.content = @"支付宝支付";
            break;
            
        default:
            break;
    }
    
    OrderdetailCellModel * ordertimemodel = [[OrderdetailCellModel alloc]init]; // 下单时间
    ordertimemodel.celltitle = @"订单创建时间:";
    ordertimemodel.content = [NSString getTime:NSStringFormat(@"%ld",(long)model.orderTime.createTime)];
    ordertimemodel.cellHeight = TimeCellHeight;
    ordertimemodel.content = [NSString getTime:NSStringFormat(@"%ld",(long)model.orderTime.createTime)];
    ordertimemodel.cellType = OrderDetailCellType_OrderTime;
    
    OrderdetailCellModel * pindanTimemodel = [[OrderdetailCellModel alloc]init]; // 拼单时间
    pindanTimemodel.celltitle = @"拼单时间:";
    pindanTimemodel.content = [NSString getTime:NSStringFormat(@"%ld",(long)model.orderTime.groupTime)];
    pindanTimemodel.cellHeight = TimeCellHeight;
    pindanTimemodel.cellType = OrderDetailCellType_OrderTime;
    
    if (model.orderTotal.amount) {// 商品总额
        OrderdetailCellModel * amountModel = [[OrderdetailCellModel alloc]init];
        amountModel.cellType = OrderDetailCellType_OrderTotal;
        amountModel.cellHeight = TotalCellHeight;
        amountModel.celltitle = @"商品总额:";
        amountModel.content = NSStringFormat(@"￥%.2f",model.orderTotal.amount);
        [totalModel.cellmodelMuarr addObject:amountModel];
    }
    if (model.orderTotal.coupon) { // 优惠券
        OrderdetailCellModel * couponModel = [[OrderdetailCellModel alloc]init];
        couponModel.cellType = OrderDetailCellType_OrderTotal;
        couponModel.cellHeight = TotalCellHeight;
        couponModel.celltitle = @"优惠券";
        couponModel.content = NSStringFormat(@"-￥%.2f",model.orderTotal.coupon);
        [totalModel.cellmodelMuarr addObject:couponModel];
    }
    if (model.orderTotal.coin) { // 金豆抵用
        OrderdetailCellModel * coinModel = [[OrderdetailCellModel alloc]init];
        coinModel.cellType = OrderDetailCellType_OrderTotal;
        coinModel.cellHeight = TotalCellHeight;
        coinModel.celltitle = @"金豆";
        coinModel.content = NSStringFormat(@"-￥%.2f",model.orderTotal.coin);
        [totalModel.cellmodelMuarr addObject:coinModel];
    }
    if (model.orderTotal.freight) { // 运费
        OrderdetailCellModel * freightModel = [[OrderdetailCellModel alloc]init];
        freightModel.cellType = OrderDetailCellType_OrderTotal;
        freightModel.cellHeight = TotalCellHeight;
        freightModel.celltitle = @"运费";
        freightModel.content = NSStringFormat(@"￥%.2f",model.orderTotal.freight);
        [totalModel.cellmodelMuarr addObject:freightModel];
    }
    
    OrderdetailCellModel * payCountmodel = [[OrderdetailCellModel alloc]init]; // 实际支付
    payCountmodel.cellHeight = TotalCellHeight;
    payCountmodel.cellType = OrderDetailCellType_ActualPay;
    payCountmodel.content = NSStringFormat(@"￥%.2f",model.orderTotal.actualPay);
    [totalModel.cellmodelMuarr addObject:payCountmodel];
    
    switch (model.orderTitle.orderStatus) {
        case OrderStatus_WaitPay: // 待支付
        {
            cellTopmodel.cellType = OrderDetailCellType_topWaitpay;
            cellTopmodel.celltitle = @"待付款";
            cellTopmodel.timeDown = model.orderTitle.countdown;
            cellTopmodel.imageName = @"order_watch";
            
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];
            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
        }
            break;
        case  OrderStatus_WaitSend: // 待发货
        {
            cellTopmodel.cellType = OrderDetailCellType_topTwoMes;
            cellTopmodel.celltitle = @"待发货";
            cellTopmodel.subTitle = @"预计48小时内发货";
            cellTopmodel.imageName = @"order_finish";
            
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            
            if (type == OrderType_Pintuan) {
                [topModel.cellmodelMuarr addObject:pintuanmodel];
            }
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];
            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
            if (type == OrderType_Pintuan) {
                if (model.orderTime.groupTime) {
                    [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                }
            }
            
//            if (type != OrderType_Kanjia) {
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
//            }

        }
            break;
        case  OrderStatus_WaitShar: // 待分享
        {
            cellTopmodel.cellType = OrderDetailCellType_topPindanTimedown;
            cellTopmodel.celltitle = @"拼单还未成功";
            cellTopmodel.subTitle = @"快邀请小伙伴来拼单吧";
            cellTopmodel.imageName = @"order_wait";
            cellTopmodel.timeDown = model.orderTitle.countdown;
            
            
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            [topModel.cellmodelMuarr addObject:pintuanmodel];
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];
            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
            if (type == OrderType_Pintuan) {
                if (model.orderTime.groupTime) {
                    [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                }
            }
            if (type == OrderType_Pintuan) {
                if (model.orderTime.groupTime) {
                    [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                }
            }
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
        }
            break;
        case  OrderStatus_WaitReceive: // 待收货
        {
            cellTopmodel.cellType = OrderDetailCellType_topTwoMes;
            cellTopmodel.celltitle = @"待收货";
            cellTopmodel.subTitle = model.orderTitle.orderTips;
            cellTopmodel.imageName = @"order_waitsend";
            
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            [topModel.cellmodelMuarr addObject:wuliumodel];
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            if (type == OrderType_Pintuan) {
               [topModel.cellmodelMuarr addObject:pintuanmodel];
            }
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];
            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
            if (type == OrderType_Pintuan) {
                if (type == OrderType_Pintuan) {
                    if (model.orderTime.groupTime) {
                        [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                    }
                }
            }
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
            
        }
            break;
        case  OrderStatus_Finished: // 已完成
        {
            cellTopmodel.cellType = OrderDetailCellType_topOneMes;
            cellTopmodel.celltitle = @"交易成功";
            cellTopmodel.imageName = @"order_finish";
            
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            [topModel.cellmodelMuarr addObject:wuliumodel];
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            if (type == OrderType_Pintuan) {
                [topModel.cellmodelMuarr addObject:pintuanmodel];
            }
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];
            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
                if (type == OrderType_Pintuan) {
                    if (model.orderTime.groupTime) {
                        [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                    }
                }
            
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
            
        }
            break;
            
        case OrderStatus_Closed: // 2
        {
            cellTopmodel.cellType = OrderDetailCellType_topOneMes;
            cellTopmodel.celltitle = @"已关闭";
            cellTopmodel.imageName = @"order_close";
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            if (model.logisticsInfo.logisticsContent) {
                [topModel.cellmodelMuarr addObject:wuliumodel];
            }
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            if (type == OrderType_Pintuan) {
                [topModel.cellmodelMuarr addObject:pintuanmodel];
            }
            if (type == OrderType_Pintuan) {
                if (model.orderTime.groupTime) {
                    [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                }
            }
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];

            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
        }
            break;
        case OrderStatus_Cancel: // 8交易取消
        { // 381 拼单失败   380 交易取消
            if (model.orderTitle.isPaid) {
                cellTopmodel.cellType = OrderDetailCellType_topTwoMes;
                cellTopmodel.celltitle = @"拼单失败";
                cellTopmodel.subTitle = model.orderTitle.orderTips;
                cellTopmodel.imageName = @"order_close";
            }else{
                cellTopmodel.cellType = OrderDetailCellType_topOneMes;
                cellTopmodel.celltitle = @"已关闭";
                cellTopmodel.imageName = @"order_close";
            }
            
            [topModel.cellmodelMuarr addObject:cellTopmodel];
            [topModel.cellmodelMuarr addObject:addressMesmodel];
            if (model.orderTitle.isPaid && model.groupInfo.groupStatus == groupStatus_finish) {
                
            }else if (model.orderTitle.isPaid){
                [topModel.cellmodelMuarr addObject:pintuanmodel];
            }
            if (type == OrderType_Pintuan) {
                if (model.orderTime.groupTime) {
                    [timeModel.cellmodelMuarr addObject:pindanTimemodel];
                }
            }
            
            [timeModel.cellmodelMuarr addObject:ordersignmodel];
            [timeModel.cellmodelMuarr addObject:ordertimemodel];

            if (model.orderTime.pwName) {
                [timeModel.cellmodelMuarr addObject:paywaymodel];
            }
            [cellmodelMuarr addObject:totalModel];
            [cellmodelMuarr addObject:timeModel];
            
        }
            break;
        default:
            break;
    }
    
    return cellmodelMuarr;
    
}

@end
