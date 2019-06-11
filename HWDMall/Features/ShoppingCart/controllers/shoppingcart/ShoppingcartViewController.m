//
//  ShoppingcartViewController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingcartViewController.h"
#import "ConfirmOrderViewController.h"
#import "ConsigneeAddressController.h"
#import "ConfirmDealController.h" // 确认订单
#import "ConfirmDealAfterPayControllerViewController.h" // 拼单-发起-支付成功
#import "MyOrderFormController.h" // 我的订单
#import "MyOrderDetailController.h" // 订单详情

#define kTitle @"cellTitle"
#define kClassName @"className"


/* ----------- 购物车相关 -----------*/
#import "ShoppingcartHeader.h"
#import "BFMallShoppingcartHeaderView.h"

//#import "BFMallConfirmOrderVipRightsCell.h"
#import "BFMallIOrderVipChoiceCell.h"

#import "ShoppingcarGoodsCell.h"
#import "ShopcartTableViewProxy.h"
#import "BFMallPayBottomBar.h" // 底部支付bar
#import "ShoppingCartModel.h"
#import "ShoppingcartUnusebleHeader.h" // 不可用分组头
#import "ShoppingCartCustomModel.h" // 重组数据
#import "UpdateTotalPriceModel.h" // 更新价格
#import "HHDAlertView.h" // 提示框
#import "BFMallGoodsDetailController.h"

static NSString * const shoppingcartCellID = @"SHOPPINGCARTCELLID";
static NSString * const shoppingcartHeaderID = @"SHOPPINGCARTHEADERID";
static NSString * const shoppingcartUnuseHeaderID = @"SHOPPINGCARTUNUSERHEAD";
static NSString * const shoppingcartVipCellID = @"SHOPPINGCARTVIPCELLID";
static NSString * const nomesTitle = @"购物车空空如也，快去看看大家";

#define key_cartId @"cartId"
#define key_selected @"selected"

@interface ShoppingcartViewController ()
{
    BOOL _havemessage; // 有没有消息
    NSInteger _adType;
    NSString * _adID;
}
@property (nonatomic,strong) UITableView * viewList;
@property (nonatomic,strong) NSMutableArray * muData;
@property (nonatomic,strong) UIButton * closeBtn; // 全部关闭
@property (nonatomic,strong) ShopcartTableViewProxy * shopcartproxy;

@property (nonatomic, strong) BFMallShoppingcartHeaderView *topView;
@property (nonatomic, strong) BFMallPayBottomBar *bottomPayView; //BFMallPayBottom

@property (nonatomic,strong) ShoppingCartCustomModel * unusebleModel; // 不可用的商品
@property (nonatomic,strong) UpdateTotalResultModel *updateModel;
@property (nonatomic,assign) int pageNum; // 页码
@property (nonatomic,assign) int lastPageNum; //上一页页码
@property (nonatomic,strong) HHDAlertView * alertView;
@property (nonatomic,strong) NSMutableArray *selectedGoodsMuarr; // 手动选中商品数据
@property (nonatomic,strong) NSMutableArray *selectedShopMuarr; // 手动选中店铺的数据

@property (nonatomic,assign) BOOL haveGoods; // 是有否有商品
@property (nonatomic,assign) NSInteger shopCartCount;
@property (nonatomic,assign) NSInteger vipSelected;
@property (nonatomic) BOOL isAllSelected;

@end

@implementation ShoppingcartViewController
#pragma mark -- lazyload

- (BOOL)haveGoods{
    if (!_haveGoods) {
        _haveGoods = NO;
    }
    return _haveGoods;
}

- (NSMutableArray *)selectedGoodsMuarr{
    if (!_selectedGoodsMuarr) {
        _selectedGoodsMuarr = [[NSMutableArray alloc]init];
    }
    return _selectedGoodsMuarr;
}

- (NSMutableArray *)selectedShopMuarr{
    if (!_selectedShopMuarr) {
        _selectedShopMuarr = [[NSMutableArray alloc]init];
    }
    return _selectedShopMuarr;
}

- (HHDAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[HHDAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _alertView.mesStr = @"您确定要删除选中商品吗？";
    }
    return _alertView;
}

- (ShoppingCartCustomModel *)unusebleModel{
    if (!_unusebleModel) {
        _unusebleModel = [[ShoppingCartCustomModel alloc]init];
        _unusebleModel.isUsable = NO;
    }
    return _unusebleModel;
}


- (BFMallShoppingcartHeaderView *)topView {
    if (!_topView) {
        _topView = [[BFMallShoppingcartHeaderView alloc] initWithFrame:CGRectZero];
        _topView.isAllSelected = NO;
        __weak typeof(self) weakSelf = self;
        _topView.deleteBlock = ^{
            [weakSelf deleteAction];
        };
        _topView.selectedBlock = ^(BOOL btnStatus) {
            NSMutableArray * selectedMuarr = [[NSMutableArray alloc]init];
            if (btnStatus) { // 全部取消选中
                for (ShoppingCartCustomModel *sectionmodel in weakSelf.muData) {
                    sectionmodel.isSelectedStatus = NO;
                    for (ShoppingcartGoodsModel *goodsmodel in sectionmodel.shopGoodMuarr) {
                        goodsmodel.selected = NO;
                        [selectedMuarr addObject:goodsmodel];
                    }
                }
                [weakSelf.selectedGoodsMuarr removeAllObjects];
                weakSelf.topView.selectedBtn.selected = NO;
                [weakSelf getTotalMoney:[weakSelf setRuquestArr:selectedMuarr] IsAllSelected:YES paramsDic:nil];
            }else{// 全部选中
                for (ShoppingCartCustomModel *sectionmodel in weakSelf.muData) {
                    sectionmodel.isSelectedStatus = YES;
                    for (ShoppingcartGoodsModel *goodsmodel in sectionmodel.shopGoodMuarr) {
                        goodsmodel.selected = YES;
                        [selectedMuarr addObject:goodsmodel];
                        [weakSelf.selectedGoodsMuarr addObject:goodsmodel];
                    }
                }
                weakSelf.topView.selectedBtn.selected = YES;
                [weakSelf getTotalMoney:[weakSelf setRuquestArr:selectedMuarr] IsAllSelected:YES paramsDic:nil];
            }
            
        };
    }
    return _topView;
    
}

- (BFMallPayBottomBar *)bottomPayView {
    
    if (!_bottomPayView) {
        _bottomPayView = [[BFMallPayBottomBar alloc] initWithFrame:CGRectZero];
        _bottomPayView.hidden = YES;
        __weak typeof(self) weakSelf = self;

        _bottomPayView.payBlock = ^{
            [weakSelf balanceAction];
        };
    }
    return _bottomPayView;
    
}

- (ShopcartTableViewProxy *)shopcartproxy{
    if (!_shopcartproxy) {
        _shopcartproxy = [[ShopcartTableViewProxy alloc]init];
        _shopcartproxy.resultModel = self.updateModel;
        __weak typeof(self) weakSelf = self;
        
        _shopcartproxy.selectVipBlock = ^(BOOL state) {
        
            weakSelf.vipSelected = state;
            [weakSelf getTotalMoney:@[] IsAllSelected:weakSelf.isAllSelected paramsDic:nil];
        };
        
        _shopcartproxy.deleteUnuseBlock = ^{ // 全部删除不可用商品
            RDLog(@"删除全部");
            [kWindow addSubview:weakSelf.alertView];
            weakSelf.alertView.confirmBlock = ^{
                NSMutableArray * unusemodelCaridArr = [[NSMutableArray alloc]init];
                NSMutableArray * unusemodelCarIndexArr = [[NSMutableArray alloc]init];
                for (ShoppingcartGoodsModel * unmodel in weakSelf.unusebleModel.shopGoodMuarr) {
                    [unusemodelCaridArr addObject:[NSNumber numberWithInteger:unmodel.cartId]];
                }
                [weakSelf deleteGoods:unusemodelCaridArr IndexArr:nil];
            };
        };
        _shopcartproxy.shopcartProxyDeleteBlock = ^(NSIndexPath *indexPath) { // 删除某一个个商品
            RDLog(@"%ld",(long)indexPath.row);
                ShoppingCartCustomModel * sectionmodel = [weakSelf.muData objectAtIndex:indexPath.section];
                ShoppingcartGoodsModel * goodsmodel = [sectionmodel.shopGoodMuarr objectAtIndex:indexPath.row];
            if ([weakSelf.selectedGoodsMuarr containsObject:goodsmodel]) {
                [weakSelf.selectedGoodsMuarr removeObject:goodsmodel];
            }
                [weakSelf deleteGoods:@[[NSNumber numberWithInteger:goodsmodel.cartId]] IndexArr:@[indexPath]];
        };
        _shopcartproxy.shopcartProxyProductSelectBlock = ^(BOOL isSelected, NSIndexPath *indexPath) { // 选中某一行商品
            RDLog(@"%ld",(long)indexPath.row);
            ShoppingCartCustomModel * sectionmodel = [weakSelf.muData objectAtIndex:indexPath.section];
            ShoppingcartGoodsModel * goodsmodel = [sectionmodel.shopGoodMuarr objectAtIndex:indexPath.row];
            goodsmodel.selected = !isSelected;
            if (goodsmodel.selected) { // 选中
                if (![weakSelf.selectedGoodsMuarr containsObject:goodsmodel]) {
                    [weakSelf.selectedGoodsMuarr addObject:goodsmodel];
                }
            }else{
                if ([weakSelf.selectedGoodsMuarr containsObject:goodsmodel]) {
                    [weakSelf.selectedGoodsMuarr removeObject:goodsmodel];
                    [weakSelf.selectedShopMuarr removeObject:[NSNumber numberWithInteger:goodsmodel.shopId]];
                }
                weakSelf.topView.selectedBtn.selected = NO;
            }
            BOOL isSectionSelected = YES;
            for (ShoppingcartGoodsModel * model in sectionmodel.shopGoodMuarr) {
                if (model.selected == NO) {
                    isSectionSelected = NO;
                }
            }
            sectionmodel.isSelectedStatus = isSectionSelected;
            NSDictionary * paramdic = @{
                                        key_cartId:[NSNumber numberWithInteger:goodsmodel.cartId],
                                        key_selected:[NSNumber numberWithInteger:goodsmodel.selected]
                                        };
            
            [weakSelf getTotalMoney: @[paramdic] IsAllSelected:NO paramsDic:nil];
        };
        _shopcartproxy.shopcartProxyBrandSelectBlock = ^(BOOL isSelected, NSInteger section) { // 选中某一组商品
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            RDLog(@"%ld",(long)section);
            ShoppingCartCustomModel * sectionmodel = [weakSelf.muData objectAtIndex:section];
            sectionmodel.isSelectedStatus = !isSelected;
            
            if (sectionmodel.isSelectedStatus) { // 选中
                for (ShoppingcartGoodsModel * shopmodel in sectionmodel.shopGoodMuarr) {
                    if (![weakSelf.selectedGoodsMuarr containsObject:shopmodel]) {
                        [weakSelf.selectedGoodsMuarr addObject:shopmodel];
                    }
                }
                [weakSelf.selectedShopMuarr addObject:[NSNumber numberWithInteger:sectionmodel.shopid]];
                [params setValue:[NSNumber numberWithInteger:sectionmodel.shopid] forKey:@"shopId"];
                [params setValue:@1 forKey:@"shopSelected"];
            }else{ // 取消选中
                for (ShoppingcartGoodsModel * shopmodel in sectionmodel.shopGoodMuarr) {
                    if ([weakSelf.selectedGoodsMuarr containsObject:shopmodel]) {
                        [weakSelf.selectedGoodsMuarr removeObject:shopmodel];
                    }
                }
                [weakSelf.selectedShopMuarr removeObject:[NSNumber numberWithInteger:sectionmodel.shopid]];
                weakSelf.topView.selectedBtn.selected = NO;
                [params setValue:[NSNumber numberWithInteger:sectionmodel.shopid] forKey:@"shopId"];
                [params setValue:@0 forKey:@"shopSelected"];
            }
            
            for (ShoppingcartGoodsModel * amodel in sectionmodel.shopGoodMuarr) {
                amodel.selected = sectionmodel.isSelectedStatus;
            }

            [weakSelf getTotalMoney:@[] IsAllSelected:NO paramsDic:params];
        };
        _shopcartproxy.shopcartProxyChangeCountBlock = ^(NSInteger count, NSIndexPath *indexPath) { // 改变某个cell个数
            RDLog(@"%ld,%ld",(long)indexPath.row,(long)count);
            if (weakSelf.muData.count) {
                ShoppingCartCustomModel * sectionmodel = [weakSelf.muData objectAtIndex:indexPath.section];
                ShoppingcartGoodsModel * goodsmodel = [sectionmodel.shopGoodMuarr objectAtIndex:indexPath.row];
                goodsmodel.goodsNum = count;
                if (goodsmodel.selected) { // 是否选中 选中请求总商品价格接口
                    [weakSelf getTotalMoney: [weakSelf setRuquestArr:@[goodsmodel]]IsAllSelected:NO paramsDic:nil];
                }else{
                    NSIndexPath *indexPathArr=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                    [weakSelf.viewList reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathArr,nil] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        };
        
        _shopcartproxy.selectedBlock = ^(NSIndexPath *indexPath) {
            ShoppingCartCustomModel * sectionmodel = [weakSelf.muData objectAtIndex:indexPath.section];
            ShoppingcartGoodsModel * goodsmodel = [sectionmodel.shopGoodMuarr objectAtIndex:indexPath.row];
            
            BFMallGoodsDetailController * goodsdetail = [[BFMallGoodsDetailController alloc]init];
            goodsdetail.goodsId = goodsmodel.goodsId;
            goodsdetail.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:goodsdetail animated:NO];
        };
        
        _shopcartproxy.selectAllBlock = ^(BOOL btnStatus) {
            NSMutableArray * selectedMuarr = [[NSMutableArray alloc]init];
            if (btnStatus) { // 全部取消选中
                for (ShoppingCartCustomModel *sectionmodel in weakSelf.muData) {
                    sectionmodel.isSelectedStatus = NO;
                    for (ShoppingcartGoodsModel *goodsmodel in sectionmodel.shopGoodMuarr) {
                        goodsmodel.selected = NO;
                        [selectedMuarr addObject:goodsmodel];
                    }
                }
                [weakSelf.selectedGoodsMuarr removeAllObjects];
                weakSelf.topView.selectedBtn.selected = NO;
                [weakSelf getTotalMoney:[weakSelf setRuquestArr:selectedMuarr] IsAllSelected:YES paramsDic:nil];
            }else{// 全部选中
                for (ShoppingCartCustomModel *sectionmodel in weakSelf.muData) {
                    sectionmodel.isSelectedStatus = YES;
                    for (ShoppingcartGoodsModel *goodsmodel in sectionmodel.shopGoodMuarr) {
                        goodsmodel.selected = YES;
                        [selectedMuarr addObject:goodsmodel];
                        [weakSelf.selectedGoodsMuarr addObject:goodsmodel];
                    }
                }
                weakSelf.topView.selectedBtn.selected = YES;
                [weakSelf getTotalMoney:[weakSelf setRuquestArr:selectedMuarr] IsAllSelected:YES paramsDic:nil];
            }
        };
    }
    return _shopcartproxy;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, 22, 44);
        [_closeBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
- (NSMutableArray *)muData{
    if (!_muData) {
        _muData = [[NSMutableArray alloc]init];
        
    }
    return _muData;
}

- (UITableView *)viewList{
    if (!_viewList) {
        _viewList = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _viewList.separatorStyle = UITableViewCellSeparatorStyleNone;
        LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"man-没有订单"
                                                                 titleStr:@"购物车空空如也，快去看看大家"
                                                                detailStr:@"都在买什么吧～～～"
                                                              btnTitleStr:@""
                                                            btnClickBlock:^{}];
        //元素竖直方向的间距
        emptyView.subViewMargin = 5.f;
        emptyView.contentViewY = 130;
        emptyView.imageSize = CGSizeMake(SCREEN_W/3, 0.47*SCREEN_W/3);
        //标题颜色
        emptyView.titleLabTextColor = UIColorFromHex(0x999999);
        emptyView.detailLabTextColor = UIColorFromHex(0x999999);
        //描述字体
        emptyView.titleLabFont = kFont(13);
        emptyView.detailLabFont = kFont(13);
        _viewList.ly_emptyView = emptyView;
        
        _viewList.delegate = self.shopcartproxy;
        _viewList.dataSource = self.shopcartproxy;
        _viewList.tableFooterView = [UIView new];
        _viewList.backgroundColor = [UIColor whiteColor];
        
        [_viewList registerClass:[BFMallIOrderVipChoiceCell class] forCellReuseIdentifier:shoppingcartVipCellID];
        
        [_viewList registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingcarGoodsCell class]) bundle:nil] forCellReuseIdentifier:shoppingcartCellID];
        
//        [_viewList registerClass:[BFMallShoppingcartHeaderView class] forHeaderFooterViewReuseIdentifier:shoppingcartHeaderID];
//        [_viewList registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingcartHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:shoppingcartHeaderID];
        [_viewList registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingcartUnusebleHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:shoppingcartUnuseHeaderID];
        _viewList.estimatedRowHeight = 0;
        _viewList.estimatedSectionHeaderHeight = 0;
        _viewList.estimatedSectionFooterHeight = 0;
//        if (@available(iOS 11.0, *)) {
//            _viewList.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//        }else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
        __weak typeof(self) weakSelf = self;
        _viewList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = 1;
            weakSelf.lastPageNum = 1;
            [weakSelf.unusebleModel.shopGoodMuarr removeAllObjects];
            [weakSelf.selectedGoodsMuarr removeAllObjects];
            [weakSelf.muData removeAllObjects];
            [weakSelf setDataWithQueue:nil shouldReload:NO];
            [weakSelf getTotalMoney:@[]IsAllSelected:NO paramsDic:nil];
            [weakSelf.viewList.mj_footer resetNoMoreData];
        }];
        
        _viewList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageNum++;
            weakSelf.lastPageNum++;
            [weakSelf setDataWithQueue:nil shouldReload:NO];
        }];
    }
    return _viewList;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    _havemessage = YES;
    self.pageNum = 1;
    self.lastPageNum = 1;
    self.vipSelected = 0;
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"购物车"]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setNav];
    self.hideSlideRecognizer = NO;
    [self set_leftButton];
    self.shopCartCount = [GVUserDefaults standardUserDefaults].shopcartcount;

}

#pragma mark -- setUI

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

- (void)setUI{
    [self.view addSubview:self.viewList];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomPayView];
    [self.viewList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.bottomPayView.mas_top);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kSafeAreaTopHeight);
        make.height.equalTo(40);
        
    }];

    [self.bottomPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.height.equalTo(59);
    }];

//    [self.bottomPayView setUI];
    self.topView.hidden = YES;
}

- (UIButton *)set_leftButton{
    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

#pragma mark -- set and change data
- (void)getTotalMoney:(NSArray *)paramArr IsAllSelected:(BOOL)isAll paramsDic:(NSMutableDictionary *)paramsDic{
    self.isAllSelected = isAll;
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    if (paramsDic != nil) {
        NSArray *arr = @[paramsDic];
        [params setValue:arr forKey:@"shopItems"];
    }else if (isAll) {
        if (self.topView.selectedBtn.isSelected) {
            [params setValue:@1 forKey:@"isAllSelected"];
            [params setValue:@[] forKey:@"cartItems"];
        }else {
            [params setValue:@0 forKey:@"isAllSelected"];
            [params setValue:@[] forKey:@"cartItems"];
        }
    }else{
        [params setValue:paramArr forKey:@"cartItems"];
    }
    [params setValue:[NSNumber numberWithInteger:self.vipSelected] forKey:@"vipSelected"];
    
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_getTotalAndCheckCart) parameters:params success:^(id  _Nonnull responseObject) {
        RDLog(@"%@",responseObject);
        UpdateTotalPriceModel * updatemodel = [UpdateTotalPriceModel mj_objectWithKeyValues:responseObject];
        self.updateModel = updatemodel.result;
        self.shopcartproxy.resultModel = updatemodel.result;
        if ([updatemodel.code isEqualToString:@"0"]) {
            if (updatemodel.result.selectedNum != 0 && updatemodel.result.selectedNum == updatemodel.result.validNum) {
                weakSelf.topView.isAllSelected = YES;
            }else{
                weakSelf.topView.isAllSelected = NO;
            }
            [self.selectedShopMuarr removeAllObjects];
            for (UpdateShopModel *model in updatemodel.result.shopList) {
                if (model.shopSelected == 1) {
                    NSNumber *shopid = [NSNumber numberWithInteger:model.shopId];
                    [self.selectedShopMuarr addObject:shopid];
                }
                [self.shopcartproxy.dataArray enumerateObjectsUsingBlock:^(ShoppingCartCustomModel * sectionmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (model.shopId == sectionmodel.shopid) {
                        sectionmodel.isSelectedStatus = model.shopSelected;
                    }
                }];
            }
            [weakSelf.viewList reloadData];
            self.bottomPayView.totalMoney = NSStringFormat(@"￥%.2f",updatemodel.result.totalPrice);
            if (updatemodel.result.selectedNum) {
                weakSelf.haveGoods = YES;
            }else{
                weakSelf.haveGoods = NO;
            }
        }else{
            [weakSelf.view makeToast:updatemodel.msg];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"errr::::::::%@",error);
    }];
}

- (void)setDataWithQueue:(dispatch_queue_t)queue shouldReload:(BOOL)shouldReload{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithInt:self.pageNum] forKey:@"page"];
    [params setValue:@10 forKey:@"rows"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToastActivity];
    });
    __weak typeof(self) weakSelf = self;
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix ,kApi_findCartList) parameters:params success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view hideToastActivity];
        });
        [weakSelf.viewList.mj_footer endRefreshing];
        [weakSelf.viewList.mj_header endRefreshing];
        RDLog(@"%@",responseObject);
        ShoppingCartModel * cartmodel = [ShoppingCartModel mj_objectWithKeyValues:responseObject];
        if ([cartmodel.code isEqualToString:@"0"]) {
            if (!cartmodel.result.count) {
                [weakSelf.viewList.mj_footer endRefreshingWithNoMoreData];
            }else{
                weakSelf.bottomPayView.hidden = NO;
            }
            if (queue != nil && shouldReload) {
                [self.muData removeAllObjects];
            }
            if (queue != nil && self.pageNum <= self.lastPageNum) {
                if (self.pageNum == self.lastPageNum) {
                    [weakSelf dealData:cartmodel.result];
                    dispatch_resume(queue);
                    return;
                }else {
                    self.pageNum += 1;
                    [self setDataWithQueue:queue shouldReload:NO];
                    [weakSelf dealData:cartmodel.result];
        
                }
            }else {
                [weakSelf dealData:cartmodel.result];
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.view makeToast:cartmodel.msg];
            });
            if (queue != nil) {
                dispatch_resume(queue);
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (queue != nil) {
            dispatch_resume(queue);
        }
        [self dealData:@[]];
        [self.viewList reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view hideToastActivity];
        });
    }];
}

// 删除购物车商品或者失效商品
- (void)deleteGoods:(NSArray *)goodsShopids IndexArr:(NSArray *)indexarr{ // indexarr 为空 删除 无效商品
    [self.view makeToastActivity];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:goodsShopids forKey:@"cartIds"];

    if (self.selectedShopMuarr.count != 0 && indexarr == nil) {
        [params setValue:self.selectedShopMuarr forKey:@"shopIds"];
    }
    
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_deleteCartGoods) parameters:params success:^(id  _Nonnull responseObject) {
        RDLog(@"%@",responseObject);
        [weakSelf.view hideToastActivity];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
            if (indexarr.count) {
                for (NSIndexPath * index in indexarr) {
                    ShoppingCartCustomModel * model = [self.muData objectAtIndex:index.section];
                    ShoppingcartGoodsModel *goodsmodel = [model.shopGoodMuarr objectAtIndex:index.row];
                    if (model.shopGoodMuarr.count) {
                        [model.shopGoodMuarr removeObject:goodsmodel];
                    }
                    if (!model.shopGoodMuarr.count) {
                        [weakSelf.muData removeObject:model];
                    }
                }
                [weakSelf getTotalMoney:@[] IsAllSelected:self.topView.selectedBtn.isSelected paramsDic:nil];
            }else{
                [weakSelf.muData removeObject:self.unusebleModel];
            }
            if (!weakSelf.muData.count) {
                weakSelf.topView.hidden = YES;
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:PostCenterName object:nil];
            [weakSelf.viewList reloadData];
        }else{
            [weakSelf.view makeToast: [responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- deal data 处理数据
- (void)dealData:(NSArray *)dataArr{
    if (dataArr.count) {
        __weak typeof(self) weakSelf = self;
        for (ShoppingcartGoodsModel * goodsmodel in dataArr) { // 遍历添加的 商品model 数组
            if (goodsmodel.status == ShopingCartGoodsStatus_shangjia || goodsmodel.status == ShopingCartGoodsStatus_wuhuo) { // 判断商品 是否可用
                if (self.muData.count) { // 判断现有的数据源是否有数据
                    NSMutableArray * shopidMuarr = [[NSMutableArray alloc]init];
                    [self.muData enumerateObjectsUsingBlock:^(ShoppingCartCustomModel * custommodel, NSUInteger idx, BOOL * _Nonnull stop) { // 遍历现有的数据源
                        [shopidMuarr addObject:[NSNumber numberWithInteger:custommodel.shopid]];
                    }];
                    if ([shopidMuarr containsObject:[NSNumber numberWithInteger:goodsmodel.shopId]]) { // 已经有该店铺
                        RDLog(@"have shop");
                        int modelIndex = 0;
                        for (ShoppingCartCustomModel * acustommodel in self.muData) {
                            if (acustommodel.shopid == goodsmodel.shopId) {
                                modelIndex = (int)[self.muData indexOfObject:acustommodel];
                                break;
                            }
                        }
                        ShoppingCartCustomModel * contaitmodel = [self.muData objectAtIndex:modelIndex];
                        if (!goodsmodel.selected) {
                            contaitmodel.isSelectedStatus = NO;
                        }
                        [contaitmodel.shopGoodMuarr addObject:goodsmodel];
                    }else{ // 没有该店铺
                        ShoppingCartCustomModel * singlemodel = [[ShoppingCartCustomModel alloc]init];
//                        singlemodel.isSelectedStatus = YES;
                        singlemodel.shopid = goodsmodel.shopId;
                        singlemodel.shopName = goodsmodel.shopName;
                        if (!goodsmodel.selected) {
                            singlemodel.isSelectedStatus = NO;
                        }
                        [singlemodel.shopGoodMuarr addObject:goodsmodel];
                        [self.muData addObject:singlemodel];
                    }
                }else{ // 现有的数据源为空 创建店铺模型数组
                    ShoppingCartCustomModel * custommodel = [[ShoppingCartCustomModel alloc]init];
                    custommodel.isSelectedStatus = YES;
                    custommodel.shopName = goodsmodel.shopName;
                    custommodel.shopid = goodsmodel.shopId;
                    if (!goodsmodel.selected) {
                        custommodel.isSelectedStatus = NO;
                    }
                    [custommodel.shopGoodMuarr addObject:goodsmodel];
                    [self.muData addObject:custommodel];
                }
            }else{ // 不可用 添加到不可用店铺模型中
                [self.unusebleModel.shopGoodMuarr addObject:goodsmodel];
            }
            if (goodsmodel.selected) {
                [weakSelf.selectedGoodsMuarr addObject:goodsmodel];
            }
        }
        if (![self.muData containsObject:self.unusebleModel]) {
            if (self.unusebleModel.shopGoodMuarr.count) { // 店铺模型为空时
                [self.muData addObject:self.unusebleModel];
            }
        }
        
        if ([self.muData containsObject:self.unusebleModel]) {
            [self.muData removeObject:self.unusebleModel];
            [self.muData addObject:self.unusebleModel];
        }
        
        self.shopcartproxy.dataArray = self.muData; // 传递数据源
        for (NSNumber *sub in self.selectedShopMuarr) {
            [self.shopcartproxy.dataArray enumerateObjectsUsingBlock:^(ShoppingCartCustomModel * sectionmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                NSInteger shopId = [sub integerValue];
                if (shopId == sectionmodel.shopid) {
                    sectionmodel.isSelectedStatus = YES;
                }
            }];
        }
        [self.viewList reloadData]; // 刷新tableview
    }
    if (self.muData.count) {
        self.topView.hidden = NO;
    }else{ // 没有数据
        self.topView.hidden = YES;
    }
}

- (NSArray *)setRuquestArr:(NSArray *)selectedArr{  // 数组转换为commit数据数组
   
    NSMutableArray * paramMuarr = [[NSMutableArray alloc]init]; // commit数据数组
        __weak typeof(self) weakSelf = self;
       __block dispatch_semaphore_t sem = dispatch_semaphore_create(0); // gcd 信号量
        if (self.selectedGoodsMuarr.count) { // 判断现有选中的数据源是否为空
            [selectedArr enumerateObjectsUsingBlock:^(ShoppingcartGoodsModel * goodsmodel, NSUInteger idx, BOOL * _Nonnull stop) { // 遍历传递过来的数组

                if ([weakSelf.selectedGoodsMuarr containsObject:goodsmodel]) { // 判断现有的选中数组中是否包括传递过来的数据模型
                    if (!goodsmodel.selected) {
                        [weakSelf.selectedGoodsMuarr removeObject:goodsmodel];
                    }
//                    [weakSelf.selectedGoodsMuarr replaceObjectAtIndex:[weakSelf.selectedGoodsMuarr indexOfObject:goodsmodel] withObject:goodsmodel]; // 包含 --> 替换
                }else{
                    if (goodsmodel.selected) {
                        [weakSelf.selectedGoodsMuarr addObject:goodsmodel]; // 不包含 --> 添加
                    }
                }

                dispatch_semaphore_signal(sem); // 信号
            }];

        }else{ // 为空 添加
            [selectedArr enumerateObjectsUsingBlock:^(ShoppingcartGoodsModel * goodsmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (goodsmodel.selected) {
                        [weakSelf.selectedGoodsMuarr addObject:goodsmodel]; // 不包含 --> 添加
                    }
            }];
            dispatch_semaphore_signal(sem); // 信号
        }
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        for (ShoppingcartGoodsModel * parammodel in selectedArr) {
            NSDictionary * paramdic = @{
                                        key_cartId:[NSNumber numberWithInteger:parammodel.cartId],
                                        key_selected:[NSNumber numberWithInteger:parammodel.selected]
                                        };
            [paramMuarr addObject:paramdic];
        }
        
    return paramMuarr;
}

#pragma mark -- button Action

- (void)deleteAction{  // 底部删除功能
    if (self.haveGoods) {
        [kWindow addSubview:self.alertView];
        __weak typeof(self) weakSelf = self;
        self.alertView.confirmBlock = ^{
            [weakSelf.view makeToastActivity];
            NSMutableArray * selectedGoodsidMuarr = [[NSMutableArray alloc]init];
            for (ShoppingcartGoodsModel * goodsmodel in weakSelf.selectedGoodsMuarr) {
                [selectedGoodsidMuarr addObject:[NSNumber numberWithInteger:goodsmodel.cartId]];
            }
            NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
            [params setValue:selectedGoodsidMuarr forKey:@"cartIds"];
            if (weakSelf.topView.selectedBtn.isSelected) {
               [params setValue:@1 forKey:@"isAllSelected"];
            }
            if (self.selectedShopMuarr.count != 0) {
                [params setValue:weakSelf.selectedShopMuarr forKey:@"shopIds"];
            }
            [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_deleteCartGoods) parameters:params success:^(id  _Nonnull responseObject) {
                RDLog(@"%@",responseObject);
                [weakSelf.view hideToastActivity];
                if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
                    if (weakSelf.selectedGoodsMuarr.count) {
                        for (ShoppingcartGoodsModel * goodsmodel in weakSelf.selectedGoodsMuarr) {
                            [weakSelf.muData enumerateObjectsUsingBlock:^(ShoppingCartCustomModel * sectionmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                                [sectionmodel.shopGoodMuarr enumerateObjectsUsingBlock:^(ShoppingCartCustomModel * rowmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                                    if ([rowmodel isEqual:goodsmodel]) {
                                        [sectionmodel.shopGoodMuarr removeObject:rowmodel];
                                    }
                                }];
                                if (!sectionmodel.shopGoodMuarr.count) {
                                    [weakSelf.muData removeObject:sectionmodel];
                                }
                            }];
                        }
                        if (!weakSelf.muData.count) {
                            weakSelf.topView.hidden = YES;
                        }
                    }
                    [weakSelf.selectedGoodsMuarr removeAllObjects];
                    [weakSelf getTotalMoney:@[] IsAllSelected:NO paramsDic:nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:PostCenterName object:nil];
                    [weakSelf.viewList reloadData];
                }else{
                    [weakSelf.view makeToast: [responseObject objectForKey:@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
        };
    }else{
        [self.view makeToast:@"请选择商品"];
    }
    
}

- (void)balanceAction{
    /*
     hu@param buytype  BuyType_shopcart = 1, // 购物车 BuyType_Noshopcart, // 非购物车
     @param sku 商品标识 （当buyType=0时必传）
     @param quantity 商品数量 （当buyType=0时必传）
     @param grouponid 优惠券，非必填
     @param goodsaddress 地址，非必填
     @param usecoin 是否使用待金币，非必填
     @param foundid 拼团ID，非必填（拼团团员必填）
     @param activity 活动ID，非必填（活动订单必填）
     */
    if (self.haveGoods) {
        ConfirmOrderViewController * confirmorderVC = [[ConfirmOrderViewController alloc]init];
        [confirmorderVC commitOrderMessWith:OrderType_Mall BuyType:BuyType_shopcart Sku:0 Quantity:0 Grouponid:0 Address:nil UseCoin:0 Foundid:0 Activityid:0 GoodsID:0];
        confirmorderVC.isSelecVip = self.vipSelected;
        confirmorderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:confirmorderVC animated:YES];
    }else{
        [self.view makeToast:@"请选择商品"];
    }
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark -- viewwillappear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.pageNum = 1;
    [self.selectedGoodsMuarr removeAllObjects];
    [self.unusebleModel.shopGoodMuarr removeAllObjects];
    dispatch_queue_t queue1 = dispatch_queue_create("shoppingcart", NULL);
    dispatch_async(queue1, ^{
        dispatch_suspend(queue1);
        [self setDataWithQueue:queue1 shouldReload:YES];
    });
    dispatch_async(queue1, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([GVUserDefaults standardUserDefaults].isLogin || [GVUserDefaults standardUserDefaults].userType) {
                [self getTotalMoney:@[] IsAllSelected:NO paramsDic:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:PostCenterName object:nil];
                if (self.shopCartCount != [GVUserDefaults standardUserDefaults].shopcartcount) {
                    [self.viewList scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
                    self.shopCartCount = [GVUserDefaults standardUserDefaults].shopcartcount;
                }
            }
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
