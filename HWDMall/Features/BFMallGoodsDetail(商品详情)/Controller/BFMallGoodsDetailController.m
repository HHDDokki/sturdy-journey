//
//  BFMallGoodsDetailController.m
//  BFMan
//
//  Created by HandC1 on 2019/5/22.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallGoodsDetailController.h"
#import "BFMallShowBigimageController.h"
#import "BFMallDetailRightPopView.h"
#import "BFMallDetailBottomBar.h"
#import "BFMallGoodsDetailManager.h"
#import "BFMallGoodsDetailModel.h"
#import "GoodsTypeView.h"

#import <SDWebImage/NSButton+WebCache.h>


/*   ---------------跳转页面-----------------   */
#import "LoginViewController.h"  // 登录
#import "ShoppingcartViewController.h" // 购物车
#import "MyOrderFormController.h" // 我的订单
#import "BFMallMyCollectionController.h" // 我的收藏
#import "ConsigneeAddressController.h" // 地址管理
#import "ConfirmOrderViewController.h" // 填写订单
#import "BFMallMyCollectionController.h" // 我的收藏
#import "WebMemberController.h" // H5


#define BOTTOM_H 61

@interface BFMallGoodsDetailController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, OpenCusDelegate>

//主view控制器
@property (nonatomic, strong) BFMallGoodsDetailManager *manager;
//大图显示c
@property (nonatomic, strong) BFMallShowBigimageController  *showBigImageView;
//底部view
@property (nonatomic, strong) BFMallDetailBottomBar *bottomBar;
//规格弹窗
@property (nonatomic, strong) GoodsTypeView *goodsTypeView;

@property (nonatomic, strong) BFMallGoodsDetailModel *detail_model;
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *rootBtn;
@property (nonatomic, strong) UIButton *mainPopBtn;
@property(nonatomic, assign) int cartCount;


//sku 数据源
@property(nonatomic, strong) NSMutableArray *skuListArr;
@property(nonatomic, strong) NSMutableArray *skuDataSource;
@property(nonatomic, strong) NSMutableDictionary *specDTO;
@property(nonatomic, strong) NSMutableDictionary *userAddress;

@end

@implementation BFMallGoodsDetailController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self bf_setButtonImageWithUrl:[GVUserDefaults standardUserDefaults].headImg];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.goodsId = 10823;
    [self setNavigationView];
    [self setNavigationBackButton];
    [self setNavigationContentView];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self loadData];
}

- (void)loadData {
    [self.view makeToastActivity];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self loadAllInfoDataWithGroup:group];

    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self loadFindSpecDataWithGroup:group GoodsId:self.goodsId];

    });
    if ([GVUserDefaults standardUserDefaults].userType != 0) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            
            [self loadCartCountDataWithGroup:group];
            
        });
    }
    dispatch_group_notify(group, queue, ^{
    
        if (self.detail_model != nil) {
            [self.modelArr addObject:self.detail_model];
            
        }else {
            return ;
        }
        
        [self createMainView];
        
    });
}

#pragma mark - 网络请求
//详情数据1
-(void)loadAllInfoDataWithGroup:(dispatch_group_t)group {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[NSNumber numberWithInteger:self.goodsId] forKey:@"goodsId"];
//    NSString *url =NSStringFormat(@"%@%@%@",@"http://47.93.216.16:7081",kApi_findAllInfoById,@"");
    NSString *url =NSStringFormat(@"%@%@%@",@"http://47.93.216.16:7081",kApi_findAllInfoById,@"");
    [[WebServiceTool shareHelper]postWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        if([self isErrorResponse:responseObject]) {
            dispatch_group_leave(group);
            return;
        }
        BFMallGoodsDetailModel *detailModel = [[BFMallGoodsDetailModel alloc] initWithDictionary:responseObject[@"result"] error:nil];
        self.detail_model = detailModel;
        NSArray *imgDetailArr = self.detail_model.imgDetail;
        self.detail_model.imgDetail = imgDetailArr;
        if (group) {
            dispatch_group_leave(group);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (group) {
            dispatch_group_leave(group);
        }
    }];
}

- (void)loadFindSpecDataWithGroup:(dispatch_group_t)group GoodsId:(NSInteger)goodsId{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSNumber numberWithInteger:self.goodsId] forKey:@"goodsId"];
    NSString *url =NSStringFormat(@"%@%@%@",@"http://47.93.216.16:7081",kApi_findSpecByGoodsId,@"");
    [[WebServiceTool shareHelper]postWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        if([self isErrorResponse:responseObject]) {
            dispatch_group_leave(group);
            //            [self hideHUD];
            return;
        }
        NSDictionary *result = responseObject[@"result"];
        //传递数据源
        //        NSMutableArray *skuDataSource = [NSMutableArray array];
        //        NSMutableArray *skuListArrr = [NSMutableArray array];
        
        NSMutableArray *existsArr = [NSMutableArray arrayWithArray:result[@"exists"]];
        [self.skuDataSource removeAllObjects];
        for (int i = 0; i< existsArr.count; i++) {
            
            NSArray *items = existsArr[i][@"items"];
            NSMutableArray *values = [NSMutableArray array];
            NSMutableArray *idd = [NSMutableArray array];
            for (int j = 0; j<items.count; j++) {
                [values addObject:items[j][@"item"]];
                [idd addObject:[NSString stringWithFormat:@"%@",items[j][@"id"]]];
            }
            NSDictionary *dicName = @{@"name":existsArr[i][@"name"]
                                      ,@"value":values
                                      ,@"idd":idd
                                      };
            
            
            [self.skuDataSource addObject:dicName];
        }
        //规格12.20增加价格集合
        [self.specDTO removeAllObjects];
        self.specDTO = [result[@"specDTO"] mutableCopy];
        
        NSMutableArray *skuListArr = [NSMutableArray arrayWithArray:result[@"skuList"]];
        [self.skuListArr removeAllObjects];
        for (int i = 0; i < skuListArr.count; i++) {
            
            if (skuListArr.count == 1) {
                NSString *contition = [NSString stringWithFormat:@"%@",skuListArr[i][@"key"]];
                NSDictionary *skuData = @{@"contition":contition
                                          ,@"idd":[NSString stringWithFormat:@"%@",skuListArr[i][@"id"]]
                                          ,@"maxPrice":skuListArr[i][@"maxPrice"] == [NSNull null] ? @0 : skuListArr[i][@"maxPrice"]
                                          ,@"originalImg":skuListArr[i][@"originalImg"] == [NSNull null] ? @0 : skuListArr[i][@"originalImg"]
                                          ,@"promPrice":skuListArr[i][@"promPrice"] == [NSNull null] ? @0 : skuListArr[i][@"promPrice"]
                                          ,@"singlePrice":skuListArr[i][@"singlePrice"] == [NSNull null] ? @0 : skuListArr[i][@"singlePrice"]
                                          ,@"stock":skuListArr[i][@"stock"] == [NSNull null] ? @0 : skuListArr[i][@"stock"]
                                          ,@"teamPrice":skuListArr[i][@"teamPrice"] == [NSNull null] ? @0 : skuListArr[i][@"teamPrice"]
                                          ,@"teamMaxPrice":skuListArr[i][@"teamMaxPrice"] == [NSNull null] ? @0 : skuListArr[i][@"teamMaxPrice"]
                                          
                                          };
                [self.skuListArr addObject:skuData];
            }else{
                
                NSArray *array = [skuListArr[i][@"key"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"_"]];
                //            [skuListArr[i][@"key"] componentsSeparatedByString:@"_"];
                NSString *contition;
                if (array.count == 1) {
                    contition = [NSString stringWithFormat:@"%@",array[0]];
                }else{
                    contition = [NSString stringWithFormat:@"%@,%@",array[0],array[1]];
                }
                
                //            [skuData setValue:contition forKey:@"contition"];
                
                NSDictionary *skuData = @{@"contition":contition
                                          ,@"idd":[NSString stringWithFormat:@"%@",skuListArr[i][@"id"]]
                                          ,@"maxPrice":skuListArr[i][@"maxPrice"] == [NSNull null] ? @0 : skuListArr[i][@"maxPrice"]
                                          ,@"originalImg":skuListArr[i][@"originalImg"] == [NSNull null] ? @0 : skuListArr[i][@"originalImg"]
                                          ,@"promPrice":skuListArr[i][@"promPrice"] == [NSNull null] ? @0 : skuListArr[i][@"promPrice"]
                                          ,@"singlePrice":skuListArr[i][@"singlePrice"] == [NSNull null] ? @0 : skuListArr[i][@"singlePrice"]
                                          ,@"stock":skuListArr[i][@"stock"] == [NSNull null] ? @0 : skuListArr[i][@"stock"]
                                          ,@"teamPrice":skuListArr[i][@"teamPrice"] == [NSNull null] ? @0 : skuListArr[i][@"teamPrice"]
                                          ,@"teamMaxPrice":skuListArr[i][@"teamMaxPrice"] == [NSNull null] ? @0 : skuListArr[i][@"teamMaxPrice"]
                                          };
                
                [self.skuListArr addObject:skuData];
            }
        }
        dispatch_group_leave(group);
        
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(group);
        if (self.shouldShowErr) {
            self.shouldShowErr = NO;
            //            [self hideHUD];
            [self showNetworkErrorAlert];
        }
    }];
}

//查询购物车数量
-(void)loadCartCountDataWithGroup:(dispatch_group_t)group {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *url =NSStringFormat(@"%@%@%@",@"http://47.93.216.16:7081",kApi_findCartCount,@"");
    [[WebServiceTool shareHelper] getWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        if([self isErrorResponse:responseObject]) {
            if (group) {
                dispatch_group_leave(group);
            }
            return;
        }
        NSDictionary *result = responseObject[@"result"];
        self.cartCount = [result[@"cartCount"] intValue];
        [self.bottomBar bindModel:self.detail_model carCount:NSStringFormat(@"%d",self.cartCount) BuyState:0];
        if (group) {
            dispatch_group_leave(group);
        }else {
            [[NSNotificationCenter defaultCenter]postNotificationName:PostCenterName object:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        if (group) {
            dispatch_group_leave(group);
        }
        if (self.shouldShowErr) {
            self.shouldShowErr = NO;
            [self showNetworkErrorAlert];
        }
    }];
    
}

// 加入购物车
- (void)addShoppingCartDataWithItemId:(NSInteger)itemId goodsNum:(NSInteger)goodsNum {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSDictionary *para = @{
                           @"itemId":[NSNumber numberWithInteger:itemId]
                           ,@"goodsNum":[NSNumber numberWithInteger:goodsNum]
                           };
    NSString *url =NSStringFormat(@"%@%@%@",@"http://47.93.216.16:7081",kApi_addGoodsToCart,@"");
    [[WebServiceTool shareHelper]postWithURLString:url parameters:para success:^(id  _Nonnull responseObject) {
        if([self isErrorResponse:responseObject]) {
            return;
        }
        [self loadCartCountDataWithGroup:nil];
        
    } failure:^(NSError * _Nonnull error) {
        if (self.shouldShowErr) {
            self.shouldShowErr = NO;
            [self showNetworkErrorAlert];
        }
    }];
    
}

- (void)createMainView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        if (!self.detail_model.isOnSale) {
//            [self showNullPage:@"抱歉，商品已下架"];
//            return ;
//        }
        [self.view hideToastActivity];
        self.manager = [[BFMallGoodsDetailManager alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        [self configProductViewWithModel:self.modelArr];
        [self creatMainTable];
        [self setupBottomBar];
        NSString *cartCount = NSStringFormat(@"%ld",(long)self.cartCount);
        [self.bottomBar bindModel:self.detail_model carCount:cartCount BuyState:0];

    });
    
}

- (void)creatMainTable {
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_W, SCREEN_H - BOTTOM_H - kSafeAreaBottomHeight - self.navigationView.bottom)];
    self.mainTable.backgroundColor = [UIColor whiteColor];
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.showsVerticalScrollIndicator = NO;
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.estimatedRowHeight = 0;
    self.mainTable.estimatedSectionFooterHeight = 0;
    self.mainTable.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.mainTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"detailImageCell"];
    [self.view addSubview:self.mainTable];
    
}

// 底部按钮
- (void)setupBottomBar {
    [self.view addSubview:self.bottomBar];
    WK(weakSelf);
    self.bottomBar.openGWCBlock = ^{
        
        if (![GVUserDefaults standardUserDefaults].isLogin) {
            
            LoginViewController *vc = [[LoginViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:NO];
            
        }else {
            //打开购物车
            ShoppingcartViewController *vc = [ShoppingcartViewController new];
            weakSelf.navigationController.navigationBar.hidden = NO;
            vc.fromDetailView = 1;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
}


#pragma mark -------------- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2 + self.detail_model.imgDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self getProductDetailCell:indexPath];
}

- (UITableViewCell *)getProductDetailCell:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 1) {
        
        NSString *cell_id = @"detailImageCell";
        UITableViewCell* cell = [self.mainTable dequeueReusableCellWithIdentifier:cell_id];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if (indexPath.row == 2) {
            UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
            topLabel.text = @"商品详情";
            topLabel.textColor = [UIColor hexColor:@"#2D3640"];
            topLabel.textAlignment = NSTextAlignmentCenter;
            topLabel.font = kBoldFont(17);
            [cell.contentView addSubview:topLabel];
            
        }
        [cell.contentView addSubview:[self.manager createDetailImageViewWithIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    NSString *ID_Pro = NSStringFormat(@"ProductDetailCell_%ld", (long)indexPath.row);
    UITableViewCell* cell = [self.mainTable dequeueReusableCellWithIdentifier:ID_Pro];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:ID_Pro];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    };
    [self bindCell:cell withIndex:indexPath.row];

    return cell;
}


- (void)bindCell:(UITableViewCell *)cell withIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            [cell.contentView addSubview:[self.manager setupHeaderScroll]];
            break;
        case 1:
            [cell.contentView addSubview:[self.manager setupNamePriceView]];
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        return [self.manager heightForRowAtIndex:indexPath.row] + 40;
    }
    return [self.manager heightForRowAtIndex:indexPath.row];
    
}


#pragma mark delegate
- (void)openCus:(NSInteger)tag {

    NSString *maxP = [NSString stringWithFormat:@"￥%.2lf",self.detail_model.maxPrice];
    NSString *minP = [NSString stringWithFormat:@"￥%.2lf",self.detail_model.minPrice];
    self.goodsTypeView = [[GoodsTypeView alloc] initWithHeight:kScreenHeight *3/5 SkuSource:self.skuDataSource SkuList:self.skuListArr MaxPrice:maxP MinPrice:minP imgStr:self.detail_model.originalImg Type:0 CurrentPrice:0];
    [self.view addSubview:self.goodsTypeView];
    [self.goodsTypeView showAnimating];
    
    ConfirmOrderViewController *corder = [ConfirmOrderViewController new];
    WK(weakSelf);
    if (tag == 101) {
        self.goodsTypeView.fuKuanBlock = ^(NSInteger goodsNum, NSString *address, int skuId) {
            
            NSInteger ItemId = skuId;
            [weakSelf addShoppingCartDataWithItemId:skuId goodsNum:goodsNum];
            
        };
        
    }else {
        self.goodsTypeView.fuKuanBlock = ^(NSInteger goodsNum, NSString *address, int skuId) {
            
            [corder commitOrderMessWith:OrderType_Mall BuyType:BuyType_Noshopcart Sku:skuId Quantity:goodsNum Grouponid:nil Address:address UseCoin:NO Foundid:nil Activityid:nil GoodsID:weakSelf.goodsId];
            corder.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:corder animated:true];
        };
        
    }
}

#pragma mark setup Detail View
- (void)configProductViewWithModel:(NSMutableArray *)modelArr {
    
    self.manager.baseController = self;
    [self creatProductViewPopBlock];
    [self.manager configWithModel:self.modelArr];
    
}
- (void)creatProductViewPopBlock {
    WK(weakSelf)
    //大图点击block
    self.manager.pictureBlock =
    ^(NSUInteger actionIndex, NSArray<NSString *> *arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arr.count < 1) {
                return;
            }
            weakSelf.showBigImageView = [[BFMallShowBigimageController alloc] initWithArray:arr selectedIndex:actionIndex];
            weakSelf.showBigImageView.view.frame = SCREEN_FRAME;
            [kWindow insertSubview:weakSelf.showBigImageView.view
                           atIndex:1909];
        });
    };
    
    self.manager.toBeVipBlock = ^{

        if (![GVUserDefaults standardUserDefaults].isLogin) {
            
            LoginViewController *vc = [[LoginViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:NO];
            
        }else {
            
            NSString *url = @"http://39.106.97.82:8107/payVip";
            WebMemberController *vc = [[WebMemberController alloc] init];
            vc.webUrl = url;
            vc.type = BFMALL_COMMON;
            [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
        }
    };
         
}

#pragma mark ------------------------  buttonClicked
- (void)mainPopBtnClick:(UIButton *)btn {
    
    if (![GVUserDefaults standardUserDefaults].isLogin) {
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        
    }else {
        
        [BFMallDetailRightPopView setTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]];
        if ([BFMallDetailRightPopView isShow]){
            
            [BFMallDetailRightPopView dismissMenu];
            
        } else {
            WK(weakSelf);
            [BFMallDetailRightPopView showMenuInView:self.view fromRect:btn.frame selected:^(NSInteger index, NSString * _Nonnull type) {

                if ([type isEqualToString:TYPE_SHOPPINGCART]) {
                    ShoppingcartViewController *vc = [[ShoppingcartViewController alloc] init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    vc.fromDetailView = 1;
                    [weakSelf.navigationController pushViewController:vc animated:NO];
                }
                else if ([type isEqualToString:TYPE_MYORDER]) {
                    
                    MyOrderFormController *orderController = [[MyOrderFormController alloc]init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    orderController.hidesBottomBarWhenPushed = YES;
                    orderController.currentIndex = 0;
                    [self.navigationController pushViewController:orderController animated:YES];
                    
                }else if ([type isEqualToString:TYPE_MYCOLLECTION]) {
                    
                    BFMallMyCollectionController *vc = [[BFMallMyCollectionController alloc] init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([type isEqualToString:TYPE_ADDRESS_MANAGER]) {
                    
                    ConsigneeAddressController *vc = [[ConsigneeAddressController alloc] init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([type isEqualToString:TYPE_BUY_VIP]) {
                    
                    
                    
                }
            }];
        }
        
    }

}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark -- lazyLoad
- (BFMallDetailBottomBar *)bottomBar {
    
    if (!_bottomBar) {
        CGRect barRect = CGRectMake(0, 0, SCREEN_W, BOTTOM_H);
        barRect.origin.y = SCREEN_H-kSafeAreaBottomHeight-BOTTOM_H;
        _bottomBar = [[BFMallDetailBottomBar alloc] initWithFrame:barRect];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:IMAGE_NAME(@"分享") forState:UIControlStateNormal];
//        [_shareBtn addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)rootBtn {
    if (!_rootBtn) {
        _rootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rootBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_rootBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rootBtn;
}

- (UIButton *)mainPopBtn {
    if (!_mainPopBtn) {
        _mainPopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainPopBtn setImage:IMAGE_NAME(@"我的") forState:UIControlStateNormal];
        [_mainPopBtn addTarget:self action:@selector(mainPopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainPopBtn;
}

- (NSMutableArray *)skuListArr{
    if (!_skuListArr) {
        _skuListArr = [NSMutableArray array];
    }
    return _skuListArr;
}

- (NSMutableArray *)skuDataSource{
    if (!_skuDataSource) {
        _skuDataSource = [NSMutableArray array];
    }
    return _skuDataSource;
}

- (NSMutableDictionary *)specDTO{
    if (!_specDTO) {
        _specDTO = [NSMutableDictionary dictionary];
    }
    return _specDTO;
}

- (NSMutableArray *)modelArr {
    
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
    
}

- (void)setNavigationContentView {
    
    [self.navigationView addSubview:self.shareBtn];
    [self.navigationView addSubview:self.mainPopBtn];
    [self.navigationView addSubview:self.rootBtn];
    
    [self.rootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView.mas_right).offset(-12);
        make.width.equalTo(22);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
        make.height.equalTo(22);
    }];

    [self.mainPopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rootBtn.mas_left).offset(-25);
        make.right.mas_equalTo(self.navigationView.mas_right);
        make.width.equalTo(22);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
        make.height.equalTo(22);
    }];

    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mainPopBtn.mas_left).offset(-25);
        make.width.equalTo(22);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
        make.height.equalTo(22);
    }];
    
}

//待封装
- (void)bf_setButtonImageWithUrl:(NSString *)urlStr {
    
    NSURL * url = [NSURL URLWithString:urlStr];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainPopBtn setImage:img forState:UIControlStateNormal];
        });
    });
    
}

@end
