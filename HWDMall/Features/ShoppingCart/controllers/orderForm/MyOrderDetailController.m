//
//  MyOrderDetailController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "MyOrderDetailController.h"
#import "OrderDetailTopOneLineCell.h" // top 一行信息
#import "OrderDetailWuliuCell.h" // 物流信息
#import "OrderDetailTopOneLineWithtimedownCell.h" // top 一行 倒计时
#import "OrderDetailTopTwoLineCell.h" // 两行 倒计时
#import "BFMallOrderDetailTopTwoLineCell.h"

#import "OrderDetailGoodsMesCell.h" // 商品信息
#import "BFMallConfirmOrderGoodsCell.h" //商品信息

#import "OrderListMesCell.h" // 订单信息
#import "OrderDealMesCell.h" // 结算信息
#import "OrderPayCountCell.h" // 付款


#import "BFMallConfirmOrderSectionCell.h"

#import "OrderCellHeaderView.h" // 商品信息 -- 组头 （店铺名字）
#import "ConfirmOrderTopWithMesCell.h" // 地址信息
#import "BFMallConfirmOrderAddressCell.h" // 地址信息
#import "OrderBottomThreeBtnView.h"
#import "OrderBottomTwoBtnView.h"
#import "OrderBottomOneBtnView.h"
#import "OrderDetaiModel.h"
#import "OrderDetailManager.h"
#import "OrderdetailCellModel.h" // cell类型
#import "SelectPayWayView.h"
#import "CancelReasonView.h"
// 商品详情
#import "BFMallGoodsDetailController.h"

#import "ConfirmOrderViewGoodsFootderView.h" // 商品组footer
//#import "BargainLogisticsController.h" // 物流
#import "WuliuListViewController.h" // 物流列表
#import "PaySuccessController.h" // 支付成功
#import "BFMallPayResultController.h"
#import "GoodOneMesFooter.h" // 无运费脚视图

static NSString * const toponelinecellID = @"TOPONELINECELLID";
static NSString * const wulilucellID = @"WULIUCELLID";
static NSString * const toponelinewithtimedowncellID = @"TOPONELINWITHTIMEDOWNCELLID";
static NSString * const twolinecellID = @"TWOLINECELLID";
static NSString * const goodmescellID = @"GOODSMESCELLID";
static NSString * const listmescellID = @"LISTMESCELLID";
static NSString * const dealmescellID = @"DEALMESCELLID";
static NSString * const paycoutcellID = @"PAYCOUNTCELLID";
static NSString * const groupbuycellID = @"GROUPBUYCELLID";
static NSString * const cellheaderID = @"CELLHEADERID";
static NSString * const addresscellID = @"ADDRESSCELLID";
static NSString * const goodsmoreshopFooterID = @"MORESHOPGOODSFOOTER";
static NSString * const goodsNoYunfeiFooterID = @"NOYUNFEIFOOTERID";

#define key_parentOrderId @"parentOrderId"
#define key_sonOrderId @"sonOrderId"

@interface MyOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * orderTable;
@property (nonatomic,strong) OrderBottomThreeBtnView *threeBtnView;
@property (nonatomic,strong) OrderBottomTwoBtnView *twoBtnView;
@property (nonatomic,strong) OrderBottomOneBtnView *oneBtnView;
@property (nonatomic,strong) NSMutableArray * orderdetailMuarr; // UI排版数组
@property (nonatomic,strong) OrderDetaiModel * mydetailmodel;
@property (nonatomic,assign) NSInteger parentID;
@property (nonatomic,assign) NSInteger sonID;
@property (nonatomic,assign) OrderType orderType;
@property (nonatomic,assign) CGFloat totalPrice; // 总额
@property (nonatomic,assign) OrderStatus orderStatus;
@property (nonatomic,strong) TimedownModel *timedownmodel;
@property (nonatomic,strong) UIButton * closeBtn; // 全部关闭

@end

@implementation MyOrderDetailController

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

- (NSMutableArray *)orderdetailMuarr{
    if (!_orderdetailMuarr) {
        _orderdetailMuarr = [[NSMutableArray alloc]init];
    }
    return _orderdetailMuarr;
}

- (OrderBottomOneBtnView *)oneBtnView{
    if (!_oneBtnView) {
        _oneBtnView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderBottomOneBtnView class])
                                                    owner:self
                                                  options:nil]lastObject];
    }
    return _oneBtnView;
}

- (OrderBottomTwoBtnView *)twoBtnView{
    if (!_twoBtnView) {
        _twoBtnView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderBottomTwoBtnView class])
                                                    owner:self
                                                  options:nil]lastObject];
    }
    return _twoBtnView;
}

- (OrderBottomThreeBtnView *)threeBtnView{
    if (!_threeBtnView) {
        _threeBtnView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderBottomThreeBtnView class])
                                                      owner:self
                                                    options:nil]lastObject];
    }
    return _threeBtnView;
}

- (UITableView *)orderTable{
    if (!_orderTable) {
        _orderTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _orderTable.delegate = self;
        _orderTable.dataSource = self;
        _orderTable.tableFooterView = [UIView new];
        _orderTable.backgroundColor = [UIColor whiteColor];
        _orderTable.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailTopOneLineCell class]) bundle:nil] forCellReuseIdentifier:toponelinecellID];
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailWuliuCell class]) bundle:nil] forCellReuseIdentifier:wulilucellID];
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailTopOneLineWithtimedownCell class]) bundle:nil] forCellReuseIdentifier:toponelinewithtimedowncellID];
        [_orderTable registerClass:[BFMallOrderDetailTopTwoLineCell class] forCellReuseIdentifier:twolinecellID];
//        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailTopTwoLineCell class]) bundle:nil] forCellReuseIdentifier:twolinecellID];
        
        
        [_orderTable registerClass:[BFMallConfirmOrderGoodsCell class] forCellReuseIdentifier:goodmescellID];
//        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailGoodsMesCell class]) bundle:nil] forCellReuseIdentifier:goodmescellID];
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderListMesCell class]) bundle:nil] forCellReuseIdentifier:listmescellID];
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDealMesCell class]) bundle:nil] forCellReuseIdentifier:dealmescellID];
        
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderPayCountCell class]) bundle:nil
                                  ] forCellReuseIdentifier: paycoutcellID];
        
        [_orderTable registerClass:[BFMallConfirmOrderAddressCell class] forCellReuseIdentifier:addresscellID];
//        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([ConfirmOrderTopWithMesCell class]) bundle:nil] forCellReuseIdentifier:addresscellID]; // 地址
        
        [_orderTable registerClass:[BFMallConfirmOrderSectionCell class] forHeaderFooterViewReuseIdentifier:cellheaderID];
//        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCellHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:cellheaderID]; // 分组头视图
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([ConfirmOrderViewGoodsFootderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:goodsmoreshopFooterID];
        [_orderTable registerNib:[UINib nibWithNibName:NSStringFromClass([GoodOneMesFooter class]) bundle:nil] forHeaderFooterViewReuseIdentifier:goodsNoYunfeiFooterID];
    }
    return _orderTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"订单详情"]];
    [self setNav];
    [self setUI];
    [self setData];
    self.hideSlideRecognizer = NO; //是否禁用滑动手势
    // 启动倒计时管理
    self.timedownmodel = [[TimedownModel alloc]init];
    self.timedownmodel.timedownSourceName = NSStringFromClass([self class]);
    [kCountDownManager start];
    [kCountDownManager addSourceWithIdentifier:self.timedownmodel.timedownSourceName];
}

#pragma mark -- setUI

- (void)setUI{
    [self.view addSubview:self.orderTable];
    [self.orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-kSafeAreaBottomHeight - 49);
    }];
}

- (void)updaUI{
    
    for (UIView * contentview in self.view.subviews) {
        if ([contentview isEqual:self.oneBtnView] || [contentview isEqual:self.threeBtnView] || [contentview isEqual:self.twoBtnView] ) {
            [contentview removeFromSuperview];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    switch (_orderStatus) {
        case OrderStatus_Closed:
        {
            [self.view addSubview:self.oneBtnView]; // 订单结束  联系客服
            if (self.mydetailmodel.result.cart.count > 1) {
                self.oneBtnView.hidden = YES;
                [self.oneBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.height.equalTo(CGFLOAT_MIN);
                    make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
                    
                }];
                [self.orderTable mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(self.view);
                    make.bottom.equalTo(self.view.bottom).offset(-kSafeAreaBottomHeight);
                }];
            }else{
                self.oneBtnView.hidden = NO;
                [self.oneBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.height.equalTo(49);
                    make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
                }];
            }
            self.oneBtnView.btnBlock = ^{
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
        
            };
        }
            break;
        case OrderStatus_WaitPay:
        {
            [self.view addSubview:self.threeBtnView];
            [self.threeBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.equalTo(49);
                make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
            }];
            [self.threeBtnView updataMesWithLeftTitle:@"联系客服" MidTitle:@"取消订单" RightTitle:@"去付款"];
            self.threeBtnView.leftBtn.hidden = YES;
//            if (self.mydetailmodel.result.cart.count > 1) {
//                self.threeBtnView.leftBtn.hidden = YES;
//            }else{
//                self.threeBtnView.leftBtn.hidden = NO;
//            }
            self.threeBtnView.leftBtnBlock = ^{
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
        
            };
            self.threeBtnView.midBtnBlock = ^{
                RDLog(@"取消订单");
                    CancelReasonView * cancelOrdeViewl = [[CancelReasonView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    [kWindow addSubview:cancelOrdeViewl];
                    cancelOrdeViewl.cancelBlock = ^(NSString *reasonStr) {
                        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                        [params setValue:reasonStr forKey:@"reason"];
                        [params setValue:[NSNumber numberWithInteger:weakSelf.parentID] forKey:@"parentOrderId"];
                        if (weakSelf.sonID) {
                             [params setValue:[NSNumber numberWithInteger:weakSelf.sonID] forKey:@"sonOrderId"];
                        }
                        [weakSelf.view makeToastActivity];
                        [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_cancelOrder) parameters:params success:^(id  _Nonnull responseObject) {
                            [weakSelf.view hideToastActivity];
                            if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
                                [weakSelf setData];
                                [[NSNotificationCenter defaultCenter]postNotificationName:ResetOrderListPostName object:nil];
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }else{
                                
                                [weakSelf.view makeToast:[responseObject objectForKey:@"msg"]];
                            }
                        } failure:^(NSError * _Nonnull error) {
                            [weakSelf.view hideToastActivity];
                        }];
                    };
                
            };
            self.threeBtnView.rightBtnBlock = ^{
                SelectPayWayView *payview = [[SelectPayWayView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [payview bindPrice:weakSelf.totalPrice];
                [kWindow addSubview:payview];
                payview.payBlock = ^(Payway payway) { // 1 微信  2 支付宝
                    if (payway == Payway_Alipay) {
                        [weakSelf payWithOrderNo:weakSelf.orderSign paymentMethod:@"2"];
                    }else{
                        [weakSelf payWithOrderNo:weakSelf.orderSign paymentMethod:@"1"];
                    }
                    
                };
            };
        }
            break;
        case OrderStatus_Finished: // 已完成
        {
            [self.view addSubview:self.oneBtnView];
            [self.oneBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.equalTo(49);
                make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
            }];
            
            self.oneBtnView.btnBlock = ^{
               // 客服
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
            
            };
            
        }
            break;
        case OrderStatus_WaitSend: // 待发货
        {
            [self.view addSubview:self.oneBtnView];
            [self.oneBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.equalTo(49);
                make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
            }];
            
            self.oneBtnView.btnBlock = ^{
                // 客服
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
               
            };
        }
            
            break;
        case OrderStatus_WaitShar: // 待分享
        {
            [self.view addSubview:self.threeBtnView];
            [self.threeBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.equalTo(49);
                make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
            }];
            [self.threeBtnView updataMesWithLeftTitle:@"联系客服" MidTitle:@"取消订单" RightTitle:@"邀请好友拼单"];
            self.threeBtnView.leftBtnBlock = ^{
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
               
            };
            self.threeBtnView.midBtnBlock = ^{
                RDLog(@"取消订单");
                if (weakSelf.orderType == OrderType_Pintuan) {
                    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
                    BFMallOrderDetailTopTwoLineCell * twomesCell = (BFMallOrderDetailTopTwoLineCell *)[weakSelf.orderTable cellForRowAtIndexPath:path];
                    NSArray * timeArr = [twomesCell.timeDownLbl.text componentsSeparatedByString:@"："];
                    NSString * timeStr = NSStringFormat(@"%@",[timeArr objectAtIndex:1]);
                    [weakSelf.view makeToast:[NSString stringWithFormat:@"%@时间拼单未成功,订单自动取消",timeStr]];
                }else{
                CancelReasonView * cancelOrdeViewl = [[CancelReasonView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [kWindow addSubview:cancelOrdeViewl];
                cancelOrdeViewl.cancelBlock = ^(NSString *reasonStr) {
                    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                    [params setValue:reasonStr forKey:@"reason"];
                    [params setValue:[NSNumber numberWithInteger:weakSelf.parentID] forKey:@"parentOrderId"];
                    
                    [params setValue:[NSNumber numberWithInteger:weakSelf.sonID] forKey:@"sonOrderId"];
                    [weakSelf.view makeToastActivity];
                    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_cancelOrder) parameters:params success:^(id  _Nonnull responseObject) {
                        [weakSelf.view hideToastActivity];
                        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
                            [weakSelf setData];
                        }else{
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                            [weakSelf.view makeToast:[responseObject objectForKey:@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        [weakSelf.view hideToastActivity];
                    }];
                };
        }
            };
            OrderDetaiCartModel * cartmodel = [self.mydetailmodel.result.cart objectAtIndex:0];
            OrderDetaiGoodsModel * goodmodel = [cartmodel.goods objectAtIndex:0];
            self.threeBtnView.rightBtnBlock = ^{
                if ([WXApi isWXAppInstalled]) {
                    NSData *data = [NSData dataWithContentsOfURL:URL_STR(goodmodel.goodsThumb)];
                    UIImage *image = [UIImage imageWithData:data];
                    NSData *imgData = [HHDCommonUtil zipImageToData:image];
                    NSString * title = NSStringFormat(@"【仅剩1个名额】%.2f元拼（%@)",goodmodel.finalPrice,goodmodel.goodsName);
                    NSString * path = NSStringFormat(@"pages/indexBox/index/index?pageType=collage&userId=%@&foundId=%ld&goodsId=%ld",[GVUserDefaults standardUserDefaults].userId,(long)weakSelf.mydetailmodel.result.groupInfo.groupId,(long)goodmodel.goodsId);
                    [[ShareTools sharedSingleton]shareToXCXWithType:XCXType_Pin path:path imageData:imgData title:title description:@""];
                }else{
                    [kWindow makeToast:@"请安装微信"];
                }
            };
        }
            
            break;
        case OrderStatus_WaitReceive: // 待收货
        {
            [self.view addSubview:self.twoBtnView];
            [self.twoBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.height.equalTo(49);
                make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
            }];
             [self.twoBtnView updateViewMesWithLeftBtnTitle:@"联系客服" RightTitle:@"确认收货"];
            self.twoBtnView.leftBlock = ^{
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
            
            };
            self.twoBtnView.rightBlock = ^{ // 确认收货
                [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_confirmOrder) parameters:@{@"parentOrderId":[NSNumber numberWithInteger:weakSelf.parentID],@"sonOrderId":[NSNumber numberWithInteger:weakSelf.sonID]}success:^(id  _Nonnull responseObject) {
                    if ([[responseObject objectForKey:@"code"]isEqualToString:@"0"]) {
                        [weakSelf setData];
                    }else{
                        [weakSelf.view makeToast:[responseObject objectForKey:@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {

                }];
            };
            
        }
            
            break;
         case OrderStatus_Cancel:
        {
            [self.view addSubview:self.oneBtnView]; // 订单结束  联系客服
            if (self.mydetailmodel.result.cart.count > 1) {
                self.oneBtnView.hidden = YES;
                [self.oneBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.height.equalTo(CGFLOAT_MIN);
                    make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
                }];
                [self.orderTable mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(self.view);
                    make.bottom.equalTo(self.view.bottom).offset(-kSafeAreaBottomHeight);
                }];
            }else{
                self.oneBtnView.hidden = NO;
                [self.oneBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.height.equalTo(49);
                    make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
                }];
            }
            self.oneBtnView.btnBlock = ^{
                OrderDetaiCartModel * shopmodel;
                if (weakSelf.mydetailmodel.result.cart.count) {
                    shopmodel = [weakSelf.mydetailmodel.result.cart objectAtIndex:0];
                }
            };
        }
            break;
            
        default:
            break;
    }
}

- (void)setData{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInteger:self.parentID] forKey:key_parentOrderId];
    if (self.sonID) {
        [params setValue:[NSNumber numberWithInteger:self.sonID] forKey:key_sonOrderId];
    }
    [self.view makeToastActivity];
    __weak typeof(self) weakSelf = self;
    [self.orderdetailMuarr removeAllObjects];
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_findOrderDetail) parameters:params success:^(id  _Nonnull responseObject) {
        [weakSelf.view hideToastActivity];
        RDLog(@"%@",responseObject);
        OrderDetaiModel * detailmodel = [OrderDetaiModel mj_objectWithKeyValues:responseObject];
        weakSelf.totalPrice = detailmodel.result.orderTotal.actualPay;
        if ([detailmodel.code isEqualToString:@"0"]) {
            weakSelf.mydetailmodel = detailmodel;
            OrderDetailManager * manager = [[OrderDetailManager alloc]init];
            [weakSelf.orderdetailMuarr addObjectsFromArray: [manager setOrderDetailUIWithModel:detailmodel.result
                                                                                     OrderType:detailmodel.result.orderTitle.orderType
                                                                                   OrderStatus:detailmodel.result.orderTitle.orderStatus]];
            weakSelf.orderStatus = detailmodel.result.orderTitle.orderStatus;
            self.orderSign = detailmodel.result.orderTime.orderSn;
            RDLog(@"%ld",(long)detailmodel.result.orderTime.createTime);
            [weakSelf updaUI];
            [weakSelf.orderTable reloadData];
        }else{
            [weakSelf.view makeToast:detailmodel.msg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- tabledelegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderdetailMuarr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderdetailCellModel * model = [self.orderdetailMuarr objectAtIndex:section];
    if (model.cellType == OrderDetailCellType_GoodsMes) {
        BFMallConfirmOrderSectionCell * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellheaderID];
        [headerView bindDetailModel];
//        if (!headerView) {
//            headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderCellHeaderView class]) owner:self options:nil]lastObject];
//        }
//        [headerView updateHeaderWithMoreShops:NO ShopName:model.shopName AndOrderStatus:@""];
        return headerView;
    }else{
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    OrderdetailCellModel * model = [self.orderdetailMuarr objectAtIndex:section];
    return model.cellmodelMuarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    OrderdetailCellModel * model = [self.orderdetailMuarr objectAtIndex:section];
    switch (model.cellType) {
        case OrderDetailCellType_Top: // 头部
            return CGFLOAT_MIN;
            break;
            
        case OrderDetailCellType_GoodsMes: // 商品
            return 29.f;
            break;
            
        case OrderDetailCellType_Time: // 订单时间
            return 8.f;
            break;
        case OrderDetailCellType_Total: // 订单汇总
            return CGFLOAT_MIN;
            break;
            
        default:
            break;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    OrderdetailCellModel * model = [self.orderdetailMuarr objectAtIndex:section];
    if ( model.cellType == OrderDetailCellType_GoodsMes) {
//        if (self.mydetailmodel.result.cart.count > 1) { // 多个店铺
//            OrderDetaiCartModel * carmodel = [self.mydetailmodel.result.cart objectAtIndex:section - 1];
//            if (carmodel.freight) {
//                ConfirmOrderViewGoodsFootderView * footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:goodsmoreshopFooterID];
//                if (!footer) {
//                    footer = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConfirmOrderViewGoodsFootderView class]) owner:self options:nil]lastObject];
//                }
//                [footer updateFooterWithYunfei:NSStringFormat(@"￥%.2f",carmodel.freight) GoodsNum:model.goodsCount GoodsPrice:NSStringFormat(@"￥%.2f",carmodel.totalPrice)];
//                return footer;
//            }else{
//                GoodOneMesFooter * oneMesFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:goodsNoYunfeiFooterID];
//                if (!oneMesFooter) {
//                    oneMesFooter = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([GoodOneMesFooter class]) owner:self options:nil]lastObject];
//                }
//                [oneMesFooter updateMesWithGoodsCount:model.goodsCount GoodsPrice:NSStringFormat(@"￥%.2f",carmodel.totalPrice)];
//                return oneMesFooter;
//            }
//        }else{
            UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8.f)];
            footer.backgroundColor = UIColorFromHex(0xEEF1F3);
            return footer;
//        }
    }else if (model.cellType == OrderDetailCellType_Total) {
        UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8.f)];
        footer.backgroundColor = UIColorFromHex(0xEEEEEE);
        return footer;
    }else if (model.cellType != OrderDetailCellType_Total){
        UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8.f)];
        footer.backgroundColor = UIColorFromHex(0xEEF1F3);
        return footer;
    }else if (model.cellType != OrderDetailCellType_Top){
         OrderdetailCellModel * firstmodel = [self.orderdetailMuarr objectAtIndex:0];
        if (self.orderType == OrderType_Pintuan && firstmodel.cellmodelMuarr.count == 3) {
            UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 11)];
            footer.backgroundColor = UIColorFromHex(0xEEEEEE);
            return footer;
        }else{
            return nil;
        }
        
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    OrderdetailCellModel * model = [self.orderdetailMuarr objectAtIndex:section];
    switch (model.cellType) {
        case OrderDetailCellType_Top: // 头部
            
        {
//            OrderdetailCellModel * firstmodel = [self.orderdetailMuarr objectAtIndex:0];
                return 8.f;

//            if (self.orderType == OrderType_Pintuan && firstmodel.cellmodelMuarr.count == 3) {
//                return 8.f;
//            }else{
//                return CGFLOAT_MIN;
//            }
        }
            
           
            break;
        case OrderDetailCellType_GoodsMes: // 商品
//            if (self.mydetailmodel.result.cart.count > 1) { // 多个店铺
//                OrderDetaiCartModel * carmodel = [self.mydetailmodel.result.cart objectAtIndex:section - 1];
//                if (carmodel.freight) {
//                    return 80.f;
//                }else{
//                    return 40.f;
//                }
//            }else{ // 一个店铺
        {
             return 8.f;
        }
//            }
            break;
            
        case OrderDetailCellType_Time: // 订单时间
            return CGFLOAT_MIN;
            break;
        case OrderDetailCellType_Total: // 订单汇总
            return 8.f;
            break;
        default:
            break;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderdetailCellModel * model = [self.orderdetailMuarr objectAtIndex:indexPath.section];
    OrderdetailCellModel * cellmodel = [model.cellmodelMuarr objectAtIndex:indexPath.row];
    return cellmodel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderdetailCellModel * seconmodel = [self.orderdetailMuarr objectAtIndex:indexPath.section];
    OrderdetailCellModel * cellModel = [seconmodel.cellmodelMuarr objectAtIndex:indexPath.row];
    __weak typeof(self) weakSelf = self;
    switch (cellModel.cellType) {
        case OrderDetailCellType_topWaitpay: // 待付款
        {
            
            BFMallOrderDetailTopTwoLineCell * waitpayCell = [tableView dequeueReusableCellWithIdentifier:twolinecellID];
//            OrderDetailTopOneLineWithtimedownCell * waitpayCell = [tableView dequeueReusableCellWithIdentifier:toponelinewithtimedowncellID];
//            if (!waitpayCell) {
//                waitpayCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDetailTopOneLineWithtimedownCell class])
//                                                            owner:self
//                                                          options:nil]lastObject];
//            }
//            waitpayCell.mytimedownmodel = self.timedownmodel;
//            [waitpayCell updateCellMesWithTitle:cellModel.celltitle
//                                      HeadImage:cellModel.imageName
//                                       TimeDown:cellModel.timeDown];
            
            [waitpayCell udpateCellMesWithHeadImage:cellModel.imageName Status:cellModel.celltitle Suttitle:cellModel.subTitle TimeDownLblHidden:YES TimeDown:cellModel.timeDown];
            waitpayCell.timedownBlock = ^(TimedownModel *model) {
                if (!model.isTimeout) {
                    RDLog(@"倒计时结束");
                    weakSelf.threeBtnView.midBtn.backgroundColor = UIColorFromHexWithAlpha(0xccccccc, 0.6);
                    weakSelf.threeBtnView.midBtn.userInteractionEnabled = NO;
                    [weakSelf.threeBtnView.midBtn setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
                    weakSelf.threeBtnView.rightBtn.alpha = 0.5;
                    weakSelf.threeBtnView.rightBtn.userInteractionEnabled = NO;
                    [[NSNotificationCenter defaultCenter]postNotificationName:ResetOrderListPostName object:nil];
                }
                model.isTimeout = YES;
            };
            return waitpayCell;
        }
            break;
            
        case OrderDetailCellType_topTwoMes:
        {
            BFMallOrderDetailTopTwoLineCell * twomesCell = [tableView dequeueReusableCellWithIdentifier:twolinecellID];
//            if (!twomesCell) {
//                twomesCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDetailTopTwoLineCell class])
//                                                           owner:self
//                                                         options:nil]lastObject];
//            }
            [twomesCell udpateCellMesWithHeadImage:cellModel.imageName Status:cellModel.celltitle Suttitle:cellModel.subTitle TimeDownLblHidden:YES TimeDown:cellModel.timeDown];
            twomesCell.timedownBlock = ^(TimedownModel *model) {
                weakSelf.threeBtnView.midBtn.backgroundColor = UIColorFromHexWithAlpha(0xccccccc, 0.6);
                weakSelf.threeBtnView.midBtn.userInteractionEnabled = NO;
                [weakSelf.threeBtnView.midBtn setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
                weakSelf.threeBtnView.rightBtn.alpha = 0.5;
            };
            return twomesCell;
        }
            break;
            
        case OrderDetailCellType_topPindanTimedown:
        {
            BFMallOrderDetailTopTwoLineCell * twomesCell = [tableView dequeueReusableCellWithIdentifier:twolinecellID];
//            if (!twomesCell) {
//                twomesCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDetailTopTwoLineCell class])
//                                                           owner:self
//                                                         options:nil]lastObject];
//            }
           [twomesCell udpateCellMesWithHeadImage:cellModel.imageName Status:cellModel.celltitle Suttitle:cellModel.subTitle TimeDownLblHidden:NO TimeDown:cellModel.timeDown];
            twomesCell.timedownBlock = ^(TimedownModel *model) {
                weakSelf.threeBtnView.midBtn.backgroundColor = UIColorFromHexWithAlpha(0xccccccc, 0.6);
                weakSelf.threeBtnView.midBtn.userInteractionEnabled = NO;
                [weakSelf.threeBtnView.midBtn setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
                weakSelf.threeBtnView.rightBtn.alpha = 0.5;
            };
            return twomesCell;
        }
            break;
            
        case OrderDetailCellType_topOneMes:
        {
            BFMallOrderDetailTopTwoLineCell * twomesCell = [tableView dequeueReusableCellWithIdentifier:twolinecellID];
//            OrderDetailTopOneLineCell * topCell = [tableView dequeueReusableCellWithIdentifier:toponelinecellID];
//            if (!topCell) {
//                topCell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDetailTopOneLineCell class])
//                                                       owner:self
//                                                     options:nil].lastObject;
//            } // top
//            [topCell updatecellMesWithHeadImage:cellModel.imageName Status:cellModel.celltitle];
            [twomesCell udpateCellMesWithHeadImage:cellModel.imageName Status:cellModel.celltitle Suttitle:cellModel.subTitle TimeDownLblHidden:YES TimeDown:cellModel.timeDown];
            return twomesCell;
        }
            break;
            
        case OrderDetailCellType_Address:
        {
            BFMallConfirmOrderAddressCell * addressCell = [tableView dequeueReusableCellWithIdentifier:addresscellID];
//            if (!addressCell) {
//                addressCell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConfirmOrderTopWithMesCell class]) owner:self options:nil].lastObject;
//            } // 地址
            addressCell.arrowImg.hidden = YES;
            [addressCell updateCellMesWithName:cellModel.name Phone:cellModel.phone Address:cellModel.address];
            return addressCell;
        }
            break;
            
        case OrderDetailCellType_GoodsMes:
        {
            BFMallConfirmOrderGoodsCell *goodscell = [tableView dequeueReusableCellWithIdentifier:goodmescellID];
//            OrderDetailGoodsMesCell * goodscell = [tableView dequeueReusableCellWithIdentifier:goodmescellID];
//            if (!goodscell) {
//                goodscell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDetailGoodsMesCell class]) owner:self options:nil].lastObject;
//            }
            
            
            [goodscell updateCellMesWithGoodsImge:cellModel.goodsImage GoodsName:cellModel.goodsName GoodsGuige:cellModel.goodsGuige GoodsPrice:cellModel.goodsPrice GoodsCount:cellModel.goodsCount TuikanStatus:cellModel.tuikuanStatus GoodsVipPrice:cellModel.vipPrice];
            
            return goodscell;
        }
            break;
            
        case OrderDetailCellType_OrderTime:
        {
            OrderListMesCell * listmescell = [tableView dequeueReusableCellWithIdentifier:listmescellID];
            if (!listmescell) {
                listmescell =  [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderListMesCell class]) owner:self options:nil].lastObject;
            }
            [listmescell updateCellMessWithTitle:cellModel.celltitle Content:cellModel.content ButtonHidden:cellModel.buttonHidden];
            return listmescell;
        }
            break;
            
        case OrderDetailCellType_OrderTotal:
        {
            OrderDealMesCell * dealCell = [tableView dequeueReusableCellWithIdentifier:dealmescellID];
            if (!dealCell) {
                dealCell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDealMesCell class]) owner:self options:nil].lastObject;
            }
            [dealCell updateCellMesWithCellTitle:cellModel.celltitle CellContent:cellModel.content ContenColor:UIColorFromHex(0x333333)];
            return dealCell;
        }
            break;
            
        case OrderDetailCellType_Wuliu:
        {
            OrderDetailWuliuCell * wuliuCell = [tableView dequeueReusableCellWithIdentifier:wulilucellID];
            if (!wuliuCell) {
                wuliuCell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderDetailWuliuCell class]) owner:self options:nil].lastObject;
            } // 物流
            [wuliuCell updateCellMesWith:cellModel.wuliumes Time:cellModel.wuliuTime ButtonHidden:cellModel.isMoreBag];
            return wuliuCell;
        }
            break;
        case OrderDetailCellType_ActualPay:
        {
            OrderDealMesCell * paycountCell = [tableView dequeueReusableCellWithIdentifier:dealmescellID];
            if (!paycountCell) {
                paycountCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderPayCountCell class]) owner:self options:nil]lastObject];
            }
            [paycountCell updateCellMesWithCellTitle:@"实际付款：" CellContent:cellModel.content ContenColor:UIColorFromHex(0xFF7200)];
//            [paycountCell updateMoney:cellModel.content];
            return paycountCell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderdetailCellModel * seconmodel = [self.orderdetailMuarr objectAtIndex:indexPath.section];
    OrderdetailCellModel * cellModel = [seconmodel.cellmodelMuarr objectAtIndex:indexPath.row];
    switch (cellModel.cellType) {
        case OrderDetailCellType_GoodsMes: // 商品详情
        {
            BFMallGoodsDetailController * detail  = [[BFMallGoodsDetailController alloc]init];
            detail.goodsId = cellModel.goodsid;
            detail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail animated:NO];
        }
            break;
        case OrderDetailCellType_Wuliu: // 物流
        {
            if (self.mydetailmodel.result.logisticsInfo.isSplit) { //  是否拆单
                WuliuListViewController *wuliulist = [[WuliuListViewController alloc]init];
                wuliulist.parentID = self.parentID;
                wuliulist.sonID = self.sonID;
                [self.navigationController pushViewController:wuliulist animated:YES];
            }else{
//                BargainLogisticsController * wuliuVC = [[BargainLogisticsController alloc]init];
//                wuliuVC.logisticCode = self.mydetailmodel.result.logisticsInfo.shippingCode;
//                wuliuVC.shippingName = self.mydetailmodel.result.logisticsInfo.shippingName;
//                [self.navigationController pushViewController:wuliuVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)paySuccess:(BOOL)success channel:(NSString *)channel{
    RDLog(@"✅4");
    if (success) {
        RDLog(@"支付成功");
        [[NSNotificationCenter defaultCenter]postNotificationName:ResetOrderListPostName object:nil];
       
        BFMallPayResultController *paysuccessl = [[BFMallPayResultController alloc] init];
//            PaySuccessController * paysuccessl = [[PaySuccessController alloc]init];
//            if ([channel isEqualToString:@"1"]) {
//                [paysuccessl updateMesWith:@"微信支付" PayPrice:NSStringFormat(@"￥%.2f",_totalPrice)];
//            }else{
//                [paysuccessl updateMesWith:@"支付宝支付" PayPrice:NSStringFormat(@"￥%.2f",_totalPrice)];
//            }
//            if (self.mydetailmodel.result.cart.count > 1) {
//                paysuccessl.isUnpack = YES;
//            }else{
//                paysuccessl.isUnpack = NO;
//            }
//            paysuccessl.parentOrderSign = NSStringFormat(@"%ld",(long)self.parentID);
//            paysuccessl.sonOrderSign = NSStringFormat(@"%ld",(long)self.sonID);
        [paysuccessl updateMesWith:YES];
            paysuccessl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:paysuccessl animated:YES];
        
    }else{
        BFMallPayResultController *paysuccessl = [[BFMallPayResultController alloc] init];
        [paysuccessl updateMesWith:NO];
        paysuccessl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:paysuccessl animated:YES];
//            [self.view makeToast:@"交易失败"];
    }
}

#pragma mark --  setNav

- (UIButton *)set_leftButton{
     UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 更新UI

- (void)updateOrderDetailMesWithParentOrderID:(NSInteger)parentid
                                   SonOrderID:(NSInteger)orderid
                                    OrderType:(OrderType)ordertype
                                  OrderStatus:(OrderStatus)orderstatus{
    self.parentID = parentid;
    self.sonID = orderid;
    _orderType = ordertype;
    _orderStatus = orderstatus;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [kCountDownManager start];
}

- (void)dealloc{
    [kCountDownManager removeSourceWithIdentifier:self.timedownmodel.timedownSourceName];
//    [kCountDownManager invalidate];
    RDLog(@"✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨");
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
