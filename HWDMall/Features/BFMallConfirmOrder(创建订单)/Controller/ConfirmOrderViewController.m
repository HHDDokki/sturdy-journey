//
//  ConfirmOrderViewController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BFMallConfirmOrderAddressCell.h"
#import "BFMallConfirmOrderGoodsCell.h"
#import "ConfirmOrderViewController.h"



#import "ConfirmOrderTopCell.h"
#import "BFMallConfirmOrderTopCell.h"


#import "ConfirmOrderSectionView.h" // 商家信息
#import "BFMallConfirmOrderSectionCell.h"

#import "BFMallIOrderVipChoiceCell.h" //选购vipCell

#import "ConfirmOrderGoodsCell.h" // 商品信息
#import "ConfirmOrderBottomCell.h" // 使用代金币
#import "NowuliuCell.h" // 物流
#import "ConfirmOrderTopWithMesCell.h" // 地址有信息
#import "OrderDealMesCell.h" // 订单总的
#import "ConfirmOrderViewGoodsFootderView.h" // 商品组footer
#import "GoodOneMesFooter.h" // 没有运费footer
#import "PaywayCell.h"
#import "OderCellModel.h"

#import "ConfirmOrderPayView.h"

#import "BFMallPayBottomBar.h"

#import "HHDAlertView.h"
#import "ConfirmAndCreatOrderModel.h"
#import "ConfirmAndCreatOrderManager.h" // 处理数据model
#import "ConsigneeAddressController.h" // 地址列表
#import "ConfirmOrderController.h" // 确认订单
#import "DefaultAddresmodel.h" // 默认地址
#import "BFMallGoodsDetailController.h"  // 商品详情
#import "PaySuccessController.h" // 支付成功
#import "BFMallPayResultController.h"

//HYK
#import "ConfirmOrderParam.h"
#import "MyOrderFormController.h" // 我的订单
#import "ConfirmOrderPayParam.h"
#import "MyOrderDetailController.h"
//HYK


#define CoinCannotUseMes @"代金币未到达额度，不可使用"

static NSString * const goodsFooterID = @"GOODSFOOTERID";
static NSString * const goodsOnemesFooterID = @"GOODSONEMESFOOTER";
static NSString * const orderAcountMesCellID = @"ACOUNTMESSCELLID";
static NSString * const youhuiquanCellID = @"YOUHUIQUANCELLID";
static NSString * const addresswithmesCellID = @"ADDRESSWITHMESCELLID";
static NSString * const wuliucellID = @"WULIUCELLID";
static NSString * const bottomCellID = @"BOTTOMCELLID";
static NSString * const topCellID = @"TOPCELLID";
static NSString * const sectionCellID = @"SECTIONCELLID";
static NSString * const goodsCellID = @"GOODSCELLID";
static NSString * const paywayCellID = @"PAYWAYCELLID";
static NSString * const vipChoiceCellId = @"VIPCELLID";


#define key_ordertype @"orderType"
#define key_buyType @"buyType"
#define key_sku @"sku"
#define key_quantity @"quantity"
#define key_addressId @"addressId"
#define key_couponId @"couponId"
#define key_useCoin @"useCoin"
#define key_foundId @"foundId"
#define key_activityId @"activityId"

@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * mesTable;
@property (nonatomic,strong) NSMutableArray * muData;
//@property (nonatomic,strong) ConfirmOrderPayView *payView;
@property (nonatomic,strong) BFMallPayBottomBar *payView;
@property (nonatomic,strong) NSMutableArray *youhuiquanCanUseMuarr; // 可用优惠券
@property (nonatomic,strong) NSMutableArray *youhuiquanNoUseMuarr; // 不可用优惠券
@property (nonatomic,strong) DefaultAddressListModel * defaultaddressmodel;
@property (nonatomic,strong) ConfirmAndCreatOrderModel * confirmAndCreatOrderModel;
@property (nonatomic,assign) CGFloat goodsPrice;
@property (nonatomic,assign) CGFloat yunfei;;
@property (nonatomic,strong) ConfirmAndCreatorderResultModel * myResultmodel;;
@property (nonatomic,assign) Payway payType; // 购买类型;

@property (nonatomic,assign) BOOL useCoin; // 是否用金币;
@property (nonatomic,assign) OrderType ordertype;
@property (nonatomic,assign) BuyType buytype;
@property (nonatomic,assign) NSInteger sku;
@property (nonatomic,assign) NSInteger goodsid;
@property (nonatomic,assign) NSInteger quantity; // 商品数量
@property (nonatomic,assign) NSInteger addressid; // 地址id
@property (nonatomic,assign) NSInteger couponId;// 优惠券id
@property (nonatomic,assign) NSInteger foundId; // 拼团id
@property (nonatomic,assign) NSInteger activityId;// 活动id
@property (nonatomic,assign) BOOL isCanDeliver; // 是否可以运输
@property (nonatomic,assign) BOOL isFirstIn;
@property (nonatomic,assign) CGFloat youhuiPrice; // 优惠金额
@property (nonatomic,strong) UIButton * closeBtn; // 全部关闭


//HYK
@property (nonatomic,assign) BOOL isPop;
@property (nonatomic,strong) ConfirmOrderPayParam *payParam;
//HYK

@end

@implementation ConfirmOrderViewController

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

- (NSMutableArray *)youhuiquanNoUseMuarr{
    if (!_youhuiquanNoUseMuarr) {
        _youhuiquanNoUseMuarr = [[NSMutableArray alloc]init];
    }
    return _youhuiquanNoUseMuarr;
}

- (NSMutableArray *)youhuiquanCanUseMuarr{
    if (!_youhuiquanCanUseMuarr) {
        _youhuiquanCanUseMuarr = [[NSMutableArray alloc]init];
    }
    return _youhuiquanCanUseMuarr;
}

- (BFMallPayBottomBar *)payView{
    if (!_payView) {
        _payView = [[BFMallPayBottomBar alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        _payView.payBlock = ^{
            [weakSelf payMoney];
        };
    }
    return _payView;
}

- (NSMutableArray *)muData{
    if (!_muData) {
        _muData = [[NSMutableArray alloc]init];
        
    }
    return _muData;
}

- (UITableView *)mesTable{
    if (!_mesTable) {
        _mesTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mesTable.backgroundColor = [UIColor whiteColor];
        _mesTable.delegate = self;
        _mesTable.dataSource = self;
        _mesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mesTable.tableFooterView = [UIView new];
        
        
        [_mesTable registerClass:[BFMallIOrderVipChoiceCell class] forCellReuseIdentifier:vipChoiceCellId];
        
        [_mesTable registerClass:[BFMallConfirmOrderTopCell class] forCellReuseIdentifier:topCellID];
        
        [_mesTable registerClass:[BFMallConfirmOrderGoodsCell class] forCellReuseIdentifier:goodsCellID];

//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([ConfirmOrderBottomCell class]) bundle:nil] forCellReuseIdentifier:bottomCellID];
        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([PaywayCell class]) bundle:nil] forCellReuseIdentifier:paywayCellID];
        
        [_mesTable registerClass:[BFMallConfirmOrderSectionCell class] forHeaderFooterViewReuseIdentifier:sectionCellID];
        
        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([NowuliuCell class]) bundle:nil
                                ] forCellReuseIdentifier:wuliucellID];
        [_mesTable registerClass:[BFMallConfirmOrderAddressCell class] forCellReuseIdentifier:addresswithmesCellID];

        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDealMesCell class]) bundle:nil] forCellReuseIdentifier:orderAcountMesCellID];
//        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([ConfirmOrderViewGoodsFootderView class]) bundle:nil] forCellReuseIdentifier:goodsFooterID];
        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([GoodOneMesFooter class]) bundle:nil] forCellReuseIdentifier:goodsOnemesFooterID];
        
    }
    return _mesTable;
}

//HYK
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (self.isPop && self.buytype == BuyType_shopcart) {
        [self orderGenerationEvent];
    }
    self.navigationController.navigationBar.translucent = NO;

}
//HYK

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    // Do any additional setup after loading the view.
    self.payParam = [[ConfirmOrderPayParam alloc] init];
    self.isPop = NO;
    self.isFirstIn = YES;
    self.goodsPrice = 0.00;
    self.yunfei = 0.00;
    self.payType = Payway_Wxpay; // 默认支付宝
    self.payView.isCanDeliver = NO; // 默认不可配送
    self.defaultaddressmodel = [[DefaultAddressListModel alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"填写订单"]];
    [self set_leftButton];
    [self setNav];
    [self setUI];
    [self setData];
    self.hideSlideRecognizer = NO;

}

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

#pragma mark -- setData
- (void)setData{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:self.ordertype] forKey:key_ordertype];
    [params setValue:[NSNumber numberWithInt:self.buytype] forKey:key_buyType];
    [params setValue:[NSNumber numberWithInteger:self.sku] forKey:key_sku];
    [params setValue:[NSNumber numberWithInteger:self.quantity] forKey:key_quantity];
    if (self.addressid) {
        [params setValue:[NSNumber numberWithInteger:self.addressid] forKey:key_addressId];
    }
    [params setValue:[NSNumber numberWithInteger:self.couponId] forKey:key_couponId];
    [params setValue:[NSNumber numberWithInteger:self.useCoin] forKey:key_useCoin];
    [params setValue:[NSNumber numberWithInteger:self.foundId] forKey:key_foundId];
    [params setValue:[NSNumber numberWithInteger:self.activityId] forKey:key_activityId];
    if (self.isSelecVip) {
        [params setValue:[NSNumber numberWithInteger:1] forKey:@"vipSelected"];
        
    }else {
        [params setValue:[NSNumber numberWithInteger:0] forKey:@"vipSelected"];
        
    }
    [self.view makeToastActivity];
    
    [self.muData removeAllObjects];
    __weak typeof(self) weakSelf = self;
    __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("myqueue", NULL);
    // 创建 dispatch 组
    dispatch_group_t group = dispatch_group_create();
    dispatch_async(queue, ^{
        dispatch_group_enter(group);
        [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_orderDetailMes) parameters:params success:^(id  _Nonnull responseObject) {
            // build 接口
            [weakSelf.view hideToastActivity];
            ConfirmAndCreatOrderModel * model = [ConfirmAndCreatOrderModel mj_objectWithKeyValues:responseObject];
            self.confirmAndCreatOrderModel = model;
            if ([model.code isEqualToString:@"0"]) { // 显示内容
                [weakSelf.muData removeAllObjects];
                weakSelf.goodsPrice = model.result.goodsPrice;
                weakSelf.yunfei = model.result.shippingPrice;
                weakSelf.myResultmodel = model.result;
                ConfirmAndCreatOrderManager * modelmanager = [[ConfirmAndCreatOrderManager alloc]init];
                [weakSelf.muData addObjectsFromArray: [modelmanager setConfirmOrderUIModel:model.result]];
                weakSelf.payView.isCanDeliver = model.result.isCanDeliver;
                weakSelf.payView.totalMoney = NSStringFormat(@"￥%.2f",model.result.orderAmount);
                RDLog(@"任务1");
            }else{
                
                [weakSelf.view makeToast:model.msg];
                
                [weakSelf performSelector:@selector(popViewControllerAction) withObject:nil afterDelay:2];
            }
            dispatch_semaphore_signal(sem);
            RDLog(@"");
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(group);
        }];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSMutableArray * goodMuarr = [[NSMutableArray alloc]init];
        for (ConfirmAndCreatOrderliseModel * listmodel in weakSelf.myResultmodel.orderList) {
            for (ConfirmAndCreatOrderGoodsListModel * goodsmodel in listmodel.orderGoodsList) {
                NSDictionary * goodsDic = @{    @"itemId":[NSNumber numberWithInteger:goodsmodel.sku],
                                                @"goodsNum":[NSNumber numberWithInteger:goodsmodel.goodsNum]
                                                };
                [goodMuarr addObject:goodsDic];
            }
        }
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_findDefaultAddress) parameters:@[] success:^(id  _Nonnull responseObject) { // 默认地址
        RDLog(@"任务3"); // 默认地址
        DefaultAddresmodel * defaultAddmodel = [DefaultAddresmodel mj_objectWithKeyValues:responseObject];
        if ([defaultAddmodel.code isEqualToString:@"0"]) {
            weakSelf.defaultaddressmodel = defaultAddmodel.result;
            if (weakSelf.isFirstIn) {
                weakSelf.addressid = weakSelf.defaultaddressmodel.addressId;
            }
        }
        dispatch_group_leave(group);
    } failure:^(NSError * _Nonnull error) {
        RDLog(@"%@",error);
        dispatch_group_leave(group);
    }];
    // 当上面三个请求都结束后，回调此 Block
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"OVER:%@", [NSThread currentThread]);
        if (weakSelf.muData.count) {
            if (weakSelf.defaultaddressmodel.addressId) { // 有地址
                [weakSelf checkIsCanDeliver];
            }else{ // 无地址
                OderCellModel * sectionmodel = [weakSelf.muData objectAtIndex:0];
                OderCellModel * firstmodel = [sectionmodel.modelMuarr objectAtIndex:0];
                if (firstmodel.ordercelltype == ConfirmOrderCellType_NoPeisong) {
                    [sectionmodel.modelMuarr removeObject:firstmodel];
                }
            }
        }
        [weakSelf.mesTable reloadData];
    });
    
}


#pragma mark -- setUI
- (UIButton *)set_leftButton{
    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popViewControllerAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//HYK
- (void)orderGenerationEvent {
    
    HHDAlertView * alert = [[HHDAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alert.confirmTitle = @"继续支付";
    alert.cancelTitle = @"暂时放弃";
    alert.mesStr = @"您的订单已生成，是否选择继续支付";
    alert.rightDismiss = YES;
    __weak typeof(self) weakSelf = self;
    alert.cancelBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    alert.confirmBlock = ^{
    };
    [kWindow addSubview:alert];
    
}

- (void)setUI{
    [self.view addSubview:self.mesTable];
    [self.view addSubview:self.payView];
    [self.mesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.payView.mas_top);
    }];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@49);
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight);
    }];
}
#pragma mark -- tableviewDelegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:section];
    return  sectionmodel.modelMuarr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"_+_________________________%lu",(unsigned long)self.muData.count);
    return self.muData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:indexPath.section];
    OderCellModel * rowsmodel = [sectionmodel.modelMuarr objectAtIndex:indexPath.row];
    NSLog(@"+++++++++++++++++++++++++%lu",(unsigned long)rowsmodel.ordercellHeight);
    return rowsmodel.ordercellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:section];
    if (sectionmodel.ordercelltype == ConfirmOrderCellType_Goods && section == 1) {
        return  sectionmodel.sectionHeight;
    }else if (sectionmodel.ordercelltype == ConfirmOrderCellType_Goods) {
        return 0.01;
    }
    return sectionmodel.sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:section];
    return  sectionmodel.sectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:section];
    UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    footer.backgroundColor = UIColorFromHex(0xEEF1F3);
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:section];
    if (sectionmodel.ordercelltype == ConfirmOrderCellType_Goods && section == 1) {
        BFMallConfirmOrderSectionCell * sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionCellID];
//        if (!sectionHeader) {
//            sectionHeader = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConfirmOrderSectionView class])
//                                                          owner:self
//                                                        options:nil]lastObject];
//        }
//        __weak typeof(self) weakSelf = self;
//        sectionHeader.tapBlock = ^{
//            ShopMainViewController * shopVc =[[ShopMainViewController alloc]init];
//            shopVc.shopID = NSStringFormat(@"%ld",(long)sectionmodel.shopid);
//            [weakSelf.navigationController pushViewController:shopVc animated:YES];
//        };
//        [sectionHeader updateHeaderWithName:sectionmodel.title];
        return sectionHeader;
    }else if (sectionmodel.ordercelltype == ConfirmOrderCellType_Youhui){
        UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8.0)];
        header.backgroundColor = UIColorFromHex(0xEEF1F3);
        return header;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OderCellModel * sectionmodel = [self.muData objectAtIndex:indexPath.section];
    OderCellModel * rowmodel = [sectionmodel.modelMuarr objectAtIndex:indexPath.row];
    __weak typeof(self) weakSelf = self;
    switch (rowmodel.ordercelltype) {
        case ConfirmOrderCellType_NoPeisong: // 物流
        {
            NowuliuCell * wuliucell = [tableView dequeueReusableCellWithIdentifier:wuliucellID];
            if (!wuliucell) {
                wuliucell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([wuliucell class])
                                                          owner:self
                                                        options:nil]lastObject];
            }
            return wuliucell;
        }
            break;
        case ConfirmOrderCellType_TopNoMes: // 地址没有信息
        {
            
            BFMallConfirmOrderTopCell * topCell = [tableView dequeueReusableCellWithIdentifier:topCellID];
            WK(weakSelf)
            topCell.addAddressBlock = ^{
                [weakSelf addressChoiceWithSectionModel:sectionmodel];
            };
            return topCell;
            
            
        }
            break;
        case ConfirmOrderCellType_TopWithMes: // 地址有信息
        {
            
            BFMallConfirmOrderAddressCell * addressCell = [tableView dequeueReusableCellWithIdentifier:addresswithmesCellID];
            [addressCell updateCellMesWithName:rowmodel.personname Phone:rowmodel.personPhone Address:rowmodel.personAddress];
            return addressCell;
        }
            return nil;
            break;
        case ConfirmOrderCellType_Payway: // 支付
        {
            PaywayCell * payCell = [tableView dequeueReusableCellWithIdentifier:paywayCellID];
            if (!payCell) {
                payCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PaywayCell class])
                                                        owner:self
                                                      options:nil]lastObject];
            }
            payCell.payBlock = ^(Payway payway) {
                if (payway == Payway_Wxpay) {
                    RDLog(@"微信支付");
                    weakSelf.payType = Payway_Wxpay;
                }else if (payway == Payway_Alipay){
                    RDLog(@"支付宝支付");
                    weakSelf.payType = Payway_Alipay;
                }else{
                    
                }
            };
            return payCell;
        }
            break;
        case ConfirmOrderCellType_GoodsMes: // 商品信息
        {
            
            BFMallConfirmOrderGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
            [goodsCell updateCellMesWithHeadUrl:rowmodel.goodsHeadImage GoodsName:rowmodel.goodsName GoodsGuige:rowmodel.goodsGuige GoodsPrice:NSStringFormat(@"%@",rowmodel.goodsPrice) GoodsNum:rowmodel.goodsNum GoodsVipPrice:rowmodel.vipPrice];
    
            return goodsCell;
        }
            break;
        case ConfirmOrderCellType_VipChoiceMes:
        {
            BFMallIOrderVipChoiceCell *orderVipCell = [tableView dequeueReusableCellWithIdentifier:vipChoiceCellId];
            WK(weakSelf)
            orderVipCell.vipChoiceBlock = ^(BOOL btnState) {
                weakSelf.isSelecVip = btnState;
                [weakSelf changeDealMes];
            };
            
            [orderVipCell changeState:rowmodel.isVip];
            if (rowmodel.isVip) {
                [orderVipCell updateSavedPrice:[rowmodel.savedMoney floatValue]];
            }else {
                NSString *vipPrce = self.confirmAndCreatOrderModel.result.userVipPrice[@"vipPrice"];
                [orderVipCell updateVipPrice:[vipPrce floatValue] TotalSavedPrice:[rowmodel.savedMoney floatValue]];
            }
            if (self.isSelecVip) {
                orderVipCell.choiceBtn.selected = YES;
            }else {
                orderVipCell.choiceBtn.selected = NO;
            }
            return orderVipCell;
        }

            break;
        case ConfirmOrderCellType_OrderdetailMes: // 订单总信息
        {
            OrderDealMesCell * orderacountCell = [tableView dequeueReusableCellWithIdentifier:orderAcountMesCellID];
            if (!orderacountCell) {
                orderacountCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([orderAcountMesCellID class]) owner:self options:nil]lastObject];
            }
            [orderacountCell updateCellMesWithCellTitle:rowmodel.title CellContent:rowmodel.contentMes ContenColor:[UIColor hexColor:@"#000000"]];
            return orderacountCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OderCellModel * sectionmodel = [self.muData objectAtIndex:indexPath.section];
    OderCellModel * rowmodel = [sectionmodel.modelMuarr objectAtIndex:indexPath.row];
    if (rowmodel.ordercelltype == ConfirmOrderCellType_TopNoMes || rowmodel.ordercelltype == ConfirmOrderCellType_TopWithMes) {
        [self addressChoiceWithSectionModel:sectionmodel];
        
    }else if (rowmodel.ordercelltype == ConfirmOrderCellType_GoodsMes){
        RDLog(@"%ld",(long)rowmodel.goodsid);
        BFMallGoodsDetailController * goodsdetail = [[BFMallGoodsDetailController alloc]init];
        goodsdetail.goodsId = rowmodel.goodsid;
        goodsdetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goodsdetail animated:NO];
    }else{
        
    }
}


#pragma mark -- BtnAction
- (void)payMoney{ // 创建订单
    
    //HYK
    self.isPop = YES;
    //HYK
    RDLog(@"paymoney");
    __block  BOOL noChange = YES; // 价格没有发生变化
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary * buildparams = [[NSMutableDictionary alloc]init];
    [buildparams setValue:[NSNumber numberWithInt:_ordertype] forKey:key_ordertype];
    [buildparams setValue:[NSNumber numberWithInt:_buytype] forKey:key_buyType];
    [buildparams setValue:[NSNumber numberWithInteger:_sku] forKey:key_sku];
    [buildparams setValue:[NSNumber numberWithInteger:_quantity] forKey:key_quantity];
    if (_addressid) {
        [buildparams setValue:[NSNumber numberWithInteger:_addressid] forKey:key_addressId];
    }
    [buildparams setValue:[NSNumber numberWithInteger:_couponId] forKey:key_couponId];
    [buildparams setValue:[NSNumber numberWithInteger:_useCoin] forKey:key_useCoin];
    [buildparams setValue:[NSNumber numberWithInteger:_foundId] forKey:key_foundId];
    [buildparams setValue:[NSNumber numberWithInteger:_activityId] forKey:key_activityId];
    if (self.isSelecVip) {
        [buildparams setValue:[NSNumber numberWithInteger:1] forKey:@"vipSelected"];
        
    }else {
        [buildparams setValue:[NSNumber numberWithInteger:0] forKey:@"vipSelected"];
        
    }
    
    [self.view makeToastActivity];
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_orderDetailMes) parameters:buildparams success:^(id  _Nonnull responseObject) {// build 接口
        [weakSelf.view hideToastActivity];
        ConfirmAndCreatOrderModel * model = [ConfirmAndCreatOrderModel mj_objectWithKeyValues:responseObject];
        self.confirmAndCreatOrderModel = model;
        if ([model.code isEqualToString:@"0"]) { // 显示内容
            if (weakSelf.goodsPrice == model.result.goodsPrice && weakSelf.yunfei == model.result.shippingPrice) {
                noChange = YES;
            }else{
                noChange = NO;
            }
        }else{
        }
        RDLog(@"");
        dispatch_group_leave(group);
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(group);
    }];
    
    // 当上面三个请求都结束后，回调此 Block
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"OVER:%@", [NSThread currentThread]);
        if (noChange) {
            [weakSelf creatOrder];
        }else{
            HHDAlertView * hhdAlert = [[HHDAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            hhdAlert.mesStr = @"订单信息已发生变化，\n是否继续支付？";
            hhdAlert.confirmTitle = @"支付";
            hhdAlert.confirmBlock = ^{
                [weakSelf creatOrder];
            };
            [kWindow addSubview:hhdAlert];
        }
    });
}



- (void)creatOrder{ // 创建订单
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:_ordertype] forKey:key_ordertype];
    [params setValue:[NSNumber numberWithInt:_buytype] forKey:key_buyType];
    [params setValue:[NSNumber numberWithInteger:_sku] forKey:key_sku];
    [params setValue:[NSNumber numberWithInteger:_quantity] forKey:key_quantity];
    if (_addressid) {
        [params setValue:[NSNumber numberWithInteger:_addressid] forKey:key_addressId];
    }
    [params setValue:[NSNumber numberWithInteger:_couponId] forKey:key_couponId];
    [params setValue:[NSNumber numberWithInteger:_useCoin] forKey:key_useCoin];
    [params setValue:[NSNumber numberWithInteger:_foundId] forKey:key_foundId];
    [params setValue:[NSNumber numberWithInteger:_activityId] forKey:key_activityId];
    [params setValue:[NSNumber numberWithInt:self.payType] forKey:@"paymentMethod"];
    __weak typeof(self) weakSelf = self;
    [self.view makeToastActivity];
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_createOrder) parameters:params success:^(id  _Nonnull responseObject) {
        [weakSelf.view hideToastActivity];
        ConfirmAndCreatOrderModel * model = [ConfirmAndCreatOrderModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:@"0"]) {
            if (model.result.orderAmount) { // 价格不为0
                
                [self payWithModel:model];
                
            }
//            else{ // 价格为0
//
//                    PaySuccessController * paysuccessl = [[PaySuccessController alloc]init];
//                    [paysuccessl updateMesWith:@"金豆支付" PayPrice:NSStringFormat(@"￥%.2f",model.result.orderAmount)];
//                    paysuccessl.parentOrderSign = NSStringFormat(@"%ld",(long)model.result.orderId);
//                    if (model.result.orderList.count == 1) { // 单店铺
//                        ConfirmAndCreatOrderliseModel *shopmodel = [model.result.orderList objectAtIndex:0];
//                        paysuccessl.sonOrderSign = NSStringFormat(@"%ld",(long)shopmodel.orderId);
//                    }else{
//                        paysuccessl.isUnpack = YES;
//                    }
//                    [self.navigationController pushViewController:paysuccessl animated:YES];
//                }
            
            RDLog(@"%ld",(long)model.result.orderSn);
        }else{
            [weakSelf.view makeToast:model.msg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)checkIsCanDeliver{  // 有地址 查看是否可以配送
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:_ordertype] forKey:key_ordertype];
    [params setValue:[NSNumber numberWithInt:_buytype] forKey:key_buyType];
    [params setValue:[NSNumber numberWithInteger:_sku] forKey:key_sku];
    [params setValue:[NSNumber numberWithInteger:_quantity] forKey:key_quantity];
    if (_addressid) {
        [params setValue:[NSNumber numberWithInteger:_addressid] forKey:key_addressId];
    }
    [params setValue:[NSNumber numberWithInteger:_couponId] forKey:key_couponId];
    [params setValue:[NSNumber numberWithInteger:_useCoin] forKey:key_useCoin];
    [params setValue:[NSNumber numberWithInteger:_foundId] forKey:key_foundId];
    [params setValue:[NSNumber numberWithInteger:_activityId] forKey:key_activityId];
    if (self.isSelecVip) {
        [params setValue:[NSNumber numberWithInteger:1] forKey:@"vipSelected"];
        
    }else {
        [params setValue:[NSNumber numberWithInteger:0] forKey:@"vipSelected"];
        
    }
    [self.view makeToastActivity];
    __weak typeof(self) weakSelf = self;
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_orderDetailMes) parameters:params success:^(id  _Nonnull responseObject) {
        [weakSelf.view hideToastActivity];
        ConfirmAndCreatOrderModel * model = [ConfirmAndCreatOrderModel mj_objectWithKeyValues:responseObject];
        self.confirmAndCreatOrderModel = model;
        if ([model.code isEqualToString:@"0"]) {
            RDLog(@"是否可配送%ld",(long)model.result.isCanDeliver);
            weakSelf.payView.isCanDeliver = model.result.isCanDeliver;
            weakSelf.goodsPrice = model.result.goodsPrice;
            weakSelf.yunfei = model.result.shippingPrice;
            weakSelf.payView.totalMoney = NSStringFormat(@"￥%.2f",model.result.orderAmount);
            RDLog(@"任务1");
            if (model.result.isCanDeliver) { // 可配送
                OderCellModel * sectionmodel = [weakSelf.muData objectAtIndex:0];
                OderCellModel * firstmodel = [sectionmodel.modelMuarr objectAtIndex:0];
                if (firstmodel.ordercelltype == ConfirmOrderCellType_NoPeisong) {
                    [sectionmodel.modelMuarr removeObject:firstmodel];
                }
                if (weakSelf.isFirstIn) { // 首次进入
                    for (OderCellModel * cellmodel in sectionmodel.modelMuarr) {
                        if (cellmodel.ordercelltype == ConfirmOrderCellType_TopNoMes || cellmodel.ordercelltype == ConfirmOrderCellType_TopWithMes) {
                            cellmodel.ordercelltype = ConfirmOrderCellType_TopWithMes;
                            cellmodel.personPhone = weakSelf.defaultaddressmodel.mobile;
                            cellmodel.personname = weakSelf.defaultaddressmodel.consignee;
                            NSString *address = NSStringFormat(@"%@%@%@%@",weakSelf.defaultaddressmodel.provinceName,weakSelf.defaultaddressmodel.cityName, weakSelf.defaultaddressmodel.districtName, weakSelf.defaultaddressmodel.address);
                            cellmodel.personAddress = address;
                            cellmodel.ordercellHeight = 80.f;
                        }
                    }
                }
                
            }else{ // 不可配送
                OderCellModel * sectionmodel = [weakSelf.muData objectAtIndex:0];
                OderCellModel * firstmodel = [sectionmodel.modelMuarr objectAtIndex:0];
                if (firstmodel.ordercelltype != ConfirmOrderCellType_NoPeisong) {
                    OderCellModel * nopeisongmodel = [[OderCellModel alloc]init];
                    nopeisongmodel.ordercelltype = ConfirmOrderCellType_NoPeisong;
                    nopeisongmodel.ordercellHeight = 20.f;
                    [sectionmodel.modelMuarr insertObject:nopeisongmodel atIndex:0];
                }
                if (weakSelf.isFirstIn) {
                    for (OderCellModel * cellmodel in sectionmodel.modelMuarr) {
                        if (cellmodel.ordercelltype == ConfirmOrderCellType_TopNoMes || cellmodel.ordercelltype == ConfirmOrderCellType_TopWithMes) {
                            cellmodel.ordercelltype = ConfirmOrderCellType_TopWithMes;
                            cellmodel.personPhone = weakSelf.defaultaddressmodel.mobile;
                            cellmodel.personname = weakSelf.defaultaddressmodel.consignee;
                            cellmodel.personAddress = weakSelf.defaultaddressmodel.address;
                            cellmodel.ordercellHeight = 80.f;
                            break;
                        }
                    }
                }
            }
            
            for (OderCellModel * sectionModel in weakSelf.muData) { // 商品信息更换运费
                if (sectionModel.ordercelltype == ConfirmOrderCellType_Goods) {
                    [model.result.orderList enumerateObjectsUsingBlock:^(ConfirmAndCreatOrderliseModel *listmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                        
//                        if (sectionModel.shopid == listmodel.shopId) {
//                            sectionModel.yunfei = listmodel.shippingPrice;
//                        }
//                        if (sectionModel.yunfei) {
//                            sectionModel.sectionFooterHeight = 80.f;
//                        }else{
//                            sectionModel.sectionFooterHeight = 40.f;
//                        }
//                        if (self.ordertype == OrderType_Pintuan) {
                            sectionModel.sectionFooterHeight = 10.f;
//                        }
        
                    }];
                }
                
                if (sectionModel.ordercelltype == ConfirmOrderCellType_OrderMes) { // 结算部分更新信息
                    [sectionModel.modelMuarr removeAllObjects];
                    
                    OderCellModel * jiesuanOrderPricemodel = [[OderCellModel alloc]init];
                    jiesuanOrderPricemodel.ordercellHeight = 32.5;
                    jiesuanOrderPricemodel.ordercelltype =ConfirmOrderCellType_OrderdetailMes;
                    jiesuanOrderPricemodel.title = @"商品价格";
                    jiesuanOrderPricemodel.contentMes = NSStringFormat(@"+￥%.2f",model.result.goodsPrice);
                    [sectionModel.modelMuarr addObject:jiesuanOrderPricemodel];
                    
                    if (model.result.isVipUser) {
                        
                        OderCellModel * jiesuanVipHaveSavedPrice = [[OderCellModel alloc]init];
                        jiesuanVipHaveSavedPrice.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                        jiesuanVipHaveSavedPrice.ordercellHeight = 32.5;
                        jiesuanVipHaveSavedPrice.title = @"会员立减";
                        jiesuanVipHaveSavedPrice.contentMes = NSStringFormat(@"-￥%.2f",model.result.savePrice);
                        [sectionModel.modelMuarr addObject:jiesuanVipHaveSavedPrice];
                        
                    }else {
                        if (self.isSelecVip) {
                            
                            OderCellModel * jiesuanVipPrice = [[OderCellModel alloc]init];
                            jiesuanVipPrice.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                            jiesuanVipPrice.ordercellHeight = 32.5;
                            jiesuanVipPrice.title = @"开通会员";
                            jiesuanVipPrice.contentMes = NSStringFormat(@"+￥%@",model.result.userVipPrice[@"vipPrice"]);
                            [sectionModel.modelMuarr addObject:jiesuanVipPrice];
                            
                            
                            OderCellModel * jiesuanVipSavedPrice = [[OderCellModel alloc]init];
                            jiesuanVipSavedPrice.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                            jiesuanVipSavedPrice.ordercellHeight = 32.5;
                            jiesuanVipSavedPrice.title = @"会员立减";
                            jiesuanVipSavedPrice.contentMes = NSStringFormat(@"-￥%.2f",model.result.savePrice);
                            [sectionModel.modelMuarr addObject:jiesuanVipSavedPrice];
                            
                        }
                    }
                    
                    OderCellModel * jiesuanhouhuiyunfei = [[OderCellModel alloc]init];
                    jiesuanhouhuiyunfei.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                    jiesuanhouhuiyunfei.ordercellHeight = 32.5;
                    jiesuanhouhuiyunfei.title = @"运费";
                    jiesuanhouhuiyunfei.contentMes = NSStringFormat(@"￥%.2f",model.result.shippingPrice);
                    [sectionModel.modelMuarr addObject:jiesuanhouhuiyunfei];
                    
                }
                
                if (sectionModel.ordercelltype == ConfirmOrderCellType_Youhui) {
                    for (OderCellModel * rowmodel in sectionModel.modelMuarr) {
                        if (rowmodel.ordercelltype == ConfirmOrderCellType_YouhuiJindou) {
                            if (model.result.userCoin > 100000) {
                                rowmodel.contentMes = NSStringFormat(@"共%ld.%ld万,可抵￥%.2f",(long)model.result.userCoin/10000,model.result.userCoin%10000,model.result.userCoinPrice);
                            }else{
                                rowmodel.contentMes = NSStringFormat(@"共%ld,可抵￥%.2f",(long)model.result.userCoin,model.result.userCoinPrice);
                            }
                        }
                    }
                }
            }
            
            [weakSelf.mesTable reloadData];
        }else{
            [weakSelf.view makeToast:model.msg];
        }
        RDLog(@"");
    } failure:^(NSError * _Nonnull error) {
    }];
    
}

- (void)addressChoiceWithSectionModel:(OderCellModel *)sectionmodel {
    
    ConsigneeAddressController * addressController = [[ConsigneeAddressController alloc]init];
    [self.navigationController pushViewController:addressController animated:YES];
    __weak typeof(self) weakSelf = self;
    addressController.selectedBlock = ^(AddressListModel *addressmodel) {
        weakSelf.isFirstIn = NO;
        for (OderCellModel * model in sectionmodel.modelMuarr) {
            if (model.ordercelltype == ConfirmOrderCellType_TopNoMes || model.ordercelltype == ConfirmOrderCellType_TopWithMes) {
                model.ordercelltype = ConfirmOrderCellType_TopWithMes;
                model.personPhone = addressmodel.mobile;
                model.personname = addressmodel.consignee;
                model.personAddress = NSStringFormat(@"%@%@%@%@",addressmodel.provinceName,addressmodel.cityName,addressmodel.districtName,addressmodel.address);
                weakSelf.addressid = addressmodel.addressId;
                model.ordercellHeight = 80.f;
                break;
            }
        }
        [weakSelf.mesTable reloadData];
        [weakSelf checkIsCanDeliver];
    };
    
}

//HYK
// 替换  去支付
- (void)payWithModel:(ConfirmAndCreatOrderModel *)model{
    
    self.payParam.parentorderid = NSStringFormat(@"%ld",(long)model.result.orderId);
    if (model.result.orderList.count == 1) { // 单店铺
        ConfirmAndCreatOrderliseModel *shopmodel = [model.result.orderList objectAtIndex:0];
        self.payParam.sonOrderSign = NSStringFormat(@"%ld",(long)shopmodel.orderId);
        self.payParam.groupid = shopmodel.orderPromId;
    }
    if (model.result.orderList.count > 1) {
        self.payParam.isUnpack = YES;
    }else{
        self.payParam.isUnpack = NO;
    }
    self.payParam.ordersign = model.result.orderSn;
    self.payParam.payway = self.payType;
    self.payParam.totoalmoney = model.result.orderAmount;
    self.payParam.goodsid = self.goodsid;
    self.payParam.ordertype = self.ordertype;
    [self enterOrderDetailByWaitType];
    if (self.payParam.totoalmoney > 0) {
        BasePayViewController * payvc = [[BasePayViewController alloc]init];
        // 1微信、2支付宝
        if (self.payParam.payway == Payway_Wxpay) {
            [self payWithOrderNo:NSStringFormat(@"%@", self.payParam.ordersign) paymentMethod:@"1"];
        }else{
            [self payWithOrderNo:NSStringFormat(@"%@",self.payParam.ordersign) paymentMethod:@"2"];
        }
    }
//    else{
//
//            PaySuccessController * paysuccessl = [[PaySuccessController alloc]init];
//            if (self.payParam.payway == Payway_Wxpay) {
//                [paysuccessl updateMesWith:@"微信支付" PayPrice:NSStringFormat(@"￥%.2f",self.payParam.totoalmoney)];
//            }else{
//                [paysuccessl updateMesWith:@"支付宝支付" PayPrice:NSStringFormat(@"￥%.2f",self.payParam.totoalmoney)];
//            }
//            paysuccessl.isUnpack = self.payParam.isUnpack;
//            paysuccessl.parentOrderSign = self.payParam.parentorderid;
//            paysuccessl.sonOrderSign = self.payParam.sonOrderSign;
//            [self.navigationController pushViewController:paysuccessl animated:YES];
//
//    }
}

- (void)enterOrderDetailByWaitType{
    
    MyOrderDetailController * orderdetail = [[MyOrderDetailController alloc]init];
    [orderdetail updateOrderDetailMesWithParentOrderID:[self.payParam.parentorderid integerValue]
                                            SonOrderID:[self.payParam.sonOrderSign integerValue]
                                             OrderType:self.payParam.ordertype
                                           OrderStatus:OrderStatus_WaitPay];
    orderdetail.hidesBottomBarWhenPushed = YES;
    NSMutableArray *viewCtrs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    NSInteger index = [viewCtrs indexOfObject:self];
    [viewCtrs replaceObjectAtIndex:index withObject:orderdetail];
    [self.navigationController setViewControllers:viewCtrs animated:NO];
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)changeDealMes {
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:self.ordertype] forKey:key_ordertype];
    [params setValue:[NSNumber numberWithInt:self.buytype] forKey:key_buyType];
    [params setValue:[NSNumber numberWithInteger:self.sku] forKey:key_sku];
    [params setValue:[NSNumber numberWithInteger:self.quantity] forKey:key_quantity];
    if (self.addressid) {
        [params setValue:[NSNumber numberWithInteger:self.addressid] forKey:key_addressId];
    }
    [params setValue:[NSNumber numberWithInteger:self.couponId] forKey:key_couponId];
    [params setValue:[NSNumber numberWithInteger:self.useCoin] forKey:key_useCoin];
    [params setValue:[NSNumber numberWithInteger:self.foundId] forKey:key_foundId];
    [params setValue:[NSNumber numberWithInteger:self.activityId] forKey:key_activityId];
    if (self.isSelecVip) {
        [params setValue:[NSNumber numberWithInteger:1] forKey:@"vipSelected"];

    }else {
        [params setValue:[NSNumber numberWithInteger:0] forKey:@"vipSelected"];

    }
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_orderDetailMes) parameters:params success:^(id  _Nonnull responseObject) {
            // build 接口
            ConfirmAndCreatOrderModel * model = [ConfirmAndCreatOrderModel mj_objectWithKeyValues:responseObject];
            self.confirmAndCreatOrderModel = model;
            if ([model.code isEqualToString:@"0"]) { // 显示内容
                self.payView.isCanDeliver = model.result.isCanDeliver;
                self.payView.totalMoney = NSStringFormat(@"￥%.2f",model.result.orderAmount);
            }
            RDLog(@"");
        } failure:^(NSError * _Nonnull error) {
        }];
    for (OderCellModel * sectionModel in self.muData) { // 商品信息更换运费
        
        if (sectionModel.ordercelltype == ConfirmOrderCellType_OrderMes) { // 结算部分更新信息
            [sectionModel.modelMuarr removeAllObjects];
            
            OderCellModel * jiesuanOrderPricemodel = [[OderCellModel alloc]init];
            jiesuanOrderPricemodel.ordercellHeight = 32.5;
            jiesuanOrderPricemodel.ordercelltype =ConfirmOrderCellType_OrderdetailMes;
            jiesuanOrderPricemodel.title = @"商品价格";
            jiesuanOrderPricemodel.contentMes = NSStringFormat(@"+￥%.2f",self.confirmAndCreatOrderModel.result.goodsPrice);
            [sectionModel.modelMuarr addObject:jiesuanOrderPricemodel];
            
            if (self.confirmAndCreatOrderModel.result.isVipUser) {
                
                OderCellModel * jiesuanVipHaveSavedPrice = [[OderCellModel alloc]init];
                jiesuanVipHaveSavedPrice.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                jiesuanVipHaveSavedPrice.ordercellHeight = 32.5;
                jiesuanVipHaveSavedPrice.title = @"会员立减";
                jiesuanVipHaveSavedPrice.contentMes = NSStringFormat(@"-￥%.2f",self.confirmAndCreatOrderModel.result.savePrice);
                [sectionModel.modelMuarr addObject:jiesuanVipHaveSavedPrice];

                
            }else {
                if (self.isSelecVip) {
                    
                    OderCellModel * jiesuanVipPrice = [[OderCellModel alloc]init];
                    jiesuanVipPrice.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                    jiesuanVipPrice.ordercellHeight = 32.5;
                    jiesuanVipPrice.title = @"开通会员";
                    jiesuanVipPrice.contentMes = NSStringFormat(@"+￥%@",self.confirmAndCreatOrderModel.result.userVipPrice[@"vipPrice"]);
                    [sectionModel.modelMuarr addObject:jiesuanVipPrice];
                    
                    
                    OderCellModel * jiesuanVipSavedPrice = [[OderCellModel alloc]init];
                    jiesuanVipSavedPrice.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
                    jiesuanVipSavedPrice.ordercellHeight = 32.5;
                    jiesuanVipSavedPrice.title = @"会员立减";
                    jiesuanVipSavedPrice.contentMes = NSStringFormat(@"-￥%.2f",self.confirmAndCreatOrderModel.result.savePrice);
                    [sectionModel.modelMuarr addObject:jiesuanVipSavedPrice];
                    
                }
            }
            
            OderCellModel * jiesuanhouhuiyunfei = [[OderCellModel alloc]init];
            jiesuanhouhuiyunfei.ordercelltype = ConfirmOrderCellType_OrderdetailMes;
            jiesuanhouhuiyunfei.ordercellHeight = 32.5;
            jiesuanhouhuiyunfei.title = @"运费";
            jiesuanhouhuiyunfei.contentMes = NSStringFormat(@"￥%.2f",self.confirmAndCreatOrderModel.result.shippingPrice);
            [sectionModel.modelMuarr addObject:jiesuanhouhuiyunfei];
        }
    }
    [self.mesTable reloadData];
    
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

//HYK

- (void)commitOrderMessWith:(OrderType)ordertype BuyType:(BuyType)buytype Sku:(NSInteger)sku Quantity:(NSInteger)quantity Grouponid:(NSInteger)grouponid Address:(NSString *)goodsaddress UseCoin:(BOOL)usecoin Foundid:(NSInteger)foundid Activityid:(NSInteger)activity GoodsID:(NSInteger)goodsid{
    
    self.ordertype = ordertype;
    self.buytype = buytype;
    self.sku = sku;
    self.quantity = quantity;
    self.addressid = 0;
    self.couponId = grouponid;
    self.useCoin = usecoin;
    self.foundId = foundid;
    self.activityId = activity;
    self.goodsid = goodsid;
}

@end
