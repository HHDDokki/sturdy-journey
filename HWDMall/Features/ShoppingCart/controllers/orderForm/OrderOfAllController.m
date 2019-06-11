//
//  OrderOfAllController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/26.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderOfAllController.h"
#import "OrderCellHeaderView.h" // 头视图
#import "BFMallConfirmOrderSectionCell.h" //头视图

#import "BFMallOrderListFooterView.h" //footer;

#import "OrderCellFooterForWatiAndFinished.h" // 已完成
#import "OrderCellFooterForCanceled.h" // 订单取消
#import "OrderCellFooterForOneMes.h" // 一条信息footer
#import "OrderCellFooterForTimedown.h" // 拼单倒计时footer
#import "OrderGoodsMesCell.h" // 单条商品信息cell

#import "BFMallOrderShopListCell.h" //多条商品信息
#import "OrderMoreGoodsCell.h" // 多条商品信息
#import "OrderListModel.h"
#import "MyOrderDetailController.h"
#import "ConfirmOrderViewController.h" // 填写订单
#import "BasePayViewController.h"

#import "SelectPayWayView.h" // 支付方式view
#import "CancelReasonView.h" // 取消原因
#import "PaySuccessController.h"// 订单支付成功
#import "BFMallPayResultController.h"// 订单支付成功
//#import "BargainLogisticsController.h" // 物流
#import "HHDAlertView.h" // 提示框
#import "WuliuListViewController.h" //  物流列表

#import "BFMallConfirmOrderGoodsCell.h"


static NSString * const GoodsCellID = @"GOODSCELLDI";
static NSString * const MoreGoodsCellID = @"MOREGOODSCELLID";
static NSString * const TimeDownFooterID = @"TIMEDOWNFOOTERID";
static NSString * const OnemesFooterID = @"ONEMESFOOTERID";
static NSString * const MoreFooterID = @"MOREFOOTERID";
static NSString * const CancelFooterID = @"CANCELFOOTERID";
static NSString * const FinishFooterID = @"FINISHEDFOOTERID";
static NSString * const HeaderviewID = @"HEADERVIEWID";

#define  key_status @"status"
#define  key_updateTime @"updateTime"
#define noDataMes @"暂无数据"
static NSString * timedownSourceName = @"OrderOfAllControllertimer";
@interface OrderOfAllController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *mesTable;
@property (nonatomic,strong) NSMutableArray *mesMuarr;
@property (nonatomic,assign) NSInteger refreshTime;
@property (nonatomic,assign) CGFloat totalmoney;
@property (nonatomic,assign) NSInteger parentid;
@property (nonatomic,assign) NSInteger sonid;

@property (nonatomic,assign) BOOL isUnpack;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic,strong) UIButton * closeBtn; // 全部关闭

@end

@implementation OrderOfAllController

#pragma mark -- lazyload

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, 22, 44);
        [_closeBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UITableView *)mesTable{
    if (!_mesTable) {
        _mesTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"man-没有订单"
                                                                 titleStr:noDataMes
                                                                detailStr:@""
                                                              btnTitleStr:@""
                                                            btnClickBlock:^{}];
        //元素竖直方向的间距
        emptyView.subViewMargin = 12.f;
        emptyView.contentViewY = 130;
        emptyView.imageSize = CGSizeMake(SCREEN_W/3, 0.47*SCREEN_W/3);
        //标题颜色
        emptyView.titleLabTextColor = UIColorFromHex(0x999999);
        //描述字体
        emptyView.titleLabFont = kFont(13);
        _mesTable.ly_emptyView = emptyView;
        _mesTable.delegate = self;
        _mesTable.dataSource = self;
        UIView * footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        footerview.backgroundColor = UIColorFromHex(0xeeeeee);
        _mesTable.tableFooterView = footerview;
        _mesTable.backgroundColor = [UIColor whiteColor];
        _mesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [_mesTable registerClass:[BFMallConfirmOrderGoodsCell class] forCellReuseIdentifier:GoodsCellID];
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderGoodsMesCell class]) bundle:nil] forCellReuseIdentifier:GoodsCellID];
        
        [_mesTable registerClass:[BFMallOrderShopListCell class] forCellReuseIdentifier:MoreGoodsCellID];
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderMoreGoodsCell class]) bundle:nil] forCellReuseIdentifier:MoreGoodsCellID];
        
        [_mesTable registerClass:[BFMallConfirmOrderSectionCell class] forHeaderFooterViewReuseIdentifier:HeaderviewID];
        
        
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCellHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:HeaderviewID];
        
        
        [_mesTable registerClass:[BFMallOrderListFooterView class] forHeaderFooterViewReuseIdentifier:OnemesFooterID];
//        [_mesTable registerClass:[BFMallOrderListFooterView class] forHeaderFooterViewReuseIdentifier:FinishFooterID];
//        [_mesTable registerClass:[BFMallOrderListFooterView class] forHeaderFooterViewReuseIdentifier:CancelFooterID];
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCellFooterForWatiAndFinished class]) bundle:nil] forHeaderFooterViewReuseIdentifier:FinishFooterID];
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCellFooterForCanceled class]) bundle:nil] forHeaderFooterViewReuseIdentifier:CancelFooterID];
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCellFooterForOneMes class]) bundle:nil] forHeaderFooterViewReuseIdentifier:OnemesFooterID];
        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCellFooterForTimedown class]) bundle:nil] forHeaderFooterViewReuseIdentifier:TimeDownFooterID];
        
        __weak typeof(self) weakSelf = self;
        _mesTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.refreshTime = 0;
            [weakSelf.mesMuarr removeAllObjects];
            [weakSelf loadData];
            [weakSelf.mesTable.mj_footer resetNoMoreData];
        }];
        
        _mesTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
    }
    return _mesTable;
}
- (NSMutableArray *)mesMuarr{
    if (!_mesMuarr) {
        _mesMuarr = [[NSMutableArray alloc]init];
    }
    return _mesMuarr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetOrderList) name:ResetOrderListPostName object:nil]; // 刷新列表
    self.refreshTime = 0;
    [self setNav];
    [self setUI];
    [self loadData];
    
    self.isFirst = YES;
    [kCountDownManager start];
}
#pragma mark --  setUI

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

- (void)setUI{
    [self.view addSubview:self.mesTable];
    [self.mesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabbarHeight - 40);
    }];
}

#pragma mark -- loadData
- (void)loadData{
    NSDictionary * param = @{
                             key_status : [NSNumber numberWithInteger:self.orderStatus],
                             key_updateTime :[NSNumber numberWithInteger:self.refreshTime]
                             };
    [self.view makeToastActivity];
    __weak typeof(self) weakSelf = self;
    [kCountDownManager reloadAllSource];
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_findOrderList) parameters:param success:^(id  _Nonnull responseObject) {
        [self.view hideToastActivity];
        [weakSelf.mesTable.mj_footer endRefreshing];
        [weakSelf.mesTable.mj_header endRefreshing];
        OrderListModel * listmodel = [OrderListModel mj_objectWithKeyValues:responseObject];
        if ([listmodel.code isEqualToString:@"0"]) {
            if (listmodel.result == nil || listmodel.result.count == 0) {
                self.mesTable.backgroundColor = [UIColor hexColor:@"#EEEEEE"];
                return ;
            }
            self.mesTable.backgroundColor = [UIColor whiteColor];
            [weakSelf.mesMuarr addObjectsFromArray:listmodel.result];
            OrderlistResultModel * lastmodel = [listmodel.result lastObject];
            weakSelf.refreshTime = lastmodel.updateTime;
            for (OrderlistResultModel * resultmodel in weakSelf.mesMuarr) {
                resultmodel.timeSourceName = NSStringFormat(@"%@%ld",timedownSourceName,weakSelf.refreshTime);
            }
            [kCountDownManager addSourceWithIdentifier:NSStringFormat(@"%@%ld",timedownSourceName,weakSelf.refreshTime)];
            if (!listmodel.result.count) {
                [weakSelf.mesTable.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.mesTable reloadData];
        }else{
            [weakSelf.view makeToast:listmodel.msg];
        }
        
    } failure:^(NSError * _Nonnull error) {
        RDLog(@"%ld",(long)error.code);
        [weakSelf.view hideToastActivity];
    }];
    
}

#pragma mark -- tableviewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.mesMuarr.count ? self.mesMuarr.count : 0;
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL multiGoods;
    OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:indexPath.section];
    OrderlistShopModel * shopmodel = [resultmodel.shop objectAtIndex:0];
    OrderlistGoodsModel * goodmodel = [shopmodel.goods objectAtIndex:0];
    __weak typeof(self) weakSelf = self;
    multiGoods = resultmodel.shop.count > 1 || (resultmodel.shop.count == 1 && shopmodel.goods.count >1);
    if (multiGoods) {
        NSInteger goodsCount = 0;
        for (OrderlistShopModel * shopmodel1 in resultmodel.shop) {
            goodsCount += shopmodel1.goods.count;
        }
        return 114.f*goodsCount + (resultmodel.shop.count-1)*8.0;
    }
    return 110.f;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
   
     return 40.f;;
//    else if (section == 0) {
//        return 46.f;
//    }else{
//        return 56.f;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:section];
    if (resultmodel.orderStatus == OrderStatus_Closed || resultmodel.orderStatus == OrderStatus_Cancel || resultmodel.orderStatus == OrderStatus_WaitSend) {
        return 8.f;
    };
    if (0) {
            return 41.f;
    }else{
        return 70.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL multiGoods;
    OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:indexPath.section];
    OrderlistShopModel * shopmodel = [resultmodel.shop objectAtIndex:0];
    OrderlistGoodsModel * goodmodel = [shopmodel.goods objectAtIndex:0];
    __weak typeof(self) weakSelf = self;
    multiGoods = resultmodel.shop.count > 1 || (resultmodel.shop.count == 1 && shopmodel.goods.count >1);
    if (multiGoods) {
        
        BFMallOrderShopListCell *moreGoodsCell = [tableView dequeueReusableCellWithIdentifier:MoreGoodsCellID];
        [moreGoodsCell.muArr removeAllObjects];
        [moreGoodsCell.muArr addObjectsFromArray:resultmodel.shop];
        [moreGoodsCell.mesTable reloadData];

        moreGoodsCell.tapblock = ^{
            OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:indexPath.section];
            OrderlistShopModel * shopmodel;
            if (resultmodel.shop.count == 1) {
                shopmodel = [resultmodel.shop objectAtIndex:0];
            }
            if (self.pushBlock) {
                self.pushBlock(resultmodel.parentOrderId, 2);
            }
            MyOrderDetailController * orderdetail = [[MyOrderDetailController alloc]init];
            orderdetail.orderSign = resultmodel.orderSn;
            [orderdetail updateOrderDetailMesWithParentOrderID:resultmodel.parentOrderId
                                                    SonOrderID:shopmodel.sonOrderId
                                                     OrderType:resultmodel.orderType
                                                   OrderStatus:resultmodel.orderStatus];
            [weakSelf.basecontroller.navigationController pushViewController:orderdetail animated:YES];
        };
                return moreGoodsCell;
    }else{
        
        BFMallConfirmOrderGoodsCell * goodscell = [tableView dequeueReusableCellWithIdentifier:GoodsCellID];

        [goodscell updateGoodsMesWithHeadImage:goodmodel.goodsThumb
                                     Goodsname:goodmodel.goodsName
                                    Goodsprice:shopmodel.totalPrice
                                    GoodsGuige:goodmodel.specKeyName
                                      GoodsNum:goodmodel.goodsNum
                                    TuikanStatus:goodmodel.status];
                return goodscell;
    }
}
//
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BFMallConfirmOrderSectionCell *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderviewID];
    
    OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:section];

    BOOL havemoreShop;
    OrderlistShopModel * shopmodel;
    if (resultmodel.shop.count > 1) {
        havemoreShop = YES;
    }else{
        havemoreShop = NO;
    }
    if (resultmodel.shop.count) {
        shopmodel = [resultmodel.shop objectAtIndex:0];
    }
    
        switch (resultmodel.orderStatus) {
            case OrderStatus_WaitPay:
            {
                [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"待付款"];
            }
                break;
                
            case OrderStatus_WaitShar: // 待分享
            {
                if (resultmodel.needNum) {
                     [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:NSStringFormat(@"待分享，差%ld人",resultmodel.needNum)];
                }else if (resultmodel.needNum == 0 && resultmodel.unpaidCount){
                    [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:NSStringFormat(@"%ld人未支付",resultmodel.unpaidCount)];
                }
            }
                break;
                
            case OrderStatus_WaitSend: // 待发货
            {
                [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"商品准备配送"];
            }
                break;
                
            case OrderStatus_WaitReceive: // 待收货
            {
                [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"待收货"];
            }
                break;
                
            case OrderStatus_Finished: // 交易成功
            {
                [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"已完成"];
            }
                break;
                
            case OrderStatus_Closed:  // 交易关闭
            {

                    [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"已关闭"];

            }
                break;
             case OrderStatus_Cancel:
            {
                if (resultmodel.orderType == OrderType_Pintuan) {
                    if (resultmodel.isPaid) {
                        [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"拼单失败，已退款"];
                    }else{
                        [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"已关闭"];
                    }
                }else{
                    [header updateHeaderWithMoreShops:havemoreShop ShopName:shopmodel.shopName AndOrderStatus:@"已关闭"];
                }
            }
                break;
            default:
                break;
        }

    
    return header;
}
//
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:section];
    OrderlistShopModel * shopmodel = [resultmodel.shop objectAtIndex:0];
    OrderlistGoodsModel * goodmodel = [shopmodel.goods objectAtIndex:0];
    
    switch (resultmodel.orderStatus) {
        case OrderStatus_WaitPay:
        {
            BFMallOrderListFooterView * waitpayFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OnemesFooterID];
            if (!waitpayFooter) {
                waitpayFooter = [[BFMallOrderListFooterView alloc] initWithReuseIdentifier:OnemesFooterID];
            }
            [waitpayFooter updateFooterWithLeftName:@"取消订单" RightName:@"去付款"];
            __weak typeof(self) weakSelf = self;
            waitpayFooter.rightBtnBlock = ^{
                SelectPayWayView *payview = [[SelectPayWayView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [payview bindPrice:resultmodel.totalPrice];
                [kWindow addSubview:payview];
                payview.payBlock = ^(Payway payway) { // 1 微信  2 支付宝
                    if (payway == Payway_Alipay) {
                        [self payWithOrderNo:resultmodel.orderSn paymentMethod:@"2"];
                    }else{
                        [self payWithOrderNo:resultmodel.orderSn paymentMethod:@"1"];
                    }
                    OrderlistShopModel * shopmodel = [resultmodel.shop objectAtIndex:0];
                    weakSelf.totalmoney = resultmodel.totalPrice;
                    weakSelf.parentid = resultmodel.parentOrderId;
                    weakSelf.sonid = shopmodel.sonOrderId;
                    if (resultmodel.shop.count > 1) {
                        weakSelf.isUnpack = YES;
                    }else{
                        weakSelf.isUnpack = NO;
                    }
                };
            };
            waitpayFooter.leftBtnBlock = ^{
                RDLog(@"取消订单");
                CancelReasonView * cancelOrdeViewl = [[CancelReasonView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [kWindow addSubview:cancelOrdeViewl];
                cancelOrdeViewl.cancelBlock = ^(NSString *reasonStr) {
                    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                    [params setValue:reasonStr forKey:@"reason"];
                    [params setValue:[NSNumber numberWithInteger:resultmodel.parentOrderId] forKey:@"parentOrderId"];
                    if (resultmodel.shop.count == 1) {
                        OrderlistShopModel * shopmodel = [resultmodel.shop objectAtIndex:0];
                        [params setValue:[NSNumber numberWithInteger:shopmodel.sonOrderId] forKey:@"sonOrderId"];
                    }
                    [self.view makeToastActivity];
                    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_cancelOrder) parameters:params success:^(id  _Nonnull responseObject) {
                        [self.view hideToastActivity];
                        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
                            [[NSNotificationCenter defaultCenter]postNotificationName:ResetOrderListPostName object:nil];
                            [weakSelf.mesTable.mj_footer resetNoMoreData];
                        }else{
                            [self.view makeToast:[responseObject objectForKey:@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        [self.view hideToastActivity];
                    }];
                };
            };
            return waitpayFooter;
        }
            break;
        case OrderStatus_WaitSend:
        {
            BFMallOrderListFooterView * closeFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OnemesFooterID];
            if (!closeFooter) {
                closeFooter = [[BFMallOrderListFooterView alloc] initWithReuseIdentifier:OnemesFooterID];
            }
            return closeFooter;
        }
            break;
        case OrderStatus_WaitReceive:
        {
            BFMallOrderListFooterView * closeFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OnemesFooterID];
            if (!closeFooter) {
                closeFooter = [[BFMallOrderListFooterView alloc] initWithReuseIdentifier:OnemesFooterID];
            }
            [closeFooter updateFooterWithLeftName:@"查看物流" RightName:@"确认收货" Price:resultmodel.totalPrice];
            return closeFooter;
        }
            break;
        case OrderStatus_Finished:
        {
            BFMallOrderListFooterView * closeFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OnemesFooterID];
            if (!closeFooter) {
                closeFooter = [[BFMallOrderListFooterView alloc] initWithReuseIdentifier:OnemesFooterID];
            }
            if (goodmodel.status == 1 || goodmodel.status == 2) {
                [closeFooter updateFooterWithRightName:@"联系客服" Price:resultmodel.totalPrice];

            }
            [closeFooter updateFooterWithRightName:@"联系客服"];
            return closeFooter;
        }
            break;
        case OrderStatus_Closed:  // 交易关闭
        {
            BFMallOrderListFooterView * closeFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OnemesFooterID];
            if (!closeFooter) {
                closeFooter = [[BFMallOrderListFooterView alloc] initWithReuseIdentifier:OnemesFooterID];
            }
            [closeFooter updateFooter];
            return closeFooter;
        }
            break;
        case OrderStatus_Cancel:
        {
            BFMallOrderListFooterView * closeFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OnemesFooterID];
            if (!closeFooter) {
                closeFooter = [[BFMallOrderListFooterView alloc] initWithReuseIdentifier:CancelFooterID];
            }
            [closeFooter updateFooter];
            return closeFooter;
        }
            break;
            
        default:
            break;
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderlistResultModel * resultmodel = [self.mesMuarr objectAtIndex:indexPath.section];
    OrderlistShopModel * shopmodel;
    if (resultmodel.shop.count == 1) {
        shopmodel = [resultmodel.shop objectAtIndex:0];
    }
    if (self.pushBlock) {
        self.pushBlock(resultmodel.parentOrderId, 2);
    }
    MyOrderDetailController * orderdetail = [[MyOrderDetailController alloc]init];
    orderdetail.orderSign = resultmodel.orderSn;
    [orderdetail updateOrderDetailMesWithParentOrderID:resultmodel.parentOrderId
                                            SonOrderID:shopmodel.sonOrderId
                                             OrderType:resultmodel.orderType
                                           OrderStatus:resultmodel.orderStatus];
    [self.basecontroller.navigationController pushViewController:orderdetail animated:YES];
}


#pragma mark -- payDelegate

- (void)paySuccess:(BOOL)success channel:(NSString *)channel{
    RDLog(@"✅5");
    if (success) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ResetOrderListPostName object:nil];
        
        BFMallPayResultController *paysueccess = [[BFMallPayResultController alloc] init];
        [paysueccess updateMesWith:YES];
//        PaySuccessController *paysueccess =[[PaySuccessController alloc]init];
//        NSString * chanelWay;
//        if ([channel isEqualToString:@"1"]) {
//            chanelWay = @"微信支付";
//        }else{
//            chanelWay = @"支付宝支付";
//        }
//        NSString * payway;
//        paysueccess.isUnpack = self.isUnpack;
//        [paysueccess updateMesWith:chanelWay PayPrice:NSStringFormat(@"￥%.2f",self.totalmoney)];
//        paysueccess.parentOrderSign = NSStringFormat(@"%ld",(long)self.parentid);
//        paysueccess.sonOrderSign = NSStringFormat(@"%ld",(long)self.sonid);
        paysueccess.hidesBottomBarWhenPushed = YES;
        [self.basecontroller.navigationController pushViewController:paysueccess animated:YES];
    }else{
        BFMallPayResultController *paysueccess = [[BFMallPayResultController alloc] init];
        [paysueccess updateMesWith:NO];
        paysueccess.hidesBottomBarWhenPushed = YES;
        [self.basecontroller.navigationController pushViewController:paysueccess animated:YES];
//        [self.view makeToast:@"支付失败"];
    }
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)dealloc{
        // 废除定时器
    [kCountDownManager removeAllSource];
    [kCountDownManager invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ResetOrderListPostName object:nil];
}

- (void)resetOrderList{
    self.refreshTime = 0;
    [self.mesMuarr removeAllObjects];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isFirst) {
        [self.mesTable reloadData];
    }
//    [kCountDownManager reloadAllSource];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.isFirst = NO;
}


@end


